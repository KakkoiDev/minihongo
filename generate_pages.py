#!/usr/bin/env python3
"""Generate lesson HTML pages from CSV data for all languages."""
import csv
import html as html_mod
import re
from pathlib import Path
from collections import defaultdict

DATA = Path('data')
PAGES_OUT = Path('site/pages')

LANGS = ['en', 'ja', 'mh']
LANG_COL = {'en': 'english', 'ja': 'japanese', 'mh': 'minihongo'}

PAGE_FILES = {
    'vocabulary': '2-vocabulary.html',
    'grammar': '3-grammar.html',
    'word-building': '5-word-building.html',
    'reading': '6-texts-dialogs.html',
}

WB_DESC_KEYS = {
    'Real Kanji Compounds': 'wb_desc_compounds',
    'Build Your Own Vocabulary': 'wb_desc_byov',
    'Common Words in Minihongo': 'wb_desc_common',
}

UI_STRINGS = {}
PAGE_DATA = []


# -- Data loading -------------------------------------------------------------

def load_csv(name):
    """Read data/{name}.csv into list of dicts."""
    with open(DATA / f'{name}.csv', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def load_ui_strings():
    global UI_STRINGS
    UI_STRINGS = {r['key']: r for r in load_csv('ui_strings')}


def load_page_data():
    global PAGE_DATA
    PAGE_DATA = sorted(load_csv('pages'), key=lambda r: int(r['sort_order']))


# -- Helpers ------------------------------------------------------------------

def ui(key, lang):
    """Get UI string with fallback: lang -> en -> mh."""
    row = UI_STRINGS.get(key)
    if not row:
        return key
    for l in [lang, 'en', 'mh']:
        val = row.get(l, '').strip()
        if val:
            return to_ruby_html(val)
    return key


def t(row, field, lang):
    """Get translated field with fallback: lang -> en -> mh."""
    for l in [LANG_COL[lang], 'english', 'minihongo']:
        col = f'{field}_{l}' if field else l
        val = row.get(col, '').strip()
        if val:
            return val
    return ''


def render(text):
    """Escape HTML then convert bracket notation to ruby. Safe for plain text."""
    return to_ruby_html(esc(text))


def page_desc(page_row, lang):
    """Get page description with fallback: lang -> en -> mh."""
    for l in [lang, 'en', 'mh']:
        val = page_row.get(f'desc_{l}', '').strip()
        if val:
            return val
    return ''


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


def bilingual(mh, translated):
    """Format bilingual heading."""
    if mh == translated or not translated:
        return esc(mh)
    return f'{esc(mh)} ({esc(translated)})'


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

def get_page(page_id):
    """Get page data row by id."""
    for p in PAGE_DATA:
        if p['id'] == page_id:
            return p
    return None


def wrap_page(page_id, content, lang, toc=None):
    """Wrap section content in page-layout template."""
    page = get_page(page_id)
    title = t(page, 'name', lang)
    desc = page_desc(page, lang)
    site_name = ui('site_name', lang)
    show_readings = ui('show_readings', lang)

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

    # Nav links from sorted page list
    page_ids = [p['id'] for p in PAGE_DATA]
    idx = page_ids.index(page_id)

    if idx > 0:
        prev_id = page_ids[idx - 1]
        prev_label = t(get_page(prev_id), 'name', lang)
        prev_href = f'lessons/{PAGE_FILES[prev_id]}'
        prev_link = f'    <a href="{prev_href}">\u2190 {prev_label}</a>'
    else:
        prev_link = '    <span></span>'

    if idx < len(page_ids) - 1:
        next_id = page_ids[idx + 1]
        next_label = t(get_page(next_id), 'name', lang)
        next_href = f'lessons/{PAGE_FILES[next_id]}'
        next_link = f'    <a href="{next_href}">{next_label} \u2192</a>'
    else:
        next_link = '    <span></span>'

    return (
        f'<page-layout>\n'
        f'  <span slot="title">{title} - {site_name}</span>\n'
        f'\n'
        f'  <h1>{title}</h1>\n'
        f'  <p>{desc}</p>\n'
        f'\n'
        f'  <label class="toggle">\n'
        f'    <input type="checkbox" id="furigana-toggle" checked>\n'
        f'    {show_readings}\n'
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


# -- Homepage -----------------------------------------------------------------

def gen_index(lang):
    site_name = ui('site_name', lang)
    tagline = ui('home_tagline', lang)
    desc = ui('home_desc', lang)

    return (
        f'<page-layout>\n'
        f'  <span slot="title">{site_name}</span>\n'
        f'\n'
        f'  <h1 lang="ja">\u30df\u30cb\u672c\u8a9e</h1>\n'
        f'  <p>{tagline}</p>\n'
        f'  <p>{desc}</p>\n'
        f'</page-layout>\n'
    )


# -- Vocabulary ---------------------------------------------------------------

def gen_vocabulary(categories, words, lang):
    cats = by_sort([c for c in categories if c['page_id'] == 'vocabulary'])
    words_by_cat = defaultdict(list)
    for w in words:
        words_by_cat[w['category_id']].append(w)

    th_word = ui('th_word', lang)
    th_meaning = ui('th_meaning', lang)

    toc = []
    parts = []
    for cat in cats:
        cat_words = by_sort(words_by_cat.get(cat['id'], []))
        count = len(cat_words)
        slug = slugify(cat['name_english'])
        translated = t(cat, 'name', lang)
        h = bilingual(cat['name_minihongo'], translated)
        toc_label = translated or cat['name_english']
        toc.append((slug, f'{cat["sort_order"]}. {esc(toc_label)}'))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{cat["sort_order"]}. {h} - {count}</h2>\n')
        parts.append('\n')
        parts.append('  <table class="compact-table">\n')
        parts.append(f'    <thead><tr><th>{th_word}</th><th>{th_meaning}</th><th>Example</th></tr></thead>\n')
        parts.append('    <tbody>\n')
        for w in cat_words:
            word = to_ruby_html(w['minihongo'])
            if lang == 'mh':
                meaning = to_ruby_html(w.get('definition_minihongo', '') or t(w, '', lang))
            else:
                meaning = render(t(w, '', lang))
            example = to_ruby_html(w['example_minihongo'])
            parts.append(f'      <tr><td lang="ja">{word}</td><td>{meaning}</td><td lang="ja">{example}</td></tr>\n')
        parts.append('    </tbody>\n')
        parts.append('  </table>\n')
        parts.append('\n')

    return wrap_page('vocabulary', ''.join(parts), lang, toc)


# -- Grammar ------------------------------------------------------------------

def gen_grammar(categories, grammar, grammar_examples, lang):
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
        translated = t(cat, 'name', lang)
        h = bilingual(cat['name_minihongo'], translated)
        toc_label = translated or cat['name_english']
        toc.append((slug, esc(toc_label)))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')
        parts.append('\n')

        for gp in by_sort(gram_by_cat.get(cat['id'], [])):
            pattern = to_ruby_html(gp['minihongo'])
            explanation = to_ruby_html(t(gp, 'explanation', lang))
            parts.append('  <grammar-point>\n')
            parts.append(f'    <span slot="pattern">{pattern}</span>\n')
            parts.append(f'    <span slot="explanation">{explanation}</span>\n')

            for ex in by_sort(ex_by_gram.get(gp['id'], [])):
                mh = to_ruby_html(ex['minihongo'])
                translated_ex = to_ruby_html(t(ex, '', lang))
                parts.append('    <div class="sentence">\n')
                parts.append(f'      <p lang="ja">{mh}</p>\n')
                parts.append(f'      <p>{translated_ex}</p>\n')
                parts.append('    </div>\n')

            parts.append('  </grammar-point>\n')
            parts.append('\n')

    return wrap_page('grammar', ''.join(parts), lang, toc)


# -- Word Building ------------------------------------------------------------

def gen_word_building(categories, compounds, expressions, lang):
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

    toc = []
    parts = []
    for h2 in h2_cats:
        slug = slugify(h2['name_english'])
        translated = t(h2, 'name', lang)
        h = bilingual(h2['name_minihongo'], translated)
        toc_label = translated or h2['name_english']
        toc.append((slug, esc(toc_label)))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')

        desc_key = WB_DESC_KEYS.get(h2['name_english'], '')
        if desc_key:
            desc = ui(desc_key, lang)
            parts.append(f'  <p>{desc}</p>\n')
        parts.append('\n')

        for h3 in children.get(h2['id'], []):
            h3_translated = t(h3, 'name', lang)
            h3_heading = bilingual(h3['name_minihongo'], h3_translated)
            parts.append(f'  <h3>{h3_heading}</h3>\n')

            cat_compounds = by_sort(compounds_by_cat.get(h3['id'], []))
            cat_expressions = by_sort(expressions_by_cat.get(h3['id'], []))

            if cat_compounds:
                _render_compound_table(parts, cat_compounds, lang)
            elif cat_expressions:
                has_japanese = any(e['japanese'] for e in cat_expressions)
                if has_japanese:
                    _render_common_table(parts, cat_expressions, lang)
                else:
                    _render_concept_table(parts, cat_expressions, lang)

            parts.append('\n')

    return wrap_page('word-building', ''.join(parts), lang, toc)


def _render_compound_table(parts, rows, lang):
    """4-col table: Word / Reading / Meaning / Parts."""
    th_word = ui('th_word', lang)
    th_reading = ui('th_reading', lang)
    th_meaning = ui('th_meaning', lang)
    th_parts = ui('th_parts', lang)
    parts.append('  <table class="compound-table">\n')
    parts.append(f'    <thead><tr><th lang="ja">{th_word}</th><th>{th_reading}</th><th>{th_meaning}</th><th>{th_parts}</th></tr></thead>\n')
    parts.append('    <tbody>\n')
    for r in rows:
        parts.append(
            f'      <tr>'
            f'<td lang="ja">{r["minihongo"]}</td>'
            f'<td lang="ja">{r["reading"]}</td>'
            f'<td>{render(t(r, "", lang))}</td>'
            f'<td>{esc(r["english_litteral"])}</td>'
            f'</tr>\n'
        )
    parts.append('    </tbody>\n')
    parts.append('  </table>\n')


def _render_common_table(parts, rows, lang):
    """4-col table: Word / Reading / English / Minihongo."""
    th_reading = ui('th_reading', lang)
    parts.append('<table class="compound-table">\n')
    parts.append(f'  <thead><tr><th>Word</th><th>{th_reading}</th><th>English</th><th>Minihongo</th></tr></thead>\n')
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


def _render_concept_table(parts, rows, lang):
    """3-col table: Concept / Expression / Literally."""
    th_concept = ui('th_concept', lang)
    th_literally = ui('th_literally', lang)
    parts.append('  <table class="compound-table">\n')
    parts.append(f'    <thead><tr><th>{th_concept}</th><th lang="ja">\u8a00\u3044\u65b9</th><th>{th_literally}</th></tr></thead>\n')
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

def gen_reading(categories, haiku, dialog_groups, dialogs, stories, lang):
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
    children = defaultdict(list)
    for c in categories:
        if c['page_id'] == 'reading' and c['parent_id']:
            children[c['parent_id']].append(c)
    for k in children:
        children[k] = by_sort(children[k])

    toc = []
    parts = []
    for h2 in h2_cats:
        slug = slugify(h2['name_english'])
        translated = t(h2, 'name', lang)
        h = bilingual(h2['name_minihongo'], translated)
        toc_label = translated or h2['name_english']
        toc.append((slug, esc(toc_label)))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')
        parts.append('\n')

        for cat in children.get(h2['id'], [h2]):
            if children.get(h2['id']):
                sub_translated = t(cat, 'name', lang)
                sub_h = bilingual(cat['name_minihongo'], sub_translated)
                parts.append(f'<h3>{sub_h}</h3>\n')

            # Haiku
            for hk in by_sort(haiku_by_cat.get(cat['id'], [])):
                mh = to_ruby_html(hk['minihongo']).replace(' / ', '<br>')
                translated_hk = to_ruby_html(t(hk, '', lang))
                parts.append('  <div class="haiku">\n')
                parts.append(f'    <p lang="ja">{mh}</p>\n')
                parts.append(f'    <p>{translated_hk}</p>\n')
                parts.append('  </div>\n')
                parts.append('\n')

            # Dialog groups
            for dg in by_sort(dgrp_by_cat.get(cat['id'], [])):
                dg_translated = t(dg, 'title', lang)
                title = to_ruby_html(bilingual(dg['title_minihongo'], dg_translated))
                lines = sorted(dlg_by_grp.get(dg['id'], []),
                              key=lambda d: int(d['line_number']))

                parts.append(f'<h4>{title}</h4>\n')
                parts.append('<div class="dialog">\n')
                for ln in lines:
                    speaker = to_ruby_html(ln['speaker_minihongo'])
                    body = to_ruby_html(ln['minihongo'])
                    parts.append(f'  <p lang="ja"><strong>{speaker}:</strong> {body}</p>\n')
                parts.append('</div>\n')
                parts.append('<div class="dialog-translation">\n')
                for ln in lines:
                    speaker = to_ruby_html(t(ln, 'speaker', lang))
                    body = to_ruby_html(t(ln, '', lang))
                    parts.append(f'  <p><strong>{speaker}:</strong> {body}</p>\n')
                parts.append('</div>\n')
                parts.append('\n')

            # Stories
            for st in by_sort(stories_by_cat.get(cat['id'], [])):
                st_translated = t(st, 'title', lang)
                title = to_ruby_html(bilingual(st['title_minihongo'], st_translated))

                mh_text = st['minihongo']
                mh_paras = re.split(r'(?<=[\u3002\u300d]) ', mh_text)
                mh_paras = [p for p in mh_paras if p.strip()]

                parts.append(f'<h4>{title}</h4>\n')
                parts.append('<div class="story">\n')
                for para in mh_paras:
                    parts.append(f'  <p lang="ja">{to_ruby_html(para)}</p>\n')
                parts.append('</div>\n')

                translated_story = to_ruby_html(t(st, '', lang))
                parts.append('<div class="story-translation">\n')
                parts.append(f'  <p>{translated_story}</p>\n')
                parts.append('</div>\n')
                parts.append('\n')

    return wrap_page('reading', ''.join(parts), lang, toc)


# -- Main ---------------------------------------------------------------------

def main():
    load_ui_strings()
    load_page_data()

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

    for lang in LANGS:
        if lang == 'en':
            out_dir = PAGES_OUT / 'lessons'
            index_path = PAGES_OUT / 'index.html'
        else:
            out_dir = PAGES_OUT / lang / 'lessons'
            index_path = PAGES_OUT / lang / 'index.html'

        out_dir.mkdir(parents=True, exist_ok=True)

        # Homepage
        index_path.write_text(gen_index(lang))
        print(f'  {index_path}')

        # Lesson pages
        pages = [
            ('vocabulary', gen_vocabulary(categories, words, lang)),
            ('grammar', gen_grammar(categories, grammar, grammar_examples, lang)),
            ('word-building', gen_word_building(categories, compounds, expressions, lang)),
            ('reading', gen_reading(categories, haiku, dialog_groups, dialogs_data, stories, lang)),
        ]

        for page_id, html in pages:
            path = out_dir / PAGE_FILES[page_id]
            path.write_text(html)
            print(f'  {path}')


if __name__ == '__main__':
    main()
