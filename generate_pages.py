#!/usr/bin/env python3
"""Generate lesson HTML pages from CSV data."""
import csv
import html as html_mod
import re
from pathlib import Path
from collections import defaultdict

DATA = Path('data')
OUT = Path('site/pages/lessons')


# -- Helpers ------------------------------------------------------------------

def load_csv(name):
    """Read data/{name}.csv into list of dicts."""
    with open(DATA / f'{name}.csv', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def to_ruby_html(text):
    """Convert bracket notation 人【ひと】 to <ruby>人<rt>ひと</rt></ruby>."""
    return re.sub(
        r'([\u4e00-\u9fff]+)【([^】]+)】',
        r'<ruby>\1<rt>\2</rt></ruby>',
        text,
    )


def esc(text):
    """Escape HTML special characters in text content."""
    return html_mod.escape(text, quote=False)


def bilingual(mh, en):
    """Format bilingual heading."""
    if mh == en or not en:
        return esc(mh)
    return f'{esc(mh)} ({esc(en)})'


def by_sort(rows):
    """Sort rows by sort_order."""
    return sorted(rows, key=lambda r: int(r['sort_order']))


def slugify(text):
    """Create URL-friendly ID from text."""
    text = text.lower()
    text = text.replace('→', 'to').replace('∞', 'infinity')
    text = re.sub(r'[^a-z0-9\s-]', '', text)
    text = re.sub(r'[\s-]+', '-', text.strip())
    return text


# -- Page wrapper -------------------------------------------------------------

PAGE_META = {
    'vocabulary': {
        'title': 'Vocabulary',
        'file': '2-vocabulary.html',
        'desc': '181 words. Every word earns its place.',
        'prev': None,
        'next': ('lessons/3-grammar.html', 'Grammar'),
    },
    'grammar': {
        'title': 'Grammar',
        'file': '3-grammar.html',
        'desc': 'Minimum grammar for maximum expression.',
        'prev': ('lessons/2-vocabulary.html', 'Vocabulary'),
        'next': ('lessons/5-word-building.html', 'Word Building'),
    },
    'word-building': {
        'title': 'Word Building',
        'file': '5-word-building.html',
        'desc': '181 words. Infinite expression. Combine core words to say anything.',
        'prev': ('lessons/3-grammar.html', 'Grammar'),
        'next': ('lessons/6-texts-dialogs.html', 'Reading'),
    },
    'reading': {
        'title': 'Reading',
        'file': '6-texts-dialogs.html',
        'desc': 'Haiku, dialogs, and short stories using only the 181 base words.',
        'prev': ('lessons/5-word-building.html', 'Word Building'),
        'next': None,
    },
}

# Section descriptions for word-building h2 categories (not in CSV)
WB_DESCS = {
    'Real Kanji Compounds': 'Real Japanese words built entirely from kanji in the 181-word vocabulary.',
    '181 \u2192 \u221e': 'Like Toki Pona, combine primitives to express any concept. From simple negation to creative description.',
    'Common Words in Minihongo': 'Real Japanese words from the top 1000 most common, expressed using only the 181 base words.',
}


def wrap_page(page_id, content, toc=None):
    """Wrap section content in page-layout template."""
    meta = PAGE_META[page_id]
    title = meta['title']
    desc = meta['desc']

    # TOC
    toc_html = ''
    if toc:
        items = '\n'.join(
            f'      <li><a href="#{slug}">{label}</a></li>'
            for slug, label in toc
        )
        toc_html = (
            f'  <nav class="toc">\n'
            f'    <ul>\n'
            f'{items}\n'
            f'    </ul>\n'
            f'  </nav>\n\n'
        )

    # Nav links
    if meta['prev']:
        href, label = meta['prev']
        prev_link = f'    <a href="{href}">\u2190 {label}</a>'
    else:
        prev_link = '    <span></span>'

    if meta['next']:
        href, label = meta['next']
        next_link = f'    <a href="{href}">{label} \u2192</a>'
    else:
        next_link = '    <span></span>'

    return (
        f'<page-layout>\n'
        f'  <span slot="title">{title} \u2014 Minihongo</span>\n'
        f'\n'
        f'  <h1>{title}</h1>\n'
        f'  <p>{desc}</p>\n'
        f'\n'
        f'  <label class="toggle">\n'
        f'    <input type="checkbox" id="furigana-toggle" checked>\n'
        f'    Show readings\n'
        f'  </label>\n'
        f'\n'
        f'{toc_html}'
        f'{content}'
        f'  <nav class="lesson-nav">\n'
        f'{prev_link}\n'
        f'{next_link}\n'
        f'  </nav>\n'
        f'</page-layout>\n'
    )


# -- Vocabulary ---------------------------------------------------------------

def gen_vocabulary(categories, words):
    cats = by_sort([c for c in categories if c['page_id'] == 'vocabulary'])
    words_by_cat = defaultdict(list)
    for w in words:
        words_by_cat[w['category_id']].append(w)

    toc = []
    parts = []
    for cat in cats:
        cat_words = by_sort(words_by_cat.get(cat['id'], []))
        count = len(cat_words)
        slug = slugify(cat['name_english'])
        h = bilingual(cat['name_minihongo'], cat['name_english'])
        toc.append((slug, f'{cat["sort_order"]}. {esc(cat["name_english"])}'))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{cat["sort_order"]}. {h} \u2014 {count}</h2>\n')
        parts.append('\n')
        parts.append('  <table class="compact-table">\n')
        parts.append('    <thead><tr><th>Word</th><th>Meaning</th><th>Example</th></tr></thead>\n')
        parts.append('    <tbody>\n')
        for w in cat_words:
            word = to_ruby_html(w['minihongo'])
            meaning = esc(w['english'])
            example = to_ruby_html(w['example_minihongo'])
            parts.append(f'      <tr><td lang="ja">{word}</td><td>{meaning}</td><td lang="ja">{example}</td></tr>\n')
        parts.append('    </tbody>\n')
        parts.append('  </table>\n')
        parts.append('\n')

    return wrap_page('vocabulary', ''.join(parts), toc)


# -- Grammar ------------------------------------------------------------------

def gen_grammar(categories, grammar, grammar_examples):
    cats = by_sort([c for c in categories if c['page_id'] == 'grammar'])
    gram_by_cat = defaultdict(list)
    for g in grammar:
        gram_by_cat[g['category_id']].append(g)
    ex_by_gram = defaultdict(list)
    for e in grammar_examples:
        ex_by_gram[e['grammar_id']].append(e)

    toc = []
    parts = []
    for cat in cats:
        slug = slugify(cat['name_english'])
        h = bilingual(cat['name_minihongo'], cat['name_english'])
        toc.append((slug, esc(cat['name_english'])))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')
        parts.append('\n')

        for gp in by_sort(gram_by_cat.get(cat['id'], [])):
            pattern = to_ruby_html(gp['minihongo'])
            explanation = gp['explanation_english']
            parts.append('  <grammar-point>\n')
            parts.append(f'    <span slot="pattern">{pattern}</span>\n')
            parts.append(f'    <span slot="explanation">{explanation}</span>\n')

            for ex in by_sort(ex_by_gram.get(gp['id'], [])):
                mh = to_ruby_html(ex['minihongo'])
                en = ex['english']
                parts.append('    <div class="sentence">\n')
                parts.append(f'      <p lang="ja">{mh}</p>\n')
                parts.append(f'      <p>{en}</p>\n')
                parts.append('    </div>\n')

            parts.append('  </grammar-point>\n')
            parts.append('\n')

    return wrap_page('grammar', ''.join(parts), toc)


# -- Word Building ------------------------------------------------------------

def gen_word_building(categories, compounds, expressions):
    # Build lookup tables
    compounds_by_cat = defaultdict(list)
    for c in compounds:
        compounds_by_cat[c['category_id']].append(c)
    expressions_by_cat = defaultdict(list)
    for e in expressions:
        expressions_by_cat[e['category_id']].append(e)

    # Separate h2 (no parent) and h3 (with parent) categories
    h2_cats = by_sort([c for c in categories
                       if c['page_id'] == 'word-building' and not c['parent_id']])
    children = defaultdict(list)
    for c in categories:
        if c['page_id'] == 'word-building' and c['parent_id']:
            children[c['parent_id']].append(c)
    for k in children:
        children[k] = by_sort(children[k])

    toc = []
    parts = []
    for h2 in h2_cats:
        slug = slugify(h2['name_english'])
        h = bilingual(h2['name_minihongo'], h2['name_english'])
        toc.append((slug, esc(h2['name_english'])))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')

        # Section description if available
        desc = WB_DESCS.get(h2['name_english'], '')
        if desc:
            parts.append(f'  <p>{desc}</p>\n')
        parts.append('\n')

        for h3 in children.get(h2['id'], []):
            h3_heading = bilingual(h3['name_minihongo'], h3['name_english'])
            parts.append(f'  <h3>{h3_heading}</h3>\n')

            cat_compounds = by_sort(compounds_by_cat.get(h3['id'], []))
            cat_expressions = by_sort(expressions_by_cat.get(h3['id'], []))

            if cat_compounds:
                _render_compound_table(parts, cat_compounds)
            elif cat_expressions:
                # Determine type: common-word (has japanese) vs concept (no japanese)
                has_japanese = any(e['japanese'] for e in cat_expressions)
                if has_japanese:
                    _render_common_table(parts, cat_expressions)
                else:
                    _render_concept_table(parts, cat_expressions)

            parts.append('\n')

    return wrap_page('word-building', ''.join(parts), toc)


def _render_compound_table(parts, rows):
    """4-col table: Word / Reading / Meaning / Parts."""
    parts.append('  <table class="compound-table">\n')
    parts.append('    <thead><tr><th lang="ja">\u8a00\u8449</th><th>Reading</th><th>Meaning</th><th>Parts</th></tr></thead>\n')
    parts.append('    <tbody>\n')
    for r in rows:
        parts.append(
            f'      <tr>'
            f'<td lang="ja">{r["minihongo"]}</td>'
            f'<td lang="ja">{r["reading"]}</td>'
            f'<td>{esc(r["english"])}</td>'
            f'<td>{esc(r["english_litteral"])}</td>'
            f'</tr>\n'
        )
    parts.append('    </tbody>\n')
    parts.append('  </table>\n')


def _render_common_table(parts, rows):
    """4-col table: Word / Reading / English / Minihongo."""
    parts.append('<table class="compound-table">\n')
    parts.append('  <thead><tr><th>Word</th><th>Reading</th><th>English</th><th>Minihongo</th></tr></thead>\n')
    parts.append('  <tbody>\n')
    for r in rows:
        mh = to_ruby_html(r['minihongo'])
        parts.append(
            f'    <tr>'
            f'<td lang="ja">{r["japanese"]}</td>'
            f'<td lang="ja">{r["reading"]}</td>'
            f'<td>{esc(r["english"])}</td>'
            f'<td lang="ja">{mh}</td>'
            f'</tr>\n'
        )
    parts.append('  </tbody>\n')
    parts.append('</table>\n')


def _render_concept_table(parts, rows):
    """3-col table: Concept / Minihongo / Literally."""
    parts.append('  <table class="compound-table">\n')
    parts.append('    <thead><tr><th>Concept</th><th lang="ja">\u8a00\u3044\u65b9</th><th>Literally</th></tr></thead>\n')
    parts.append('    <tbody>\n')
    for r in rows:
        mh = to_ruby_html(r['minihongo'])
        parts.append(
            f'      <tr>'
            f'<td>{esc(r["english"])}</td>'
            f'<td lang="ja">{mh}</td>'
            f'<td>{esc(r["english_litteral"])}</td>'
            f'</tr>\n'
        )
    parts.append('    </tbody>\n')
    parts.append('  </table>\n')


# -- Reading ------------------------------------------------------------------

def gen_reading(categories, haiku, dialog_groups, dialogs, stories):
    cats = by_sort([c for c in categories if c['page_id'] == 'reading'])

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

    # Reorder: dialogs and stories first, haiku last
    haiku_cats = [c for c in cats if haiku_by_cat.get(c['id'])]
    other_cats = [c for c in cats if not haiku_by_cat.get(c['id'])]
    cats = other_cats + haiku_cats

    toc = []
    parts = []
    for cat in cats:
        slug = slugify(cat['name_english'])
        h = bilingual(cat['name_minihongo'], cat['name_english'])
        toc.append((slug, esc(cat['name_english'])))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')
        parts.append('\n')

        # Haiku
        for hk in by_sort(haiku_by_cat.get(cat['id'], [])):
            mh = to_ruby_html(hk['minihongo']).replace(' / ', '<br>')
            en = hk['english']
            parts.append('  <div class="haiku">\n')
            parts.append(f'    <p lang="ja">{mh}</p>\n')
            parts.append(f'    <p>{en}</p>\n')
            parts.append('  </div>\n')
            parts.append('\n')

        # Dialog groups
        for dg in by_sort(dgrp_by_cat.get(cat['id'], [])):
            title = to_ruby_html(bilingual(dg['title_minihongo'], dg['title_english']))
            lines = sorted(dlg_by_grp.get(dg['id'], []),
                          key=lambda d: int(d['line_number']))

            parts.append(f'<h3>{title}</h3>\n')
            parts.append('<div class="dialog">\n')
            for ln in lines:
                speaker = to_ruby_html(ln['speaker_minihongo'])
                body = to_ruby_html(ln['minihongo'])
                parts.append(f'  <p lang="ja"><strong>{speaker}:</strong> {body}</p>\n')
            parts.append('</div>\n')
            parts.append('<div class="dialog-translation">\n')
            for ln in lines:
                speaker = ln['speaker_english']
                body = ln['english']
                parts.append(f'  <p><strong>{speaker}:</strong> {body}</p>\n')
            parts.append('</div>\n')
            parts.append('\n')

        # Stories
        for st in by_sort(stories_by_cat.get(cat['id'], [])):
            title = to_ruby_html(bilingual(st['title_minihongo'], st['title_english']))

            # Split Japanese text into paragraphs on space after 。or 」
            mh_text = st['minihongo']
            mh_paras = re.split(r'(?<=[\u3002\u300d]) ', mh_text)
            mh_paras = [p for p in mh_paras if p.strip()]

            parts.append(f'<h3>{title}</h3>\n')
            parts.append('<div class="story">\n')
            for para in mh_paras:
                parts.append(f'  <p lang="ja">{to_ruby_html(para)}</p>\n')
            parts.append('</div>\n')

            # English as single paragraph
            parts.append('<div class="story-translation">\n')
            parts.append(f'  <p>{st["english"]}</p>\n')
            parts.append('</div>\n')
            parts.append('\n')

    return wrap_page('reading', ''.join(parts), toc)


# -- Main ---------------------------------------------------------------------

def main():
    OUT.mkdir(parents=True, exist_ok=True)

    categories = load_csv('categories')
    words = load_csv('words')
    grammar = load_csv('grammar')
    grammar_examples = load_csv('grammar_examples')
    compounds = load_csv('compounds')
    expressions = load_csv('expressions')
    haiku = load_csv('haiku')
    dialog_groups = load_csv('dialog_groups')
    dialogs_data = load_csv('dialogs')
    stories = load_csv('stories')

    pages = [
        ('vocabulary', gen_vocabulary(categories, words)),
        ('grammar', gen_grammar(categories, grammar, grammar_examples)),
        ('word-building', gen_word_building(categories, compounds, expressions)),
        ('reading', gen_reading(categories, haiku, dialog_groups, dialogs_data, stories)),
    ]

    for page_id, html in pages:
        path = OUT / PAGE_META[page_id]['file']
        path.write_text(html)
        print(f'  {path}')


if __name__ == '__main__':
    main()
