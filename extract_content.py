#!/usr/bin/env python3
"""Extract all translatable content from minihongo HTML pages into CSV."""
import re
import csv
import html as html_mod
from pathlib import Path

SITE = Path('site/pages')
OUTPUT = Path('content.csv')

FIELDS = [
    'english', 'minihongo', 'japanese', 'english_litteral',
    'example_minihongo', 'example_english',
    'page', 'category',
]


def strip_ruby(s):
    """Remove furigana (<rt> content) from ruby tags."""
    s = re.sub(r'<rt>.*?</rt>', '', s)
    s = re.sub(r'</?ruby>', '', s)
    return s


def clean(s):
    """Strip furigana, then all HTML tags. Decode entities."""
    s = strip_ruby(s)
    s = re.sub(r'<br\s*/?>', '\n', s)
    s = re.sub(r'<[^>]+>', '', s)
    s = html_mod.unescape(s)
    return s.strip()


def R(**kw):
    d = {f: '' for f in FIELDS}
    d.update(kw)
    return d


# -- VOCABULARY -----------------------------------------------------------

def parse_vocabulary():
    text = (SITE / 'lessons/2-vocabulary.html').read_text()
    rows = []
    cat = ''

    for line in text.split('\n'):
        m = re.search(r'<h2 class="section-heading">(.*?)</h2>', line)
        if m:
            cat = clean(m.group(1))
            cat = re.sub(r'\s*[—-]\s*\d+$', '', cat)
            cat = re.sub(r'^\d+\.\s*', '', cat)
            continue

        m = re.search(
            r'<tr><td[^>]*>(.*?)</td><td>(.*?)</td><td[^>]*>(.*?)</td></tr>',
            line,
        )
        if m:
            word = clean(m.group(1))
            meaning = clean(m.group(2))
            example = clean(m.group(3))
            rows.append(R(
                english=meaning,
                minihongo=word,
                english_litteral=meaning,
                example_minihongo=example,
                page='vocabulary',
                category=cat,
            ))

    return rows


# -- GRAMMAR --------------------------------------------------------------

def parse_grammar():
    text = (SITE / 'lessons/3-grammar.html').read_text()
    rows = []
    section = ''

    parts = re.split(r'<h2 class="section-heading">', text)
    for part in parts[1:]:
        h2_m = re.match(r'(.*?)</h2>', part)
        if h2_m:
            section = clean(h2_m.group(1))

        for gp_m in re.finditer(
            r'<grammar-point>(.*?)</grammar-point>', part, re.DOTALL
        ):
            gp = gp_m.group(1)

            pat_m = re.search(r'<span slot="pattern">(.*?)</span>', gp)
            pattern = clean(pat_m.group(1)) if pat_m else ''

            exp_m = re.search(r'<span slot="explanation">(.*?)</span>', gp)
            explanation = clean(exp_m.group(1)) if exp_m else ''

            cat = f'{section} > {pattern}'

            # Explanation row
            rows.append(R(
                english=explanation,
                minihongo=pattern,
                page='grammar',
                category=f'{cat} [explanation]',
            ))

            # Example sentences
            for sent_m in re.finditer(
                r'<div class="sentence">(.*?)</div>', gp, re.DOTALL
            ):
                ps = re.findall(r'<p[^>]*>(.*?)</p>', sent_m.group(1), re.DOTALL)
                jp = clean(ps[0]) if ps else ''
                en = clean(ps[1]) if len(ps) > 1 else ''
                if jp:
                    rows.append(R(
                        english=en,
                        minihongo=jp,
                        page='grammar',
                        category=cat,
                    ))

    return rows


# -- WORD BUILDING --------------------------------------------------------

def parse_word_building():
    text = (SITE / 'lessons/5-word-building.html').read_text()
    rows = []
    h2 = ''
    h3_name = ''
    ttype = None

    for line in text.split('\n'):
        m = re.search(r'<h2 class="section-heading">(.*?)</h2>', line)
        if m:
            h2 = clean(m.group(1))
            continue

        m = re.search(r'<h3>(.*?)</h3>', line)
        if m:
            h3_name = clean(m.group(1))
            continue

        if '<thead>' in line:
            raw = clean(line)
            if 'Reading' in raw and 'Parts' in raw:
                ttype = 'compound'
            elif 'Reading' in raw and 'Minihongo' in raw:
                ttype = 'common'
            elif 'Literally' in raw:
                ttype = 'concept'
            elif 'Pattern' in raw:
                ttype = 'negation'
            else:
                ttype = 'concept'
            continue

        m = re.search(r'<tr>(.*?)</tr>', line)
        if m and ttype:
            cells = re.findall(r'<td[^>]*>(.*?)</td>', m.group(1))
            cat = f'{h2} > {h3_name}'

            if ttype == 'compound' and len(cells) >= 4:
                word = clean(cells[0])
                meaning = clean(cells[2])
                parts = clean(cells[3])
                rows.append(R(
                    english=meaning,
                    minihongo=word,
                    japanese=word,
                    english_litteral=parts,
                    page='word-building',
                    category=cat,
                ))

            elif ttype == 'common' and len(cells) >= 4:
                word = clean(cells[0])
                eng = clean(cells[2])
                mh = clean(cells[3])
                rows.append(R(
                    english=eng,
                    minihongo=mh,
                    japanese=word,
                    page='word-building',
                    category=cat,
                ))

            elif ttype in ('concept', 'negation') and len(cells) >= 3:
                concept = clean(cells[0])
                phrase = clean(cells[1])
                lit = clean(cells[2])
                rows.append(R(
                    english=concept,
                    minihongo=phrase,
                    english_litteral=lit,
                    page='word-building',
                    category=cat,
                ))

    return rows


# -- READING --------------------------------------------------------------

def _find_context(text, pos):
    """Find the most recent h2 and h3 headings before pos."""
    h2 = ''
    h3 = ''
    for m in re.finditer(r'<h2 class="section-heading">(.*?)</h2>', text):
        if m.start() < pos:
            h2 = clean(m.group(1))
    for m in re.finditer(r'<h3>(.*?)</h3>', text):
        if m.start() < pos:
            h3 = clean(m.group(1))
    return h2, h3


def parse_reading():
    text = (SITE / 'lessons/6-texts-dialogs.html').read_text()
    rows = []

    # Haiku
    for m in re.finditer(
        r'<div class="haiku">\s*<p[^>]*>(.*?)</p>\s*<p>(.*?)</p>\s*</div>',
        text, re.DOTALL,
    ):
        jp = clean(m.group(1)).replace('\n', ' / ')
        en = clean(m.group(2))
        h2, _ = _find_context(text, m.start())
        rows.append(R(
            english=en,
            minihongo=jp,
            page='reading',
            category=f'haiku > {h2}',
        ))

    # Dialogs
    for m in re.finditer(
        r'<div class="dialog">(.*?)</div>\s*<div class="dialog-translation">(.*?)</div>',
        text, re.DOTALL,
    ):
        h2, h3 = _find_context(text, m.start())
        jp_lines = re.findall(r'<p[^>]*>(.*?)</p>', m.group(1))
        en_lines = re.findall(r'<p[^>]*>(.*?)</p>', m.group(2))

        for jp_html, en_html in zip(jp_lines, en_lines):
            rows.append(R(
                english=clean(en_html),
                minihongo=clean(jp_html),
                page='reading',
                category=f'{h2} > {h3}',
            ))

    # Stories
    for m in re.finditer(
        r'<div class="story">(.*?)</div>\s*<div class="story-translation">(.*?)</div>',
        text, re.DOTALL,
    ):
        h2, h3 = _find_context(text, m.start())
        jp_paras = re.findall(r'<p[^>]*>(.*?)</p>', m.group(1))
        en_paras = re.findall(r'<p>(.*?)</p>', m.group(2))

        jp_text = ' '.join(clean(p) for p in jp_paras)
        en_text = ' '.join(clean(p) for p in en_paras)

        rows.append(R(
            english=en_text,
            minihongo=jp_text,
            page='reading',
            category=f'{h2} > {h3}',
        ))

    return rows


# -- MAIN -----------------------------------------------------------------

def main():
    all_rows = []
    all_rows.extend(parse_vocabulary())
    all_rows.extend(parse_grammar())
    all_rows.extend(parse_word_building())
    all_rows.extend(parse_reading())

    with open(OUTPUT, 'w', newline='', encoding='utf-8') as f:
        w = csv.DictWriter(f, fieldnames=FIELDS)
        w.writeheader()
        w.writerows(all_rows)

    pages = {}
    for r in all_rows:
        pages[r['page']] = pages.get(r['page'], 0) + 1

    print(f'Total: {len(all_rows)} rows')
    for page, count in sorted(pages.items()):
        print(f'  {page}: {count}')


if __name__ == '__main__':
    main()
