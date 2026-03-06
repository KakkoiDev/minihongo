#!/usr/bin/env python3
"""
Linter for the minihongo template engine syntax.

Checks:
  - Balanced block tags (for/endfor, if/endif)
  - Valid tag syntax (for, if, set, include)
  - Unclosed/malformed delimiters ({{ }}, {% %}, {# #})
  - Known filter names
  - Valid filter argument syntax
  - Include paths resolve to existing files

Usage:
  python site/lint.py                  # lint all templates + pages + components
  python site/lint.py site/templates/  # lint specific path
  python site/lint.py file.html        # lint single file
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
TEMPLATES = ROOT / "templates"
PAGES = ROOT / "pages"
COMPONENTS = ROOT / "components"

# Import engine internals for reuse
from engine import (
    _TAG_RE, _tokenize, _parse, _split_on,
    BUILTIN_FILTERS, TemplateError,
)


class LintError:
    __slots__ = ('file', 'line', 'col', 'msg')

    def __init__(self, file, line, col, msg):
        self.file = file
        self.line = line
        self.col = col
        self.msg = msg

    def __str__(self):
        loc = f"{self.file}:{self.line}"
        if self.col:
            loc += f":{self.col}"
        return f"{loc}: {self.msg}"


def _line_col(source, pos):
    """Convert char offset to (line, col)."""
    line = source[:pos].count('\n') + 1
    last_nl = source.rfind('\n', 0, pos)
    col = pos - last_nl
    return line, col


def _check_delimiters(source, filepath):
    """Check for unclosed/malformed delimiters."""
    errors = []
    openers = [('{{', '}}'), ('{%', '%}'), ('{#', '#}')]

    for open_d, close_d in openers:
        i = 0
        while i < len(source):
            pos = source.find(open_d, i)
            if pos < 0:
                break
            end = source.find(close_d, pos + len(open_d))
            if end < 0:
                line, col = _line_col(source, pos)
                errors.append(LintError(filepath, line, col,
                    f"Unclosed '{open_d}' - missing '{close_d}'"))
                break
            # Check for nested openers (likely a mistake)
            inner = source[pos + len(open_d):end]
            for o2, _ in openers:
                nest = inner.find(o2)
                if nest >= 0:
                    npos = pos + len(open_d) + nest
                    line, col = _line_col(source, npos)
                    errors.append(LintError(filepath, line, col,
                        f"Nested '{o2}' inside '{open_d}...{close_d}' block"))
            i = end + len(close_d)

    # Check for stray closing delimiters
    for open_d, close_d in openers:
        i = 0
        while i < len(source):
            pos = source.find(close_d, i)
            if pos < 0:
                break
            # Walk backwards to find matching opener
            search_start = max(0, pos - 5000)
            open_pos = source.rfind(open_d, search_start, pos)
            if open_pos < 0:
                line, col = _line_col(source, pos)
                errors.append(LintError(filepath, line, col,
                    f"Stray '{close_d}' without matching '{open_d}'"))
            i = pos + len(close_d)

    return errors


def _extract_filters(raw):
    """Extract filter names from an expression like 'var | f1 | f2: arg'."""
    parts = _split_on(raw, '|')
    filters = []
    for part in parts[1:]:
        name = part.strip().split(':')[0].strip()
        if name:
            filters.append(name)
    return filters


def _check_filter_args(raw, filepath, line):
    """Validate filter argument syntax."""
    errors = []
    parts = _split_on(raw, '|')
    for part in parts[1:]:
        part = part.strip()
        if ':' in part:
            fname = part.split(':', 1)[0].strip()
            args_str = part.split(':', 1)[1].strip()
            for arg in _split_on(args_str, ','):
                arg = arg.strip()
                if not arg:
                    continue
                eq = arg.find('=')
                if eq > 0 and arg[0] not in ('"', "'"):
                    key = arg[:eq].strip()
                    val = arg[eq+1:].strip()
                    if not key:
                        errors.append(LintError(filepath, line, 0,
                            f"Empty key in filter '{fname}' argument: {arg}"))
                    if not val:
                        errors.append(LintError(filepath, line, 0,
                            f"Empty value in filter '{fname}' argument: {arg}"))
    return errors


def _walk_ast(nodes, filepath, source, errors, known_filters):
    """Walk AST nodes checking filters and expressions."""
    for node in nodes:
        from engine import ExprNode, ForNode, IfNode, SetNode, IncludeNode

        if isinstance(node, ExprNode):
            line = _find_line_for_raw(source, node.raw)
            for fname in _extract_filters(node.raw):
                if fname not in known_filters:
                    errors.append(LintError(filepath, line, 0,
                        f"Unknown filter: '{fname}'"))
            errors.extend(_check_filter_args(node.raw, filepath, line))

        elif isinstance(node, ForNode):
            line = _find_line_for_raw(source, node.iter_raw)
            for fname in _extract_filters(node.iter_raw):
                if fname not in known_filters:
                    errors.append(LintError(filepath, line, 0,
                        f"Unknown filter: '{fname}'"))
            errors.extend(_check_filter_args(node.iter_raw, filepath, line))
            _walk_ast(node.body, filepath, source, errors, known_filters)
            _walk_ast(node.else_body, filepath, source, errors, known_filters)

        elif isinstance(node, IfNode):
            for cond, body in node.branches:
                line = _find_line_for_raw(source, cond)
                for fname in _extract_filters(cond):
                    if fname not in known_filters:
                        errors.append(LintError(filepath, line, 0,
                            f"Unknown filter: '{fname}'"))
                _walk_ast(body, filepath, source, errors, known_filters)
            _walk_ast(node.else_body, filepath, source, errors, known_filters)

        elif isinstance(node, SetNode):
            line = _find_line_for_raw(source, node.expr_raw)
            for fname in _extract_filters(node.expr_raw):
                if fname not in known_filters:
                    errors.append(LintError(filepath, line, 0,
                        f"Unknown filter: '{fname}'"))
            errors.extend(_check_filter_args(node.expr_raw, filepath, line))

        elif isinstance(node, IncludeNode):
            inc_path = TEMPLATES / node.path
            if not inc_path.exists():
                line = _find_line_for_raw(source, node.path)
                errors.append(LintError(filepath, line, 0,
                    f"Include file not found: '{node.path}'"))


def _find_line_for_raw(source, raw):
    """Find the line number where raw expression text appears."""
    pos = source.find(raw)
    if pos >= 0:
        return source[:pos].count('\n') + 1
    return 0


def lint_file(filepath, known_filters):
    """Lint a single template file. Returns list of LintError."""
    errors = []
    source = filepath.read_text()
    rel = filepath.relative_to(ROOT.parent) if filepath.is_relative_to(ROOT.parent) else filepath

    # 1. Check delimiters
    errors.extend(_check_delimiters(source, rel))

    # 2. Tokenize + parse (catches balance/syntax errors)
    try:
        tokens = _tokenize(source)
        nodes = _parse(tokens)
    except TemplateError as e:
        msg = str(e)
        # Try to find line number from the error message content
        line = 0
        # Extract tag content from error like "Missing {% endfor %}"
        m = re.search(r'\{%\s*(.+?)\s*%\}', msg)
        if m:
            line = _find_line_for_raw(source, m.group(1))
        if not line:
            # For "Missing closing tag" errors, report at end of file
            line = source.count('\n') + 1
        errors.append(LintError(rel, line, 0, msg))
        return errors

    # 3. Walk AST for filter/include validation
    _walk_ast(nodes, rel, source, errors, known_filters)

    return errors


def lint_all(paths=None):
    """Lint all template files or specific paths. Returns list of LintError."""
    known_filters = set(BUILTIN_FILTERS.keys())

    if paths:
        files = []
        for p in paths:
            p = Path(p).resolve()
            if p.is_file():
                files.append(p)
            elif p.is_dir():
                files.extend(sorted(p.rglob('*.html')))
    else:
        files = []
        for d in [TEMPLATES, PAGES, COMPONENTS]:
            if d.exists():
                files.extend(sorted(d.rglob('*.html')))

    errors = []
    file_count = 0
    for f in files:
        file_errors = lint_file(f, known_filters)
        errors.extend(file_errors)
        file_count += 1

    return errors, file_count


def main():
    paths = sys.argv[1:] if len(sys.argv) > 1 else None
    errors, file_count = lint_all(paths)

    if errors:
        for e in errors:
            print(f"  {e}")
        print(f"\n{len(errors)} error(s) in {file_count} file(s)")
        sys.exit(1)
    else:
        print(f"OK - {file_count} file(s) checked, no errors")


if __name__ == '__main__':
    main()
