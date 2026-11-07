#!/usr/bin/env python3
"""Fail the build if English sentences leak onto generated ja/ or ko/ pages.

Scans site/pages/{ja,ko}/**/*.html text nodes for runs of 3+ Latin words in a row.
On ko pages this catches strings that fell back to English for want of Korean.
Short runs (product/proper names like "NHK NEWS WEB EASY") are allowed via
ALLOWED_PHRASES; anything else is a translation gap.
"""

import re
import sys
from pathlib import Path

PAGE_DIRS = [Path('site/pages/ja'), Path('site/pages/ko')]

LEAK_RE = re.compile(r'\b[A-Za-z]{2,}(?:\s+[A-Za-z]{2,}){2,}\b')

# Proper nouns / product names legitimately kept as-is on ja pages.
ALLOWED_PHRASES = {
    'NHK NEWS WEB EASY',
}


def find_leaks():
    leaks = []
    for path in sorted(f for d in PAGE_DIRS for f in d.rglob('*.html')):
        text = path.read_text(encoding='utf-8')
        text_only = re.sub(r'<[^>]+>', ' ', text)
        for m in LEAK_RE.finditer(text_only):
            phrase = m.group(0)
            if any(phrase in allowed or allowed in phrase for allowed in ALLOWED_PHRASES):
                continue
            leaks.append((path, phrase))
    return leaks


def main():
    missing = [d for d in PAGE_DIRS if not d.exists()]
    if missing:
        print(f'{missing[0]} not found; run generate_pages.py first', file=sys.stderr)
        return 2

    leaks = find_leaks()
    if leaks:
        print(f'{len(leaks)} English leak(s) on ja/ko pages:')
        for path, phrase in leaks:
            print(f'  {path}: {phrase[:80]!r}')
        return 1

    print('No English leaks on ja/ko pages - OK')
    return 0


if __name__ == '__main__':
    sys.exit(main())
