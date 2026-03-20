#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.10"
# dependencies = ["segno"]
# ///
"""Generate Typst source files and compile to PDF for each language."""
import csv
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

DATA = Path('data')
TYPST_DIR = Path('typst')
LOGO = Path('site/static/logo.svg')

LANGS = ['en', 'ja', 'mh']
LANG_COL = {'en': 'english', 'ja': 'japanese', 'mh': 'minihongo'}
MEANING_COL = {'en': 'english', 'ja': 'japanese', 'mh': 'definition_minihongo'}
TITLE_COL = {'en': 'title_english', 'ja': 'title_japanese', 'mh': 'title_minihongo'}
EXPLANATION_COL = {'en': 'explanation_english', 'ja': 'explanation_japanese', 'mh': 'explanation_minihongo'}
SPEAKER_COL = {'en': 'speaker_english', 'ja': 'speaker_japanese', 'mh': 'speaker_minihongo'}
CAT_NAME_COL = {'en': 'name_english', 'ja': 'name_japanese', 'mh': 'name_minihongo'}

BOOK_TITLES = {
    'en': 'Minihongo',
    'ja': '\u30df\u30cb\u672c\u8a9e',
    'mh': '\u30df\u30cb\u672c\u8a9e',
}
BOOK_TAGLINES = {
    'en': '206 words. Say anything.',
    'ja': '206\u8a9e\u3067\u4f55\u3067\u3082\u8a00\u3048\u308b\u3002',
    'mh': '206\u306e\u8a00\u8449\u3002\u4f55\u3067\u3082\u8a00\u3048\u308b\u3002',
}

# Chapter titles per language
CH_VOCABULARY = {'en': 'Vocabulary', 'ja': '\u8a9e\u5f59', 'mh': '\u8a00\u8449'}
CH_GRAMMAR = {'en': 'Grammar', 'ja': '\u6587\u6cd5', 'mh': '\u8a00\u8449\u306e\u9053'}
CH_WORD_BUILDING = {'en': 'Word Building', 'ja': '\u9020\u8a9e', 'mh': '\u8a00\u8449\u4f5c\u308a'}
CH_READING = {'en': 'Reading', 'ja': '\u8aad\u307f\u7269', 'mh': '\u8aad\u307f\u7269'}

FURIGANA_RE = re.compile(r'([\u4e00-\u9fff]+)\u3010([^\u3011]+)\u3011')


def load_csv(name):
    with open(DATA / f'{name}.csv', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def by_sort(rows):
    return sorted(rows, key=lambda r: int(r['sort_order']))


def t(row, field, lang):
    """Get translated field with fallback: lang -> en -> mh."""
    for l in [LANG_COL[lang], 'english', 'minihongo']:
        col = f'{field}_{l}' if field else l
        val = row.get(col, '').strip()
        if val:
            return val
    return ''


UI_STRINGS = {}


def load_ui_strings():
    global UI_STRINGS
    for row in load_csv('ui_strings'):
        UI_STRINGS[row['key']] = row


def ui(key, lang):
    """Get UI string for a language with fallback to English."""
    row = UI_STRINGS.get(key, {})
    return to_ruby(row.get(lang, '') or row.get('en', ''))


def cat_name(cat, lang):
    """Get category name for display."""
    mh = cat.get('name_minihongo', '')
    translated = cat.get(CAT_NAME_COL[lang], '') or cat.get('name_english', '')
    if mh == translated or not translated:
        return mh
    return f'{mh} ({translated})'


def esc(text):
    """Escape Typst special characters."""
    if not text:
        return ''
    # Escape characters that are special in Typst markup
    text = text.replace('\\', '\\\\')
    text = text.replace('#', '\\#')
    text = text.replace('$', '\\$')
    text = text.replace('@', '\\@')
    text = text.replace('<', '\\<')
    text = text.replace('>', '\\>')
    text = text.replace('*', '\\*')
    text = text.replace('_', '\\_')
    text = text.replace('`', '\\`')
    text = text.replace('"', '\\"')
    return text


def to_ruby(text):
    """Convert bracket notation to Typst rubby package calls.
    rubby syntax: #ruby[reading][base] (reading first, base second)."""
    if not text:
        return ''

    parts = []
    last = 0
    for m in FURIGANA_RE.finditer(text):
        before = text[last:m.start()]
        parts.append(esc(before))
        kanji = esc(m.group(1))
        reading = esc(m.group(2))
        parts.append(f'#ruby[{reading}][{kanji}]')
        last = m.end()
    parts.append(esc(text[last:]))
    return ''.join(parts)


def strip_furigana(text):
    """Remove furigana brackets, keep kanji."""
    if not text:
        return ''
    return FURIGANA_RE.sub(r'\1', text)


def generate_qr_svg():
    """Generate QR code SVG for minihongo.com using segno."""
    qr_path = TYPST_DIR / 'qr.svg'
    if qr_path.exists():
        return
    try:
        import segno
        qr = segno.make('https://minihongo.com', error='H')
        qr.save(str(qr_path), scale=10, border=2, dark='#2B2B2B')
        print(f'  {qr_path}')
    except ImportError:
        # Fallback: create a placeholder
        print('  Warning: segno not installed, QR code will be a placeholder')
        qr_path.write_text(
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">'
            '<rect width="100" height="100" fill="#F7F7F7" rx="8"/>'
            '<text x="50" y="55" text-anchor="middle" font-size="10" fill="#666">QR</text>'
            '</svg>'
        )


class TypstWriter:
    """Builds a .typ source file."""

    def __init__(self, lang):
        self.lang = lang
        self.lines = []

    def raw(self, line=''):
        self.lines.append(line)

    def table_start(self, columns):
        """Start a rounded table with given columns."""
        self.raw('#rounded-table[#table(')
        self.raw(f'  columns: ({columns}),')
        self.raw('  stroke: none,')
        self.raw('  inset: (x: 8pt, y: 6pt),')
        self.raw('  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },')

    def table_end(self):
        self.raw(')]')
        self.raw()

    def heading(self, level, text):
        self.raw(f'{"=" * level} {to_ruby(text)}')
        self.raw()

    def build(self):
        return '\n'.join(self.lines) + '\n'


def write_cover(w, lang):
    title = BOOK_TITLES[lang]
    tagline = BOOK_TAGLINES[lang]
    w.raw(f'#cover-page("{esc(title)}", "{esc(tagline)}", "/site/static/logo.svg")')
    w.raw('#pagebreak()')
    w.raw()


def write_toc(w):
    w.raw('#outline(title: none, indent: 1.5em, depth: 3)')
    w.raw('#pagebreak()')
    w.raw()


def write_vocabulary(w, categories, words, lang):
    cats = by_sort([c for c in categories if c['page_id'] == 'vocabulary'])
    words_by_cat = defaultdict(list)
    for word in words:
        words_by_cat[word['category_id']].append(word)

    w.heading(1, CH_VOCABULARY[lang])

    for cat in cats:
        cat_words = by_sort(words_by_cat.get(cat['id'], []))
        if not cat_words:
            continue
        w.raw(f'== {to_ruby(cat_name(cat, lang))}')
        w.raw()

        # Note if present
        note = t(cat, 'note', lang)
        if note:
            w.raw(f'#note-block[{to_ruby(note)}]')
            w.raw()

        # Table
        w.table_start('1fr, 1fr, 1.5fr')
        w.raw(f'  table.header[*{ui("th_word", lang)}*][*{ui("th_meaning", lang)}*][*{ui("th_example", lang)}*],')
        for word in cat_words:
            mh = to_ruby(word['minihongo'])
            if lang == 'mh':
                meaning = to_ruby(word.get('definition_minihongo', '') or t(word, '', lang))
            else:
                meaning = to_ruby(t(word, '', lang))
            example = to_ruby(word['example_minihongo'])
            w.raw(f'  [{mh}], [{meaning}], [{example}],')
        w.table_end()

    w.raw('#pagebreak(weak: true)')
    w.raw()


def write_grammar(w, categories, grammar, grammar_examples, lang):
    cats = by_sort([c for c in categories if c['page_id'] == 'grammar'])
    gram_by_cat = defaultdict(list)
    for g in grammar:
        gram_by_cat[g['category_id']].append(g)
    ex_by_gram = defaultdict(list)
    for e in grammar_examples:
        ex_by_gram[e['grammar_id']].append(e)

    w.heading(1, CH_GRAMMAR[lang])

    for cat in cats:
        w.raw(f'== {to_ruby(cat_name(cat, lang))}')
        w.raw()

        for gp in by_sort(gram_by_cat.get(cat['id'], [])):
            raw_pattern = gp['minihongo']
            if lang == 'mh':
                raw_pattern = re.sub(r'\s*\([A-Za-z &/\-]+\)', '', raw_pattern).strip()
            pattern = to_ruby(raw_pattern)
            if lang == 'en' and gp.get('english'):
                en_name = esc(gp['english'])
                romaji_match = re.search(r'\(([A-Za-z &/\-]+)\)$', pattern)
                if romaji_match:
                    romaji = romaji_match.group(1)
                    pattern = pattern[:romaji_match.start()] + f'({romaji} - {en_name})'
                else:
                    pattern = f'{pattern} ({en_name})'

            explanation = to_ruby(gp.get(EXPLANATION_COL[lang], '') or t(gp, 'explanation', lang))

            ex_parts = []
            for ex in by_sort(ex_by_gram.get(gp['id'], [])):
                mh = to_ruby(ex['minihongo'])
                if lang == 'en':
                    translated = to_ruby(t(ex, '', lang))
                    ex_parts.append(f'#block(inset: (top: 0.2em, bottom: 0.2em))[{mh}\n#text(size: 8.5pt, fill: rgb("#666666"))[{translated}]]')
                else:
                    ex_parts.append(f'#block(inset: (top: 0.2em, bottom: 0.2em))[{mh}]')

            ex_content = '\n'.join(ex_parts)
            w.raw(f'#grammar-card[{pattern}][{explanation}][{ex_content}]')
            w.raw()

    w.raw('#pagebreak(weak: true)')
    w.raw()


def write_word_building(w, categories, compounds, expressions, lang):
    compounds_by_cat = defaultdict(list)
    for c in compounds:
        compounds_by_cat[c['category_id']].append(c)
    expressions_by_cat = defaultdict(list)
    for e in expressions:
        expressions_by_cat[e['category_id']].append(e)

    h2_cats = by_sort([c for c in categories
                       if c['page_id'] == 'word-building' and not c['parent_id']])
    children = defaultdict(list)
    for c in categories:
        if c['page_id'] == 'word-building' and c['parent_id']:
            children[c['parent_id']].append(c)
    for k in children:
        children[k] = by_sort(children[k])

    w.heading(1, CH_WORD_BUILDING[lang])

    wb_desc_keys = {
        'Real Kanji Compounds': 'wb_desc_compounds',
        'Common Words in Minihongo': 'wb_desc_common',
    }

    for h2 in h2_cats:
        w.raw(f'== {to_ruby(cat_name(h2, lang))}')
        w.raw()

        desc_key = wb_desc_keys.get(h2['name_english'], '')
        if desc_key:
            row = UI_STRINGS.get(desc_key, {})
            desc = row.get(lang, '') or row.get('en', '')
            if desc:
                w.raw(f'#text(size: 9pt, fill: rgb("#666666"))[{to_ruby(desc)}]')
                w.raw()
            if desc_key == 'wb_desc_compounds':
                warning_row = UI_STRINGS.get('wb_reading_warning', {})
                warning = warning_row.get(lang, '') or warning_row.get('en', '')
                if warning:
                    w.raw(f'#note-block[{to_ruby(warning)}]')
                    w.raw()

        for h3 in children.get(h2['id'], []):
            w.raw(f'=== {to_ruby(cat_name(h3, lang))}')
            w.raw()

            cat_compounds = by_sort(compounds_by_cat.get(h3['id'], []))
            cat_expressions = by_sort(expressions_by_cat.get(h3['id'], []))

            if cat_compounds:
                _write_compound_table(w, cat_compounds, lang)
            elif cat_expressions:
                has_japanese = any(e['japanese'] for e in cat_expressions)
                if has_japanese:
                    _write_common_table(w, cat_expressions, lang)
                else:
                    _write_concept_table(w, cat_expressions, lang)

    w.raw('#pagebreak(weak: true)')
    w.raw()


def _write_compound_table(w, rows, lang):
    w.table_start('1fr, 2fr')
    w.raw(f'  table.header[*{ui("th_word", lang)}*][*{ui("th_meaning", lang)}*],')
    for r in rows:
        word = f'#ruby[{esc(r["reading"])}][{esc(r["minihongo"])}]'
        if lang == 'mh':
            meaning = to_ruby(
                r.get('definition_minihongo', '') or r.get('english_litteral', '') or r['minihongo']
            )
        else:
            meaning = to_ruby(t(r, '', lang))
        w.raw(f'  [{word}], [{meaning}],')
    w.table_end()


def _write_common_table(w, rows, lang):
    if lang == 'mh':
        w.table_start('1fr')
        w.raw(f'  table.header[*{ui("th_minihongo", lang)}*],')
        for r in rows:
            mh = to_ruby(r['minihongo'])
            w.raw(f'  [{mh}],')
        w.table_end()
    else:
        w.table_start('1fr, 1fr')
        w.raw(f'  table.header[*{ui("th_minihongo", lang)}*][*{ui("th_meaning", lang)}*],')
        for r in rows:
            mh = to_ruby(r['minihongo'])
            meaning = esc(r['japanese'] if lang == 'ja' else r['english'])
            w.raw(f'  [{mh}], [{meaning}],')
        w.table_end()


def _write_concept_table(w, rows, lang):
    if lang == 'mh':
        has_defs = any(r.get('definition_minihongo') for r in rows)
        if has_defs:
            w.table_start('1fr, 1.5fr')
            w.raw(f'  table.header[*{ui("th_word", lang)}*][*{ui("th_meaning", lang)}*],')
            for r in rows:
                mh = to_ruby(r['minihongo'])
                defn = to_ruby(r.get('definition_minihongo', '') or '')
                w.raw(f'  [{mh}], [{defn}],')
            w.table_end()
        else:
            w.table_start('1fr')
            w.raw(f'  table.header[*{ui("th_word", lang)}*],')
            for r in rows:
                mh = to_ruby(r['minihongo'])
                w.raw(f'  [{mh}],')
            w.table_end()
    else:
        w.table_start('1fr, 1fr, 1fr')
        w.raw(f'  table.header[*{ui("th_concept", lang)}*][*{ui("th_minihongo", lang)}*][*{ui("th_literally", lang)}*],')
        for r in rows:
            concept = esc(r['english'])
            mh = to_ruby(r['minihongo'])
            literally = esc(r.get('english_litteral', ''))
            w.raw(f'  [{concept}], [{mh}], [{literally}],')
        w.table_end()


def write_reading(w, categories, haiku, dialog_groups, dialogs, stories, lang):
    haiku_by_cat = defaultdict(list)
    for h in haiku:
        haiku_by_cat[h['category_id']].append(h)
    dgrp_by_cat = defaultdict(list)
    for dg in dialog_groups:
        dgrp_by_cat[dg['category_id']].append(dg)
    dlg_by_grp = defaultdict(list)
    for d in dialogs:
        dlg_by_grp[d['dialog_group_id']].append(d)
    stories_by_cat = defaultdict(list)
    for s in stories:
        stories_by_cat[s['category_id']].append(s)

    h2_cats = by_sort([c for c in categories
                       if c['page_id'] == 'reading' and not c['parent_id']])
    children_map = defaultdict(list)
    for c in categories:
        if c['page_id'] == 'reading' and c['parent_id']:
            children_map[c['parent_id']].append(c)
    for k in children_map:
        children_map[k] = by_sort(children_map[k])

    w.heading(1, CH_READING[lang])

    for h2 in h2_cats:
        w.raw(f'== {to_ruby(cat_name(h2, lang))}')
        w.raw()

        subcats = children_map.get(h2['id'], [h2])
        for cat in subcats:
            if children_map.get(h2['id']):
                w.raw(f'=== {to_ruby(cat_name(cat, lang))}')
                w.raw()

            # Haiku
            for hk in by_sort(haiku_by_cat.get(cat['id'], [])):
                mh_lines = to_ruby(hk['minihongo']).replace(' / ', ' #linebreak() ')
                if lang == 'en':
                    trans = to_ruby(t(hk, '', lang))
                    w.raw(f'#haiku-block[{mh_lines}][{trans}]')
                else:
                    w.raw(f'#haiku-block[{mh_lines}][#none]')
                w.raw()

            # Dialogs
            for dg in by_sort(dgrp_by_cat.get(cat['id'], [])):
                title_mh = dg['title_minihongo']
                title_translated = t(dg, 'title', lang)
                if title_mh == title_translated or not title_translated:
                    title = to_ruby(title_mh)
                else:
                    title = f'{to_ruby(title_mh)} ({to_ruby(title_translated)})'

                lines_data = sorted(dlg_by_grp.get(dg['id'], []),
                                    key=lambda d: int(d['line_number']))

                lines_parts = []
                for ln in lines_data:
                    speaker = to_ruby(ln['speaker_minihongo'])
                    body = to_ruby(ln['minihongo'])
                    lines_parts.append(f'#block(inset: (top: 0.1em, bottom: 0.1em))[*{speaker}:* {body}]')

                trans_parts = []
                if lang != 'mh':
                    for ln in lines_data:
                        sp_col = SPEAKER_COL[lang]
                        speaker = to_ruby(ln.get(sp_col, '') or ln['speaker_minihongo'])
                        body = to_ruby(t(ln, '', lang))
                        trans_parts.append(f'#block(inset: (top: 0.05em, bottom: 0.05em))[*{speaker}:* {body}]')

                lines_content = '\n'.join(lines_parts)
                if trans_parts:
                    trans_content = '\n'.join(trans_parts)
                    w.raw(f'#dialog-block[{title}][{lines_content}][{trans_content}]')
                else:
                    w.raw(f'#dialog-block[{title}][{lines_content}][#none]')
                w.raw()

            # Stories
            for st in by_sort(stories_by_cat.get(cat['id'], [])):
                title_mh = st['title_minihongo']
                title_translated = t(st, 'title', lang)
                if title_mh == title_translated or not title_translated:
                    title = to_ruby(title_mh)
                else:
                    title = f'{to_ruby(title_mh)} ({to_ruby(title_translated)})'

                mh_text = st['minihongo']
                mh_paras = re.split(r'(?<=[\u3002\u300d]) ', mh_text)
                mh_paras = [p for p in mh_paras if p.strip()]
                paras_content = '\n'.join(
                    f'#block(inset: (top: 0.15em, bottom: 0.15em))[{to_ruby(p)}]'
                    for p in mh_paras
                )

                if lang != 'mh':
                    trans = to_ruby(t(st, '', lang))
                    w.raw(f'#story-block[{title}][{paras_content}][{trans}]')
                else:
                    w.raw(f'#story-block[{title}][{paras_content}][#none]')
                w.raw()


def write_back_cover(w):
    w.raw('#back-cover("minihongo.com")')


def generate_lang(lang, categories, words, grammar, grammar_examples,
                  compounds, expressions, haiku_data, dialog_groups,
                  dialogs, stories, print_mode=False):
    """Generate .typ file for one language."""
    w = TypstWriter(lang)

    title = BOOK_TITLES[lang]

    # Preamble
    w.raw(f'#import "template.typ": *')
    w.raw()
    print_str = 'true' if print_mode else 'false'
    w.raw(f'#show: book.with(title: "{esc(title)}", lang: "{lang}", print: {print_str})')
    w.raw()

    if not print_mode:
        write_cover(w, lang)
    write_toc(w)
    write_vocabulary(w, categories, words, lang)
    write_grammar(w, categories, grammar, grammar_examples, lang)
    write_word_building(w, categories, compounds, expressions, lang)
    write_reading(w, categories, haiku_data, dialog_groups, dialogs, stories, lang)
    if not print_mode:
        write_back_cover(w)

    suffix = '-interior' if print_mode else ''
    out_path = TYPST_DIR / f'minihongo-{lang}{suffix}.typ'
    out_path.write_text(w.build(), encoding='utf-8')
    print(f'  {out_path}')
    return out_path


def compile_typst(typ_path, pdf_path, inputs=None):
    """Compile .typ to PDF."""
    cmd = ['typst', 'compile', '--root', '.']
    for k, v in (inputs or {}).items():
        cmd.extend(['--input', f'{k}={v}'])
    cmd.extend([str(typ_path), str(pdf_path)])
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f'  ERROR compiling {typ_path}:', file=sys.stderr)
        print(result.stderr, file=sys.stderr)
        return False
    print(f'  {pdf_path}')
    return True


def get_page_count(pdf_path):
    """Get page count from a PDF using pdfinfo or typst query."""
    try:
        result = subprocess.run(
            ['pdfinfo', str(pdf_path)], capture_output=True, text=True,
        )
        for line in result.stdout.split('\n'):
            if line.startswith('Pages:'):
                return int(line.split(':')[1].strip())
    except FileNotFoundError:
        pass
    return 90  # fallback estimate


def spine_width_mm(page_count, paper_weight=0.0025):
    """Calculate spine width in mm. Lulu standard: ~0.0025in per page."""
    inches = page_count * paper_weight
    return round(inches * 25.4, 1)


def compile_cover(lang, page_count, spine_override=None):
    """Compile wraparound cover PDF (back + spine + front) for Lulu."""
    title = BOOK_TITLES[lang]
    tagline = BOOK_TAGLINES[lang]
    spine_mm = spine_override if spine_override else spine_width_mm(page_count)
    inputs = {
        'title': title,
        'tagline': tagline,
        'spine-width': str(spine_mm),
    }
    cover_pdf = Path(f'minihongo-{lang}-cover.pdf')
    print(f'  spine: {spine_mm}mm ({page_count} pages)')
    return compile_typst(TYPST_DIR / 'cover.typ', cover_pdf, inputs=inputs)


def parse_args():
    """Parse CLI arguments.
    Usage: generate_pdf.py [--print] [--spine MM] [--lang LANG]
    """
    args = {'print': False, 'spine': None, 'lang': None}
    i = 1
    while i < len(sys.argv):
        if sys.argv[i] == '--print':
            args['print'] = True
        elif sys.argv[i] == '--spine' and i + 1 < len(sys.argv):
            args['spine'] = float(sys.argv[i + 1])
            i += 1
        elif sys.argv[i] == '--lang' and i + 1 < len(sys.argv):
            lang = sys.argv[i + 1]
            if lang not in LANGS:
                print(f'Unknown language: {lang}. Choose from: {", ".join(LANGS)}', file=sys.stderr)
                sys.exit(1)
            args['lang'] = lang
            i += 1
        i += 1
    return args


def main():
    args = parse_args()
    print_mode = args['print']

    load_ui_strings()
    generate_qr_svg()

    categories = load_csv('categories')
    words = load_csv('words')
    grammar = load_csv('grammar')
    grammar_examples = load_csv('grammar_examples')
    compounds = load_csv('compounds')
    expressions = load_csv('expressions')
    haiku_data = load_csv('haiku')
    dialog_groups = load_csv('dialog_groups')
    dialogs = load_csv('dialogs')
    stories = load_csv('stories')

    data_args = (
        categories, words, grammar, grammar_examples,
        compounds, expressions, haiku_data, dialog_groups,
        dialogs, stories,
    )

    langs = [args['lang']] if args['lang'] else LANGS

    ok = True
    for lang in langs:
        typ_path = generate_lang(lang, *data_args, print_mode=print_mode)
        if print_mode:
            pdf_path = Path(f'minihongo-{lang}-interior.pdf')
        else:
            pdf_path = Path(f'minihongo-{lang}.pdf')
        if not compile_typst(typ_path, pdf_path):
            ok = False
            continue

        # In print mode, also generate wraparound cover (back + spine + front)
        if print_mode:
            page_count = get_page_count(pdf_path)
            if not compile_cover(lang, page_count, spine_override=args['spine']):
                ok = False

    if not ok:
        sys.exit(1)

    n = len(langs)
    if print_mode:
        print(f'\nDone: {n} interior + cover PDFs generated')
    else:
        print(f'\nDone: {n} PDFs generated')


if __name__ == '__main__':
    main()
