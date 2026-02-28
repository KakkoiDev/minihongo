#!/usr/bin/env python3
"""Extract minihongo content into relational CSV tables per SCHEMA.md."""
import re
import csv
import html as html_mod
import json
from pathlib import Path

SITE = Path('site/pages')
OUT = Path('data')


# -- Helpers ------------------------------------------------------------------

def ruby_to_bracket(s):
    """Convert HTML ruby tags to bracket notation: 人【ひと】"""
    return re.sub(r'<ruby>(.*?)<rt>(.*?)</rt></ruby>', r'\1【\2】', s)


def to_ruby_html(text):
    """Convert bracket notation to HTML ruby tags."""
    return re.sub(r'([\u4e00-\u9fff]+)【([^】]+)】', r'<ruby>\1<rt>\2</rt></ruby>', text)


def clean(s):
    """Convert ruby to bracket notation, then strip remaining HTML. Decode entities."""
    s = ruby_to_bracket(s)
    s = re.sub(r'<br\s*/?>', '\n', s)
    s = re.sub(r'<[^>]+>', '', s)
    s = html_mod.unescape(s)
    return s.strip()


def parse_bilingual(text):
    """Parse 'JP (EN)' heading into (minihongo, english).

    Strips leading numbers and trailing counts.
    """
    text = re.sub(r'^\d+\.\s*', '', text)
    text = re.sub(r'\s*[—-]\s*\d+$', '', text)
    m = re.match(r'(.+?)\s*\((.+)\)\s*$', text)
    if m:
        return m.group(1).strip(), m.group(2).strip()
    t = text.strip()
    return t, t


class IdGen:
    def __init__(self, prefix):
        self.prefix = prefix
        self.n = 0

    def next(self):
        self.n += 1
        return f'{self.prefix}-{self.n}'


# -- Global tables and ID generators -----------------------------------------

pages = [
    {'id': 'vocabulary', 'name_minihongo': '語彙',
     'name_english': 'Vocabulary', 'name_japanese': '', 'sort_order': 1},
    {'id': 'grammar', 'name_minihongo': '文法',
     'name_english': 'Grammar', 'name_japanese': '', 'sort_order': 2},
    {'id': 'word-building', 'name_minihongo': '言葉作り',
     'name_english': 'Word Building', 'name_japanese': '', 'sort_order': 3},
    {'id': 'reading', 'name_minihongo': '読み物',
     'name_english': 'Reading', 'name_japanese': '', 'sort_order': 4},
]

categories = []
words = []
grammar_rows = []
grammar_examples = []
compounds = []
expressions = []
haiku_rows = []
dialog_groups = []
dialog_rows = []
story_rows = []

_cat = IdGen('cat')
_word = IdGen('word')
_gram = IdGen('gram')
_gex = IdGen('gex')
_comp = IdGen('comp')
_expr = IdGen('expr')
_haiku = IdGen('haiku')
_dgrp = IdGen('dgrp')
_dlg = IdGen('dlg')
_story = IdGen('story')


def add_category(page_id, name_mh, name_en, sort, parent_id=''):
    cid = _cat.next()
    categories.append({
        'id': cid, 'parent_id': parent_id, 'page_id': page_id,
        'name_minihongo': name_mh, 'name_english': name_en,
        'name_japanese': '', 'sort_order': sort,
    })
    return cid


# -- Vocabulary ---------------------------------------------------------------

def parse_vocabulary():
    text = (SITE / 'lessons/2-vocabulary.html').read_text()
    cat_sort = 0
    word_sort = 0
    current_cat = ''

    for line in text.split('\n'):
        m = re.search(r'<h2 class="section-heading">(.*?)</h2>', line)
        if m:
            cat_sort += 1
            raw = clean(m.group(1))
            mh, en = parse_bilingual(raw)
            current_cat = add_category('vocabulary', mh, en, cat_sort)
            continue

        m = re.search(
            r'<tr><td[^>]*>(.*?)</td><td>(.*?)</td><td[^>]*>(.*?)</td></tr>',
            line,
        )
        if m and current_cat:
            word_sort += 1
            words.append({
                'id': _word.next(),
                'category_id': current_cat,
                'minihongo': clean(m.group(1)),
                'english': clean(m.group(2)),
                'japanese': '',
                'english_litteral': '',
                'example_minihongo': clean(m.group(3)),
                'example_english': '',
                'example_japanese': '',
                'sort_order': word_sort,
            })


# -- Grammar ------------------------------------------------------------------

def parse_grammar():
    text = (SITE / 'lessons/3-grammar.html').read_text()
    cat_sort = 0
    gram_sort = 0
    gex_sort = 0

    parts = re.split(r'<h2 class="section-heading">', text)
    for part in parts[1:]:
        h2_m = re.match(r'(.*?)</h2>', part)
        if not h2_m:
            continue
        cat_sort += 1
        raw = clean(h2_m.group(1))
        mh, en = parse_bilingual(raw)
        cat_id = add_category('grammar', mh, en, cat_sort)

        for gp_m in re.finditer(
            r'<grammar-point>(.*?)</grammar-point>', part, re.DOTALL
        ):
            gp = gp_m.group(1)
            gram_sort += 1

            pat_m = re.search(r'<span slot="pattern">(.*?)</span>', gp)
            pattern = clean(pat_m.group(1)) if pat_m else ''

            exp_m = re.search(r'<span slot="explanation">(.*?)</span>', gp)
            explanation = clean(exp_m.group(1)) if exp_m else ''

            gid = _gram.next()
            grammar_rows.append({
                'id': gid,
                'category_id': cat_id,
                'minihongo': pattern,
                'english': '',
                'japanese': '',
                'explanation_minihongo': '',
                'explanation_english': explanation,
                'explanation_japanese': '',
                'sort_order': gram_sort,
            })

            for sent_m in re.finditer(
                r'<div class="sentence">(.*?)</div>', gp, re.DOTALL
            ):
                ps = re.findall(
                    r'<p[^>]*>(.*?)</p>', sent_m.group(1), re.DOTALL
                )
                mh_text = clean(ps[0]) if ps else ''
                en_text = clean(ps[1]) if len(ps) > 1 else ''
                if mh_text:
                    gex_sort += 1
                    grammar_examples.append({
                        'id': _gex.next(),
                        'grammar_id': gid,
                        'minihongo': mh_text,
                        'english': en_text,
                        'japanese': '',
                        'english_litteral': '',
                        'sort_order': gex_sort,
                    })


# -- Word Building ------------------------------------------------------------

def parse_word_building():
    text = (SITE / 'lessons/5-word-building.html').read_text()
    h2_sort = 0
    h3_sort = 0
    comp_sort = 0
    expr_sort = 0
    current_h2_cat = ''
    current_h3_cat = ''
    current_h2_raw = ''
    ttype = None

    for line in text.split('\n'):
        # h2 heading
        m = re.search(r'<h2 class="section-heading">(.*?)</h2>', line)
        if m:
            h2_sort += 1
            h3_sort = 0
            raw = clean(m.group(1))
            current_h2_raw = raw
            mh, en = parse_bilingual(raw)
            current_h2_cat = add_category('word-building', mh, en, h2_sort)
            current_h3_cat = ''
            ttype = None
            continue

        # h3 heading
        m = re.search(r'<h3>(.*?)</h3>', line)
        if m:
            h3_sort += 1
            raw = clean(m.group(1))
            mh, en = parse_bilingual(raw)
            current_h3_cat = add_category(
                'word-building', mh, en, h3_sort, parent_id=current_h2_cat
            )
            ttype = None
            continue

        # Detect table type from header
        if '<thead>' in line:
            raw = clean(line)
            if 'Reading' in raw and 'Parts' in raw:
                ttype = 'compound'
            elif 'Reading' in raw and 'Minihongo' in raw:
                ttype = 'common'
            elif 'Literally' in raw or 'Pattern' in raw:
                ttype = 'concept'
            else:
                ttype = 'concept'
            continue

        # Table row
        m = re.search(r'<tr>(.*?)</tr>', line)
        if not m or not ttype:
            continue

        cells = re.findall(r'<td[^>]*>(.*?)</td>', m.group(1))
        cat = current_h3_cat or current_h2_cat

        if ttype == 'compound' and len(cells) >= 4:
            comp_sort += 1
            compounds.append({
                'id': _comp.next(),
                'category_id': cat,
                'minihongo': clean(cells[0]),
                'english': clean(cells[2]),
                'japanese': clean(cells[0]),
                'english_litteral': clean(cells[3]),
                'sort_order': comp_sort,
            })

        elif ttype == 'common' and len(cells) >= 4:
            expr_sort += 1
            expressions.append({
                'id': _expr.next(),
                'category_id': cat,
                'minihongo': clean(cells[3]),
                'english': clean(cells[2]),
                'japanese': clean(cells[0]),
                'english_litteral': '',
                'sort_order': expr_sort,
            })

        elif ttype == 'concept' and len(cells) >= 3:
            expr_sort += 1
            expressions.append({
                'id': _expr.next(),
                'category_id': cat,
                'minihongo': clean(cells[1]),
                'english': clean(cells[0]),
                'japanese': '',
                'english_litteral': clean(cells[2]),
                'sort_order': expr_sort,
            })


# -- Reading ------------------------------------------------------------------

def _parse_speaker(p_html):
    """Extract speaker and text from '<strong>Speaker:</strong> text'."""
    m = re.match(r'<strong>(.*?):?</strong>\s*(.*)', p_html, re.DOTALL)
    if m:
        speaker = clean(m.group(1)).rstrip(':')
        body = clean(m.group(2))
        return speaker, body
    return '', clean(p_html)


def parse_reading():
    text = (SITE / 'lessons/6-texts-dialogs.html').read_text()
    h2_sort = 0
    haiku_sort = 0
    dgrp_sort = 0
    story_sort = 0
    current_h2_cat = ''
    current_h2_raw = ''

    # Split on h2 sections
    sections = re.split(r'<h2 class="section-heading">', text)

    for section in sections[1:]:
        h2_m = re.match(r'(.*?)</h2>', section)
        if not h2_m:
            continue
        h2_sort += 1
        raw = clean(h2_m.group(1))
        current_h2_raw = raw
        mh, en = parse_bilingual(raw)
        current_h2_cat = add_category('reading', mh, en, h2_sort)

        # Haiku (sections without h3 dialog/story markers)
        for hm in re.finditer(
            r'<div class="haiku">\s*<p[^>]*>(.*?)</p>\s*<p>(.*?)</p>\s*</div>',
            section, re.DOTALL,
        ):
            haiku_sort += 1
            mh_text = clean(hm.group(1)).replace('\n', ' / ')
            en_text = clean(hm.group(2))
            haiku_rows.append({
                'id': _haiku.next(),
                'category_id': current_h2_cat,
                'minihongo': mh_text,
                'english': en_text,
                'japanese': '',
                'sort_order': haiku_sort,
            })

        # Dialogs
        # Find all h3 + dialog pairs in this section
        dialog_pattern = (
            r'<h3>(.*?)</h3>\s*'
            r'<div class="dialog">(.*?)</div>\s*'
            r'<div class="dialog-translation">(.*?)</div>'
        )
        for dm in re.finditer(dialog_pattern, section, re.DOTALL):
            dgrp_sort += 1
            h3_raw = clean(dm.group(1))
            title_mh, title_en = parse_bilingual(h3_raw)

            gid = _dgrp.next()
            dialog_groups.append({
                'id': gid,
                'category_id': current_h2_cat,
                'title_minihongo': title_mh,
                'title_english': title_en,
                'title_japanese': '',
                'sort_order': dgrp_sort,
            })

            # Extract lines
            mh_lines = re.findall(r'<p[^>]*>(.*?)</p>', dm.group(2))
            en_lines = re.findall(r'<p[^>]*>(.*?)</p>', dm.group(3))

            for i, (mh_html, en_html) in enumerate(
                zip(mh_lines, en_lines), 1
            ):
                sp_mh, body_mh = _parse_speaker(mh_html)
                sp_en, body_en = _parse_speaker(en_html)

                dialog_rows.append({
                    'id': _dlg.next(),
                    'dialog_group_id': gid,
                    'line_number': i,
                    'speaker_minihongo': sp_mh,
                    'speaker_english': sp_en,
                    'speaker_japanese': '',
                    'minihongo': body_mh,
                    'english': body_en,
                    'japanese': '',
                })

        # Stories
        story_pattern = (
            r'<h3>(.*?)</h3>\s*'
            r'<div class="story">(.*?)</div>\s*'
            r'<div class="story-translation">(.*?)</div>'
        )
        for sm in re.finditer(story_pattern, section, re.DOTALL):
            story_sort += 1
            h3_raw = clean(sm.group(1))
            title_mh, title_en = parse_bilingual(h3_raw)

            mh_paras = re.findall(r'<p[^>]*>(.*?)</p>', sm.group(2))
            en_paras = re.findall(r'<p>(.*?)</p>', sm.group(3))

            mh_text = ' '.join(clean(p) for p in mh_paras)
            en_text = ' '.join(clean(p) for p in en_paras)

            story_rows.append({
                'id': _story.next(),
                'category_id': current_h2_cat,
                'title_minihongo': title_mh,
                'title_english': title_en,
                'title_japanese': '',
                'minihongo': mh_text,
                'english': en_text,
                'japanese': '',
                'sort_order': story_sort,
            })


# -- CSV output ---------------------------------------------------------------

TABLES = {
    'pages': {
        'rows': pages,
        'fields': ['id', 'name_minihongo', 'name_english',
                    'name_japanese', 'sort_order'],
    },
    'categories': {
        'rows': categories,
        'fields': ['id', 'parent_id', 'page_id', 'name_minihongo',
                    'name_english', 'name_japanese', 'sort_order'],
    },
    'words': {
        'rows': words,
        'fields': ['id', 'category_id', 'minihongo', 'english', 'japanese',
                    'english_litteral', 'example_minihongo',
                    'example_english', 'example_japanese', 'sort_order'],
    },
    'grammar': {
        'rows': grammar_rows,
        'fields': ['id', 'category_id', 'minihongo', 'english', 'japanese',
                    'explanation_minihongo', 'explanation_english',
                    'explanation_japanese', 'sort_order'],
    },
    'grammar_examples': {
        'rows': grammar_examples,
        'fields': ['id', 'grammar_id', 'minihongo', 'english', 'japanese',
                    'english_litteral', 'sort_order'],
    },
    'compounds': {
        'rows': compounds,
        'fields': ['id', 'category_id', 'minihongo', 'english', 'japanese',
                    'english_litteral', 'sort_order'],
    },
    'expressions': {
        'rows': expressions,
        'fields': ['id', 'category_id', 'minihongo', 'english', 'japanese',
                    'english_litteral', 'sort_order'],
    },
    'haiku': {
        'rows': haiku_rows,
        'fields': ['id', 'category_id', 'minihongo', 'english', 'japanese',
                    'sort_order'],
    },
    'dialog_groups': {
        'rows': dialog_groups,
        'fields': ['id', 'category_id', 'title_minihongo', 'title_english',
                    'title_japanese', 'sort_order'],
    },
    'dialogs': {
        'rows': dialog_rows,
        'fields': ['id', 'dialog_group_id', 'line_number',
                    'speaker_minihongo', 'speaker_english',
                    'speaker_japanese', 'minihongo', 'english', 'japanese'],
    },
    'stories': {
        'rows': story_rows,
        'fields': ['id', 'category_id', 'title_minihongo', 'title_english',
                    'title_japanese', 'minihongo', 'english', 'japanese',
                    'sort_order'],
    },
}


def write_csv(path, rows, fieldnames):
    with open(path, 'w', newline='', encoding='utf-8') as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(rows)


# -- Datapackage --------------------------------------------------------------

def field_descriptor(name, table_name):
    """Build a Frictionless field descriptor."""
    f = {'name': name, 'type': 'string'}
    if name == 'sort_order' or name == 'line_number':
        f['type'] = 'integer'
    # Mark required fields
    optional = {
        'parent_id', 'name_japanese', 'japanese', 'english',
        'english_litteral', 'example_english', 'example_japanese',
        'explanation_minihongo', 'explanation_japanese',
        'title_japanese', 'speaker_japanese',
    }
    if name not in optional:
        f['constraints'] = {'required': True}
    return f


def build_datapackage():
    fk_map = {
        # parent_id → categories self-ref omitted: Frictionless can't validate nullable FKs
        'categories': [
            {'fields': ['page_id'], 'reference': {'resource': 'pages', 'fields': ['id']}},
        ],
        'words': [
            {'fields': ['category_id'], 'reference': {'resource': 'categories', 'fields': ['id']}},
        ],
        'grammar': [
            {'fields': ['category_id'], 'reference': {'resource': 'categories', 'fields': ['id']}},
        ],
        'grammar_examples': [
            {'fields': ['grammar_id'], 'reference': {'resource': 'grammar', 'fields': ['id']}},
        ],
        'compounds': [
            {'fields': ['category_id'], 'reference': {'resource': 'categories', 'fields': ['id']}},
        ],
        'expressions': [
            {'fields': ['category_id'], 'reference': {'resource': 'categories', 'fields': ['id']}},
        ],
        'haiku': [
            {'fields': ['category_id'], 'reference': {'resource': 'categories', 'fields': ['id']}},
        ],
        'dialog_groups': [
            {'fields': ['category_id'], 'reference': {'resource': 'categories', 'fields': ['id']}},
        ],
        'dialogs': [
            {'fields': ['dialog_group_id'], 'reference': {'resource': 'dialog_groups', 'fields': ['id']}},
        ],
        'stories': [
            {'fields': ['category_id'], 'reference': {'resource': 'categories', 'fields': ['id']}},
        ],
    }

    resources = []
    for name, info in TABLES.items():
        schema = {
            'fields': [field_descriptor(f, name) for f in info['fields']],
            'primaryKey': 'id',
        }
        if name in fk_map:
            schema['foreignKeys'] = fk_map[name]
        resources.append({
            'name': name,
            'path': f'{name}.csv',
            'schema': schema,
        })

    return {
        'name': 'minihongo-content',
        'resources': resources,
    }


# -- Main ---------------------------------------------------------------------

def main():
    OUT.mkdir(exist_ok=True)

    parse_vocabulary()
    parse_grammar()
    parse_word_building()
    parse_reading()

    for name, info in TABLES.items():
        write_csv(OUT / f'{name}.csv', info['rows'], info['fields'])

    pkg = build_datapackage()
    with open(OUT / 'datapackage.json', 'w', encoding='utf-8') as f:
        json.dump(pkg, f, indent=2, ensure_ascii=False)

    print(f'Output: {OUT}/')
    total = 0
    for name, info in TABLES.items():
        n = len(info['rows'])
        total += n
        print(f'  {name}: {n}')
    print(f'  total: {total}')


if __name__ == '__main__':
    main()
