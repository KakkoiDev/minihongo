#!/usr/bin/env python3
"""Generate lesson HTML pages from CSV data for all languages."""
import hashlib
import html as html_mod
import re
import sys
from pathlib import Path
from collections import defaultdict

from mh_common import ARTIFACT_LANGS, LANGS, LANG_COL, LEARNER_LANGS, load_csv, strip_furigana

PAGES_OUT = Path('site/pages')

PAGE_FILES = {
    'vocabulary': 'vocabulary.html',
    'grammar': 'grammar.html',
    'word-building': 'word-building.html',
    'going-further': 'going-further.html',
    'reading': 'texts-dialogs.html',
    'practice': 'practice.html',
    'understanding': 'understanding.html',
    'engineering': 'engineering.html',
}

WB_DESC_KEYS = {
    'Real Kanji Compounds': 'wb_desc_compounds',
    'Common Words in Minihongo': 'wb_desc_common',
    'Loan Words': 'wb_desc_loanwords',
}

UI_STRINGS = {}
PAGE_DATA = []


def play_btn(subdir, audio_file):
    """Generate a play button HTML if audio_file is set."""
    if not audio_file:
        return ''
    return f'<button class="play-btn" data-audio="{subdir}/{audio_file}">&#9654;</button> '


# -- Data loading -------------------------------------------------------------

def load_ui_strings():
    global UI_STRINGS
    UI_STRINGS = {r['key']: r for r in load_csv('ui_strings')}


def load_page_data():
    global PAGE_DATA
    # Only the lesson pages this script builds - pages.csv can also carry rows
    # for pages built elsewhere (e.g. kaiwa, built by site/build.py) that have
    # no place in this file's linear prev/next lesson sequence.
    lesson_rows = [r for r in load_csv('pages') if r['id'] in PAGE_FILES]
    PAGE_DATA = sorted(lesson_rows, key=lambda r: int(r['sort_order']))


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
    """Get a translated field without leaking English onto Japanese pages."""
    fallbacks = ([LANG_COL[lang], 'minihongo'] if lang == 'ja'
                 else [LANG_COL[lang], 'english', 'minihongo'])
    for l in fallbacks:
        col = f'{field}_{l}' if field else l
        val = row.get(col, '').strip()
        if val:
            return val
    return ''


def tr(row, col, lang):
    """Learner-language variant of an english-named column, falling back to English.

    tr(r, 'english', 'ko') -> r['korean'] or r['english'];
    tr(r, 'where_english', 'ko') -> r['where_korean'] or r['where_english'].
    """
    if lang == 'ko':
        val = row.get(col.replace('english', 'korean'), '').strip()
        if val:
            return val
    if lang == 'ja':
        return row.get(col.replace('english', 'japanese'), '').strip()
    return row.get(col, '').strip()


def eng_fallback(row, lang, key='name_english'):
    """English fallback for a label, suppressed on the ja site so nothing English leaks."""
    return '' if lang == 'ja' else row[key]


def render(text):
    """Escape HTML then convert bracket notation to ruby. Safe for plain text."""
    return to_ruby_html(esc(text))


def page_desc(page_row, lang):
    """Get a page description without leaking English onto Japanese pages."""
    fallbacks = [lang, 'mh'] if lang == 'ja' else [lang, 'en', 'mh']
    for l in fallbacks:
        val = page_row.get(f'desc_{l}', '').strip()
        if val:
            return to_ruby_html(val)
    return ''


def to_ruby_html(text):
    """Convert bracket notation 人【ひと】 to <ruby>人<rt>ひと</rt></ruby>."""
    return re.sub(
        r'([\u4e00-\u9fff々]+)【([^】]+)】',
        r'<ruby>\1<rt>\2</rt></ruby>',
        text,
    )


def esc(text):
    """Escape HTML special characters in text content."""
    return html_mod.escape(text, quote=False)


def bilingual(mh, translated):
    """Format bilingual heading."""
    if mh == translated or not translated:
        return to_ruby_html(esc(mh))
    return f'{to_ruby_html(esc(mh))} ({to_ruby_html(esc(translated))})'


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


def wrap_page(page_id, content, lang, toc=None, pre_toc=''):
    """Wrap section content in page-layout template."""
    page = get_page(page_id)
    title_raw = t(page, 'name', lang)
    title_plain = re.sub(r'【[^】]+】', '', title_raw)
    title = to_ruby_html(title_raw)
    desc = page_desc(page, lang)
    site_name_plain = re.sub(r'<ruby>|</ruby>|<rt>[^<]*</rt>', '', ui('site_name', lang))
    site_name = ui('site_name', lang)

    # TOC - each entry is (slug, label) or (slug, label, children)
    toc_html = ''
    if toc:
        lines = []
        has_details = any(len(e) > 2 and e[2] for e in toc)
        cls = 'toc toc-collapsible' if has_details else 'toc'
        # Collapsed on phones (it can be 20+ entries), opened on wider screens by app.js
        lines.append(f'  <details class="toc-box">\n    <summary>{ui("toc_title", lang)}</summary>\n')
        lines.append(f'  <nav class="{cls}">\n')
        lines.append('    <ul>\n')
        for entry in toc:
            slug, label = entry[0], entry[1]
            children = entry[2] if len(entry) > 2 else []
            if children:
                lines.append(f'      <li>\n')
                lines.append(f'        <details>\n')
                lines.append(f'          <summary><a href="#{slug}">{label}</a></summary>\n')
                lines.append(f'          <ul>\n')
                for cs, cl in children:
                    lines.append(f'            <li><a href="#{cs}">{cl}</a></li>\n')
                lines.append(f'          </ul>\n')
                lines.append(f'        </details>\n')
                lines.append(f'      </li>\n')
            else:
                lines.append(f'      <li><a href="#{slug}">{label}</a></li>\n')
        lines.append('    </ul>\n')
        lines.append('  </nav>\n')
        lines.append('  </details>\n\n')
        toc_html = ''.join(lines)

    # Hidden pages stay out of the public lesson sequence. A hidden page can
    # still link back to the last visible lesson before it.
    visible_page_ids = [p['id'] for p in PAGE_DATA if p.get('nav_group') != 'hidden']
    if page.get('nav_group') == 'hidden':
        page_ids = [
            p['id'] for p in PAGE_DATA
            if p.get('nav_group') != 'hidden' and int(p['sort_order']) < int(page['sort_order'])
        ] + [page_id]
    else:
        page_ids = visible_page_ids
    idx = page_ids.index(page_id)

    if idx > 0:
        prev_id = page_ids[idx - 1]
        prev_label = to_ruby_html(t(get_page(prev_id), 'name', lang))
        prev_href = f'lessons/{PAGE_FILES[prev_id]}'
        prev_link = f'    <a href="{prev_href}">\u2190 {prev_label}</a>'
    else:
        prev_link = '    <span></span>'

    if idx < len(page_ids) - 1:
        next_id = page_ids[idx + 1]
        next_label = to_ruby_html(t(get_page(next_id), 'name', lang))
        next_href = f'lessons/{PAGE_FILES[next_id]}'
        next_link = f'    <a href="{next_href}">{next_label} \u2192</a>'
    else:
        next_link = '    <span></span>'

    return (
        f'<page-layout>\n'
        f'  <span slot="title">{title_plain} - {site_name_plain}</span>\n'
        f'\n'
        f'  <h1>{title}</h1>\n'
        f'  <p>{desc}</p>\n'
        f'\n'
        f'{pre_toc}'
        f'{toc_html}'
        f'{content}'
        f'  <nav class="lesson-nav">\n'
        f'{prev_link}\n'
        f'{next_link}\n'
        f'  </nav>\n'
        f'</page-layout>\n'
    )


# -- Homepage -----------------------------------------------------------------

def strip_html(text):
    """Remove HTML tags and ruby reading text from text."""
    text = re.sub(r'<rt>[^<]*</rt>', '', text)
    return re.sub(r'<[^>]+>', '', text)


def gen_index(lang):
    site_name = ui('site_name', lang)
    site_name_plain = strip_html(site_name)
    tagline = ui('home_tagline', lang)
    bullets = [ui(f'home_{i}', lang) for i in range(1, 4)]
    items = '\n'.join(f'    <li>{b}</li>' for b in bullets)

    n_words = len(load_csv("words"))
    if lang == 'en':
        # Count from words.csv so the landing claim can't drift from the data
        h1 = f'  <h1>Learn Japanese from {n_words} core words.</h1>\n'
    elif lang == 'ko':
        h1 = f'  <h1>핵심 단어 {n_words}개로 배우는 일본어</h1>\n'
    elif lang == 'mh':
        h1 = '  <h1 lang="ja">ミニ<ruby>本<rt>ほん</rt></ruby><ruby>語<rt>ご</rt></ruby></h1>\n'
    else:
        h1 = '  <h1 lang="ja">ミニ本語</h1>\n'

    first_page = PAGE_DATA[0]
    next_label = to_ruby_html(t(first_page, 'name', lang))
    next_href = f'lessons/{PAGE_FILES[first_page["id"]]}'


    onboarding = ui('home_onboarding', lang)
    prerequisite_raw = UI_STRINGS.get('home_prerequisite', {}).get(lang, '').strip()
    prerequisite = to_ruby_html(prerequisite_raw) if prerequisite_raw else ''
    anki_link = ui('home_anki_link', lang)
    anki_desc = ui('home_anki_desc', lang)
    pdf_link = ui('home_pdf_link', lang)
    basename = strip_html(ui('site_basename', lang))
    # Decks/books are not built for every edition; Korean readers get English ones.
    artifact_lang = lang if lang in ARTIFACT_LANGS else 'en'

    # Expression examples table with audio
    # Tuple: (concept, minihongo, audio_dir, audio_file, literal)
    # concept='' for mh: single-column, no translation needed
    _examples = {
        'en': [
            ('friend',  '好【す】きな人【ひと】',                 'e', 'e_1_suhito.mp3',        'liked person'),
            ('doctor',  '体【からだ】を助【たす】ける人【ひと】', 'e', 'e_5_karadatasuhito.mp3', 'body-helping person'),
            ('freedom', '好【す】きにできる事【こと】',           'e', 'e_165_sukoto.mp3',       'able to do as liked'),
        ],
        'ko': [
            ('친구',   '好【す】きな人【ひと】',                 'e', 'e_1_suhito.mp3',        '좋아하는 사람'),
            ('의사',   '体【からだ】を助【たす】ける人【ひと】', 'e', 'e_5_karadatasuhito.mp3', '몸을 돕는 사람'),
            ('자유',   '好【す】きにできる事【こと】',           'e', 'e_165_sukoto.mp3',       '좋을 대로 할 수 있는 것'),
        ],
        'ja': [
            ('友達', '好【す】きな人【ひと】',                 'e', 'e_1_suhito.mp3',        ''),
            ('医者', '体【からだ】を助【たす】ける人【ひと】', 'e', 'e_5_karadatasuhito.mp3', ''),
            ('自由', '好【す】きにできる事【こと】',           'e', 'e_165_sukoto.mp3',       ''),
        ],
        'mh': [
            ('', '好【す】きな人【ひと】',                 'e', 'e_1_suhito.mp3',        ''),
            ('', '体【からだ】を助【たす】ける人【ひと】', 'e', 'e_5_karadatasuhito.mp3', ''),
            ('', '好【す】きにできる事【こと】',           'e', 'e_165_sukoto.mp3',       ''),
        ],
    }
    rows = ''
    for concept, mh, audio_dir, audio_file, lit in _examples.get(lang, _examples['en']):
        mh_html = to_ruby_html(mh)
        pb = play_btn(audio_dir, audio_file)
        if concept:
            lit_html = f' <span class="example-lit">{lit}</span>' if lit else ''
            rows += f'      <tr><td lang="ja">{pb}{mh_html}</td><td>{concept}{lit_html}</td></tr>\n'
        else:
            rows += f'      <tr><td lang="ja">{pb}{mh_html}</td></tr>\n'
    example_table = (
        f'  <div class="table-scroll"><table class="compact-table">\n'
        f'    <tbody>\n'
        f'{rows}'
        f'    </tbody>\n'
        f'  </table></div>\n'
    )

    # Where to start: kana first (taught elsewhere), then the core lessons in order
    core_pages = [pg for pg in PAGE_DATA if pg.get('nav_group') == 'core']
    steps = []
    if prerequisite:
        steps.append(f'    <li class="home-steps__pre"><span>{prerequisite}</span></li>\n')
    for pg in core_pages:
        name = to_ruby_html(t(pg, 'name', lang))
        gloss = to_ruby_html(pg.get(f'gloss_{lang}') or ('' if lang == 'ja' else pg.get('gloss_en', '')))
        href = f'lessons/{PAGE_FILES[pg["id"]]}'
        steps.append(
            f'    <li><a href="{href}"><strong>{name}</strong>'
            + (f'<span>{gloss}</span>' if gloss else '')
            + '</a></li>\n'
        )

    return (
        f'<page-layout>\n'
        f'  <span slot="title">{site_name_plain}</span>\n'
        f'\n'
        f'{h1}'
        f'  <p class="home-lead">{tagline}</p>\n'
        f'{example_table}'
        f'  <p class="home-cta"><a class="btn btn-primary" href="{next_href}">{ui("home_cta", lang)} \u2192</a></p>\n'
        f'  <h2 class="home-steps__heading">{ui("home_start_heading", lang)}</h2>\n'
        f'  <ol class="home-steps">\n{"".join(steps)}  </ol>\n'
        f'  <div class="onboarding">\n'
        f'    <p>{onboarding}</p>\n'
        f'  </div>\n'
        f'  <div class="anki-featured">\n'
        f'    <p><a href="/{basename}-{artifact_lang}.apkg">{anki_link}</a> - {anki_desc}</p>\n'
        f'    <p class="anki-secondary"><a href="/{basename}-{artifact_lang}.pdf">{pdf_link}</a></p>\n'
        f'  </div>\n'
        f'  <div class="home-actions">\n'
        f'    <button type="button" class="btn" data-open="share-dialog">{ui("home_invite_cta", lang)}</button>\n'
        f'    <button type="button" class="btn" data-open="install-dialog">{ui("settings_install", lang)}</button>\n'
        f'  </div>\n'
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
    th_example = ui('th_example', lang)

    toc = []
    parts = []
    for cat in cats:
        cat_words = by_sort(words_by_cat.get(cat['id'], []))
        slug = slugify(cat['name_english'])
        translated = t(cat, 'name', lang)
        h = bilingual(cat['name_minihongo'], translated)
        toc_label = translated or eng_fallback(cat, lang)
        toc.append((slug, to_ruby_html(esc(toc_label))))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')
        parts.append('\n')
        parts.append('  <div class="table-scroll"><table class="compact-table">\n')
        parts.append(f'    <thead><tr><th>{th_word}</th><th>{th_meaning}</th><th>{th_example}</th></tr></thead>\n')
        parts.append('    <tbody>\n')
        for w in cat_words:
            word = to_ruby_html(w['minihongo'])
            if lang == 'mh':
                meaning = to_ruby_html(w.get('definition_minihongo', '') or t(w, '', lang))
            else:
                meaning = render(t(w, '', lang))
            example = to_ruby_html(w['example_minihongo'])
            pb_w = play_btn('w', w.get('audio_word', ''))
            pb_e = play_btn('w', w.get('audio_example', ''))
            parts.append(f'      <tr><td lang="ja">{pb_w}{word}</td><td>{meaning}</td><td lang="ja">{pb_e}{example}</td></tr>\n')
        parts.append('    </tbody>\n')
        parts.append('  </table></div>\n')
        note = t(cat, 'note', lang)
        if note:
            parts.append(f'  <p class="category-note">{to_ruby_html(esc(note))}</p>\n')
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

    # 3-patterns intro (rendered before TOC via pre_toc)
    toc = []
    parts = []
    intro = []
    intro.append('  <div class="grammar-intro">\n')

    # Pattern 1: Set the Stage
    p1_label = ui('grammar_pattern_1', lang)
    intro.append(f'    <div class="grammar-intro__pattern">\n')
    intro.append(f'      <h3>{p1_label} {play_btn("gi", "gi_1.mp3")}</h3>\n')
    intro.append(f'      <div class="grammar-intro__example" lang="ja">\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("私【わたし】は")}</span><em>{ui("grammar_slot_who", lang)}</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("昨日【きのう】")}</span><em>{ui("grammar_slot_when", lang)}</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("家【いえ】で")}</span><em>{ui("grammar_slot_where", lang)}</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("本【ほん】を")}</span><em>{ui("grammar_slot_what", lang)}</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("読【よ】んだ。")}</span><em>{ui("grammar_slot_action", lang)}</em></span>\n')
    intro.append(f'      </div>\n')
    intro.append(f'      <p class="grammar-intro__links">{ui("grammar_intro_1_links", lang)}</p>\n')
    intro.append(f'    </div>\n')

    # Pattern 2: Chain Actions
    p2_label = ui('grammar_pattern_2', lang)
    intro.append(f'    <div class="grammar-intro__pattern">\n')
    intro.append(f'      <h3>{p2_label} {play_btn("gi", "gi_2.mp3")}</h3>\n')
    intro.append(f'      <div class="grammar-intro__example" lang="ja">\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("家【いえ】に帰【かえ】って")}</span><em>1</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("本【ほん】を読【よ】んで")}</span><em>2</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("寝【ね】た。")}</span><em>3</em></span>\n')
    intro.append(f'      </div>\n')
    intro.append(f'      <p class="grammar-intro__links">{ui("grammar_intro_2_links", lang)}</p>\n')
    intro.append(f'    </div>\n')

    # Pattern 3: Apply Filters
    p3_label = ui('grammar_pattern_3', lang)
    intro.append(f'    <div class="grammar-intro__pattern">\n')
    intro.append(f'      <h3>{p3_label} {play_btn("gi", "gi_3.mp3")}</h3>\n')
    intro.append(f'      <div class="grammar-intro__example" lang="ja">\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("読【よ】む")}</span><em>{ui("grammar_filter_base", lang)}</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("読【よ】んだ")}</span><em>{ui("grammar_filter_done", lang)}</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("読【よ】まない")}</span><em>{ui("grammar_filter_not", lang)}</em></span>\n')
    intro.append(f'        <span class="grammar-intro__slot"><span>{to_ruby_html("読【よ】みます")}</span><em>{ui("grammar_filter_polite", lang)}</em></span>\n')
    intro.append(f'      </div>\n')
    intro.append(f'      <p class="grammar-intro__links">{ui("grammar_intro_3_links", lang)}</p>\n')
    intro.append(f'    </div>\n')

    intro.append('  </div>\n\n')

    # Learning path: the core points in page order, then a core-only filter
    core_points = [gp for cat in cats for gp in by_sort(gram_by_cat.get(cat['id'], []))
                   if gp.get('core', '').strip().lower() == 'yes']
    if core_points:
        intro.append('  <section class="grammar-path">\n')
        intro.append(f'    <h2 class="grammar-path__heading">{ui("grammar_path_heading", lang)}</h2>\n')
        intro.append(f'    <p>{ui("grammar_path_body", lang)}</p>\n')
        intro.append('    <ol class="grammar-path__list">\n')
        for gp in core_points:
            slug = slugify(gp.get('english') or gp['id'])
            pattern = re.sub(r'\s*\([A-Za-z &/\-]+\)', '', gp['minihongo']).strip()
            name = '' if lang == 'mh' else t(gp, '', lang)
            name_html = f' <span class="grammar-path__name">{esc(name)}</span>' if name and name != pattern else ''
            intro.append(f'      <li><a href="#{slug}"><span lang="ja">{to_ruby_html(esc(pattern))}</span>{name_html}</a></li>\n')
        intro.append('    </ol>\n')
        intro.append(f'    <button type="button" class="nav-toggle listen-toggle" id="btn-core-only" aria-pressed="false">'
                     f'{ui("grammar_core_only", lang)}</button>\n')
        intro.append('  </section>\n\n')
    intro_html = ''.join(intro)

    for cat in cats:
        slug = slugify(cat['name_english'])
        translated = t(cat, 'name', lang)
        h = bilingual(cat['name_minihongo'], translated)
        toc_label = translated or eng_fallback(cat, lang)

        toc_children = []
        for gp in by_sort(gram_by_cat.get(cat['id'], [])):
            gp_slug = slugify(gp.get('english') or gp['id'])
            gp_toc_label = esc(t(gp, '', lang) or eng_fallback(gp, lang, key='minihongo'))
            if gp.get('core', '').strip().lower() == 'yes':
                gp_toc_label += f' <span class="toc-core">{ui("grammar_toc_core", lang)}</span>'
            toc_children.append((gp_slug, gp_toc_label))

        toc.append((slug, to_ruby_html(esc(toc_label)), toc_children))
        has_core = any(g.get('core', '').strip().lower() == 'yes' for g in gram_by_cat.get(cat['id'], []))
        h2_cls = 'section-heading' if has_core else 'section-heading no-core'
        parts.append(f'  <h2 id="{slug}" class="{h2_cls}">{h}</h2>\n')
        parts.append('\n')

        for gp in by_sort(gram_by_cat.get(cat['id'], [])):
            gp_slug = slugify(gp.get('english') or gp['id'])
            raw_pattern = gp['minihongo']
            if lang == 'mh':
                # Strip romaji/english in parentheses: "は (wa)" -> "は"
                raw_pattern = re.sub(r'\s*\([A-Za-z &/\-]+\)', '', raw_pattern).strip()
            pattern = to_ruby_html(raw_pattern)
            if lang in LEARNER_LANGS and tr(gp, 'english', lang):
                en_name = esc(tr(gp, 'english', lang))
                # Merge with existing romaji parenthetical: "は (wa)" -> "は (wa - Topic Marker)"
                romaji_match = re.search(r'\(([A-Za-z &/\-]+)\)$', pattern)
                if romaji_match:
                    romaji = romaji_match.group(1)
                    pattern = pattern[:romaji_match.start()] + f'({romaji} - {en_name})'
                else:
                    pattern = f'{pattern} ({en_name})'
            explanation = to_ruby_html(t(gp, 'explanation', lang))
            is_core = gp.get('core', '').strip().lower() == 'yes'
            if is_core:
                pattern += f' <span class="core-badge">{ui("grammar_toc_core", lang)}</span>'
            tag = f'  <grammar-point id="{gp_slug}" class="core">\n' if is_core else f'  <grammar-point id="{gp_slug}">\n'
            parts.append(tag)
            parts.append(f'    <span slot="pattern">{pattern}</span>\n')
            parts.append(f'    <span slot="explanation">{explanation}</span>\n')

            for ex in by_sort(ex_by_gram.get(gp['id'], [])):
                mh = to_ruby_html(ex['minihongo'])
                pb = play_btn('ge', ex.get('audio_file', ''))
                parts.append('    <div class="sentence">\n')
                parts.append(f'      <p lang="ja">{pb}{mh}</p>\n')
                if lang in LEARNER_LANGS:
                    translated_ex = to_ruby_html(t(ex, '', lang))
                    parts.append(f'      <p class="sentence__trans">{translated_ex}</p>\n')
                parts.append('    </div>\n')

            parts.append('  </grammar-point>\n')
            parts.append('\n')

    return wrap_page('grammar', ''.join(parts), lang, toc, pre_toc=intro_html)


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
        toc_label = translated or eng_fallback(h2, lang)

        # Build h3 TOC children
        toc_children = []
        for h3 in children.get(h2['id'], []):
            h3_slug = slugify(h3['name_english'])
            h3_label = t(h3, 'name', lang) or eng_fallback(h3, lang)
            toc_children.append((h3_slug, to_ruby_html(esc(h3_label))))

        toc.append((slug, to_ruby_html(esc(toc_label)), toc_children))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')

        desc_key = WB_DESC_KEYS.get(h2['name_english'], '')
        if desc_key:
            desc = ui(desc_key, lang)
            parts.append(f'  <p>{desc}</p>\n')
            if desc_key == 'wb_desc_compounds':
                warning = ui('wb_reading_warning', lang)
                parts.append(f'  <p class="reading-warning">{warning}</p>\n')
        parts.append('\n')

        for h3 in children.get(h2['id'], []):
            h3_slug = slugify(h3['name_english'])
            h3_translated = t(h3, 'name', lang)
            h3_heading = bilingual(h3['name_minihongo'], h3_translated)
            parts.append(f'  <h3 id="{h3_slug}" class="section-heading">{h3_heading}</h3>\n')

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


# -- Going Further ------------------------------------------------------------

def _render_advanced_table(parts, rows, lang, mh_for_target):
    """Advanced vocab: real Japanese word (with furigana) + English meaning,
    plus the Word Building circumlocution when the core already covers the word.
    ja page shows no English gloss (native speakers need none)."""
    th_word = ui('th_word', lang)
    th_in_mh = ui('th_in_minihongo', lang)
    parts.append('  <div class="table-scroll"><table class="compound-table">\n')
    if lang == 'ja':
        parts.append(f'    <thead><tr><th lang="ja">{th_word}</th><th lang="ja">{th_in_mh}</th></tr></thead>\n')
    else:
        th_english = ui('th_english' if lang == 'en' else 'th_meaning', lang)
        parts.append(f'    <thead><tr><th lang="ja">{th_word}</th><th>{th_english}</th><th lang="ja">{th_in_mh}</th></tr></thead>\n')
    parts.append('    <tbody>\n')
    for r in rows:
        pb = play_btn('a', r.get('audio_file', ''))
        word = to_ruby_html(r['japanese'])
        expr = mh_for_target.get(strip_furigana(r['japanese']))
        if expr:
            mh_cell = f'{play_btn("e", expr.get("audio_file", ""))}{to_ruby_html(expr["minihongo"])}'
        else:
            whole_word_hint = {
                'en': 'Learn as a whole word',
                'ko': '이 단어 그대로 외우기',
                'ja': 'この語のまま覚える',
                'mh': 'この言【こと】葉【ば】のまま覚【おぼ】える',
            }[lang]
            mh_cell = f'<span class="advanced-whole-word">{to_ruby_html(whole_word_hint)}</span>'
        if lang == 'ja':
            parts.append(f'      <tr><td lang="ja">{pb}{word}</td><td lang="ja">{mh_cell}</td></tr>\n')
        else:
            parts.append(f'      <tr><td lang="ja">{pb}{word}</td><td>{esc(tr(r, "english", lang))}</td><td lang="ja">{mh_cell}</td></tr>\n')
    parts.append('    </tbody>\n  </table></div>\n')


def gen_going_further(categories, compounds, expressions, advanced, lang):
    compounds_by_cat = defaultdict(list)
    for c in compounds:
        compounds_by_cat[c['category_id']].append(c)
    expressions_by_cat = defaultdict(list)
    for e in expressions:
        expressions_by_cat[e['category_id']].append(e)
    advanced_by_cat = defaultdict(list)
    for a in advanced:
        advanced_by_cat[a['category_id']].append(a)

    mh_for_target = {}
    for e in by_sort(expressions):
        if e['japanese']:
            mh_for_target.setdefault(e['japanese'], e)

    h2_cats = by_sort([c for c in categories
                       if c['page_id'] == 'going-further' and not c['parent_id']])
    children = defaultdict(list)
    for c in categories:
        if c['page_id'] == 'going-further' and c['parent_id']:
            children[c['parent_id']].append(c)
    for k in children:
        children[k] = by_sort(children[k])

    intro_html = (
        f'  <p>{ui("gf_intro_p1", lang)}</p>\n'
        f'  <p>{ui("gf_intro_p2", lang)}</p>\n\n'
    )

    immerse_slug = 'live-in-the-language'

    filter_label, filter_placeholder, filter_count, filter_empty = {
        'en': ('Find a word or topic', 'Try “animal”, “science”, or 日本…',
               'matching words', 'No matching words'),
        'ko': ('단어나 주제 찾기', '“동물”, “과학”, 日本 등을 입력…',
               '개 단어', '일치하는 단어가 없어요'),
        'ja': ('言葉・トピックを探す', '「動物」「科学」「日本」など…',
               '件の言葉', '一致する言葉がありません'),
        'mh': ('言【こと】葉【ば】を探【さが】す', '言【こと】葉【ば】を入【い】れる…',
               'の言【こと】葉【ば】', '同【おな】じ言【こと】葉【ば】がない'),
    }[lang]
    learning_steps = {
        'en': (
            'Use this as a reference, not a list to memorize.',
            'Search for a word you just encountered.',
            'Listen, compare the Minihongo paraphrase, then return to real Japanese.',
        ),
        'ko': (
            '외우는 목록이 아니라 찾아보는 자료예요.',
            '방금 만난 단어를 검색해 보세요.',
            '들어 보고, 미니혼고 표현과 비교한 뒤, 실제 일본어로 돌아가세요.',
        ),
        'ja': (
            'これは暗記リストではなく、調べるためのページです。',
            '実際に出会った言葉を検索する。',
            '音声を聞き、ミニ本語での言い換えを比べて、実際の日本語に戻る。',
        ),
        'mh': (
            '全部【ぜんぶ】を覚【おぼ】える所【ところ】ではない。',
            '外【そと】で会【あ】った言【こと】葉【ば】を探【さが】す。',
            '音【おと】を聞【き】いて、知【し】る言【こと】葉【ば】と同【おな】じ所【ところ】を見【み】る。',
        ),
    }[lang]

    toc = []
    parts = [
        '  <ol class="gf-learning-path">\n',
        *[f'    <li>{to_ruby_html(step)}</li>\n' for step in learning_steps],
        '  </ol>\n',
        '  <div class="gf-filter">\n',
        f'    <label for="gf-filter">{to_ruby_html(filter_label)}</label>\n',
        f'    <input id="gf-filter" type="search" placeholder="{to_ruby_html(filter_placeholder)}" '
        f'autocomplete="off" data-count-label="{strip_html(to_ruby_html(filter_count))}" '
        f'data-empty-label="{strip_html(to_ruby_html(filter_empty))}">\n',
        '    <p class="gf-filter__status" role="status" aria-live="polite"></p>\n',
        '  </div>\n\n',
    ]
    for h2 in h2_cats:
        slug = slugify(h2['name_english'])
        translated = t(h2, 'name', lang)
        h = bilingual(h2['name_minihongo'], translated)
        toc_label = translated or eng_fallback(h2, lang)

        toc_children = []
        for h3 in children.get(h2['id'], []):
            h3_slug = slugify(h3['name_english'])
            h3_label = t(h3, 'name', lang) or eng_fallback(h3, lang)
            toc_children.append((h3_slug, to_ruby_html(esc(h3_label))))

        toc.append((slug, to_ruby_html(esc(toc_label)), toc_children))
        parts.append('  <section class="gf-search-section">\n')
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')

        desc_key = WB_DESC_KEYS.get(h2['name_english'], '')
        if desc_key:
            desc = ui(desc_key, lang)
            parts.append(f'  <p>{desc}</p>\n')
            if desc_key == 'wb_desc_compounds':
                warning = ui('wb_reading_warning', lang)
                parts.append(f'  <p class="reading-warning">{warning}</p>\n')
        else:
            h2_note = t(h2, 'note', lang)
            if h2_note:
                parts.append(f'  <p>{to_ruby_html(esc(h2_note))}</p>\n')
        parts.append('\n')

        for h3 in children.get(h2['id'], []):
            h3_slug = slugify(h3['name_english'])
            h3_translated = t(h3, 'name', lang)
            h3_heading = bilingual(h3['name_minihongo'], h3_translated)
            parts.append('  <section class="gf-search-group">\n')
            parts.append(f'  <h3 id="{h3_slug}">{h3_heading}</h3>\n')

            cat_compounds = by_sort(compounds_by_cat.get(h3['id'], []))
            cat_expressions = by_sort(expressions_by_cat.get(h3['id'], []))
            cat_advanced = by_sort(advanced_by_cat.get(h3['id'], []))

            if cat_compounds:
                _render_compound_table(parts, cat_compounds, lang)
            elif cat_expressions:
                has_japanese = any(e['japanese'] for e in cat_expressions)
                if has_japanese:
                    _render_common_table(parts, cat_expressions, lang)
                else:
                    _render_concept_table(parts, cat_expressions, lang)
            elif cat_advanced:
                _render_advanced_table(parts, cat_advanced, lang, mh_for_target)

            parts.append('  </section>\n\n')
        parts.append('  </section>\n')

    immerse_heading = ui('gf_immerse_heading', lang)
    immerse_body = ui('gf_immerse_body', lang)
    immersion_resources = {
        'en': [
            ('read', 'NHK NEWS WEB EASY', 'Easy news with furigana and audio',
             'Free', 'Beginner–intermediate', 'https://www3.nhk.or.jp/news/easy/'),
            ('read', 'Tadoku', 'Graded readers with PDFs and audio',
             'Free', 'Beginner', 'https://tadoku.org/japanese/en/free-books-en/'),
            ('read', '絵本ひろば', 'Original Japanese picture books',
             'Free', 'Beginner', 'https://ehon.alphapolis.co.jp/'),
            ('watch', 'TVer', 'TV, drama, and anime; choose the 字幕あり filter',
             'Free in Japan', 'Intermediate+', 'https://tver.jp/'),
            ('watch', 'ABEMA', 'Anime, news, and original shows; subtitles vary by title',
             'Free + paid', 'Intermediate+', 'https://abema.tv/'),
            ('watch', 'FOD', 'Fuji TV drama, variety, and anime; some titles have subtitles',
             'Free + paid', 'Intermediate+', 'https://fod.fujitv.co.jp/'),
        ],
        'ko': [
            ('read', 'NHK NEWS WEB EASY', '후리가나와 음성이 있는 쉬운 뉴스',
             '무료', '초급~중급', 'https://www3.nhk.or.jp/news/easy/'),
            ('read', 'Tadoku', 'PDF와 음성이 있는 단계별 읽기 자료',
             '무료', '초급', 'https://tadoku.org/japanese/en/free-books-en/'),
            ('read', '絵本ひろば', '일본어 오리지널 그림책',
             '무료', '초급', 'https://ehon.alphapolis.co.jp/'),
            ('watch', 'TVer', '드라마·예능·애니메이션. 字幕あり(자막 있음) 필터를 선택하세요',
             '일본 내 무료', '중급 이상', 'https://tver.jp/'),
            ('watch', 'ABEMA', '애니메이션·뉴스·오리지널 프로그램. 자막은 작품마다 달라요',
             '무료 + 유료', '중급 이상', 'https://abema.tv/'),
            ('watch', 'FOD', '후지TV 드라마·예능·애니메이션. 일부 작품에 자막 있음',
             '무료 + 유료', '중급 이상', 'https://fod.fujitv.co.jp/'),
        ],
        'ja': [
            ('read', 'NHK NEWS WEB EASY', 'ふりがなと音声がある、やさしいニュース',
             '無料', '初級〜中級', 'https://www3.nhk.or.jp/news/easy/'),
            ('read', 'にほんご多読', 'レベル別の読み物・PDF・朗読音声',
             '無料', '初心者', 'https://tadoku.org/japanese/free-books/'),
            ('read', '絵本ひろば', '日本語のオリジナル絵本',
             '無料', '初心者', 'https://ehon.alphapolis.co.jp/'),
            ('watch', 'TVer', 'ドラマ・テレビ・アニメ。「字幕あり」で絞り込む',
             '日本では無料', '中級以上', 'https://tver.jp/'),
            ('watch', 'ABEMA', 'アニメ・ニュース・オリジナル番組。字幕は作品による',
             '無料＋有料', '中級以上', 'https://abema.tv/'),
            ('watch', 'FOD', 'フジテレビのドラマ・バラエティ・アニメ。一部は字幕あり',
             '無料＋有料', '中級以上', 'https://fod.fujitv.co.jp/'),
        ],
        'mh': [
            ('read', 'NHK NEWS WEB EASY', '読【よ】みやすいニュースと音【おと】',
             'お金【かね】はいらない', 'はじめ〜中【なか】', 'https://www3.nhk.or.jp/news/easy/'),
            ('read', 'にほんご多読', '少【すこ】しずつ難【むずか】しくなる本【ほん】',
             'お金【かね】はいらない', 'はじめ', 'https://tadoku.org/japanese/free-books/'),
            ('read', '絵本ひろば', '日本【にほん】の絵【え】の本【ほん】',
             'お金【かね】はいらない', 'はじめ', 'https://ehon.alphapolis.co.jp/'),
            ('watch', 'TVer', '日本【にほん】のテレビとアニメ',
             '日本【にほん】ではお金【かね】はいらない', '中【なか】から', 'https://tver.jp/'),
            ('watch', 'ABEMA', 'アニメとニュースを見る。字【じ】があるかは話【はなし】による',
             'お金【かね】がいらない物【もの】もある', '中【なか】から', 'https://abema.tv/'),
            ('watch', 'FOD', 'テレビの話【はなし】とアニメを見る。字【じ】がある物【もの】もある',
             'お金【かね】がいらない物【もの】もある', '中【なか】から', 'https://fod.fujitv.co.jp/'),
        ],
    }[lang]
    resource_group_labels = {
        'en': {'read': 'Read', 'watch': 'Watch'},
        'ko': {'read': '읽기', 'watch': '보기'},
        'ja': {'read': '読む', 'watch': '見る'},
        'mh': {'read': '読【よ】む', 'watch': '見【み】る'},
    }[lang]

    toc.append((immerse_slug, immerse_heading))
    parts.append(f'  <h2 id="{immerse_slug}" class="section-heading">{immerse_heading}</h2>\n')
    parts.append(f'  <p>{immerse_body}</p>\n')
    for group_id in ('read', 'watch'):
        parts.append(
            f'  <h3 class="immersion-resources__heading">'
            f'{to_ruby_html(resource_group_labels[group_id])}</h3>\n'
        )
        parts.append('  <ul class="immersion-resources">\n')
        for category, name, description, price, level, href in immersion_resources:
            if category != group_id:
                continue
            parts.append(
                '    <li><a href="' + href + '" target="_blank" rel="noopener noreferrer">'
                '<span class="immersion-resource__top"><strong>' + to_ruby_html(name) + '</strong>'
                '<span aria-hidden="true">↗</span></span>'
                '<span class="immersion-resource__description">' + to_ruby_html(description) + '</span>'
                '<span class="immersion-resource__tags">'
                '<span class="immersion-resource__tag">' + to_ruby_html(level) + '</span>'
                '<span class="immersion-resource__tag">' + to_ruby_html(price) + '</span>'
                '</span></a></li>\n'
            )
        parts.append('  </ul>\n')
    parts.append('\n')

    engineering_slug = 'engineering-japanese'
    engineering_heading, engineering_body, engineering_link = {
        'en': (
            'Engineering Japanese',
            'For software work, continue to the separate engineering guide with '
            'workplace vocabulary, dialogs, goals, and AI conversation practice.',
            'Open the Engineering Japanese guide',
        ),
        'ko': (
            '엔지니어를 위한 일본어',
            '소프트웨어 개발에 쓰는 어휘·대화·목표·AI 회화 연습은 '
            '엔지니어용 별도 가이드에 모아 두었어요.',
            '엔지니어 일본어 가이드 열기',
        ),
        'ja': (
            'エンジニアの日本語',
            'ソフトウェア開発で使う語彙・対話・目標・AI会話練習は、'
            '別のエンジニア向けページにまとめています。',
            'エンジニアの日本語ページを開く',
        ),
        'mh': (
            '作【つく】る人【ひと】の言【こと】葉【ば】',
            '作【つく】る人【ひと】と話【はな】す言【こと】葉【ば】は、'
            'この外【そと】にある。',
            '作【つく】る人【ひと】の所【ところ】を開【ひら】く',
        ),
    }[lang]
    engineering_heading = to_ruby_html(engineering_heading)
    engineering_body = to_ruby_html(engineering_body)
    engineering_link = to_ruby_html(engineering_link)
    toc.append((engineering_slug, engineering_heading))
    parts.append(f'  <h2 id="{engineering_slug}" class="section-heading">{engineering_heading}</h2>\n')
    parts.append(f'  <p>{engineering_body}</p>\n')
    parts.append(
        f'  <p class="gf-engineering-link"><a href="lessons/engineering.html">'
        f'{engineering_link} <span aria-hidden="true">→</span></a></p>\n\n'
    )

    return wrap_page('going-further', ''.join(parts), lang, toc, pre_toc=intro_html)


def _render_compound_table(parts, rows, lang):
    """2-col table: Word (with furigana) / Meaning."""
    th_word = ui('th_word', lang)
    th_meaning = ui('th_meaning', lang)
    parts.append('  <div class="table-scroll"><table class="compound-table">\n')
    parts.append(f'    <thead><tr><th lang="ja">{th_word}</th><th>{th_meaning}</th></tr></thead>\n')
    parts.append('    <tbody>\n')
    for r in rows:
        word = f'<ruby>{r["minihongo"]}<rt>{r["reading"]}</rt></ruby>'
        if lang == 'mh':
            meaning = to_ruby_html(esc(
                r.get('definition_minihongo', '') or r.get('english_litteral', '') or r['minihongo']
            ))
        else:
            meaning = render(t(r, "", lang))
        pb = play_btn('c', r.get('audio_file', ''))
        parts.append(
            f'      <tr>'
            f'<td lang="ja">{pb}{word}</td>'
            f'<td>{meaning}</td>'
            f'</tr>\n'
        )
    parts.append('    </tbody>\n')
    parts.append('  </table></div>\n')


def _render_common_table(parts, rows, lang):
    """Common words table.
    For mh: 1-col, only minihongo expression.
    For en/ja: 2-col, Minihongo + English/Japanese meaning."""
    th_minihongo = ui('th_minihongo', lang)
    parts.append('<div class="table-scroll"><table class="compound-table">\n')
    if lang == 'mh':
        parts.append(f'  <thead><tr><th lang="ja">{th_minihongo}</th></tr></thead>\n')
    else:
        th_meaning = ui('th_meaning', lang)
        parts.append(f'  <thead><tr><th lang="ja">{th_minihongo}</th><th>{th_meaning}</th></tr></thead>\n')
    parts.append('  <tbody>\n')
    for r in rows:
        mh = to_ruby_html(r['minihongo'])
        pb = play_btn('e', r.get('audio_file', ''))
        if lang == 'mh':
            parts.append(f'    <tr><td lang="ja">{pb}{mh}</td></tr>\n')
        else:
            if lang == 'ja' and r.get('reading'):
                meaning = f'<ruby>{esc(r["japanese"])}<rt>{esc(r["reading"])}</rt></ruby>'
            else:
                meaning = esc(r['japanese'] if lang == 'ja' else tr(r, 'english', lang))
            parts.append(
                f'    <tr>'
                f'<td lang="ja">{pb}{mh}</td>'
                f'<td>{meaning}</td>'
                f'</tr>\n'
            )
    parts.append('  </tbody>\n')
    parts.append('</table></div>\n')


def _render_concept_table(parts, rows, lang):
    """3-col table: Concept / Expression / Literally.
    For mh: 2-col, minihongo expression + definition."""
    if lang == 'mh':
        th_word = ui('th_word', lang)
        th_meaning = ui('th_meaning', lang)
        has_defs = any(r.get('definition_minihongo') for r in rows)
        parts.append('  <div class="table-scroll"><table class="compound-table">\n')
        if has_defs:
            parts.append(f'    <thead><tr><th lang="ja">{th_word}</th><th>{th_meaning}</th></tr></thead>\n')
        else:
            parts.append(f'    <thead><tr><th lang="ja">{th_word}</th></tr></thead>\n')
        parts.append('    <tbody>\n')
        for r in rows:
            mh = to_ruby_html(r['minihongo'])
            pb = play_btn('e', r.get('audio_file', ''))
            if has_defs:
                defn = to_ruby_html(esc(r.get('definition_minihongo', '') or ''))
                parts.append(f'      <tr><td lang="ja">{pb}{mh}</td><td>{defn}</td></tr>\n')
            else:
                parts.append(f'      <tr><td lang="ja">{pb}{mh}</td></tr>\n')
        parts.append('    </tbody>\n')
        parts.append('  </table></div>\n')
        return

    th_concept = ui('th_concept', lang)
    th_literally = ui('th_literally', lang)
    parts.append('  <div class="table-scroll"><table class="compound-table">\n')
    parts.append(f'    <thead><tr><th>{th_concept}</th><th lang="ja">\u8a00\u3044\u65b9</th><th>{th_literally}</th></tr></thead>\n')
    parts.append('    <tbody>\n')
    for r in rows:
        mh = to_ruby_html(r['minihongo'])
        pb = play_btn('e', r.get('audio_file', ''))
        parts.append(
            f'      <tr>'
            f'<td>{esc(tr(r, "english", lang))}</td>'
            f'<td lang="ja">{pb}{mh}</td>'
            f'<td>{esc(tr(r, "english_litteral", lang))}</td>'
            f'</tr>\n'
        )
    parts.append('    </tbody>\n')
    parts.append('  </table></div>\n')


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
        toc_label = translated or eng_fallback(h2, lang)

        toc_children = []
        for ch in children.get(h2['id'], []):
            ch_slug = slugify(ch['name_english'])
            ch_label = t(ch, 'name', lang) or eng_fallback(ch, lang)
            toc_children.append((ch_slug, to_ruby_html(esc(ch_label))))

        toc.append((slug, to_ruby_html(esc(toc_label)), toc_children))
        parts.append(f'  <h2 id="{slug}" class="section-heading">{h}</h2>\n')
        parts.append('\n')

        for cat in children.get(h2['id'], [h2]):
            if children.get(h2['id']):
                sub_slug = slugify(cat['name_english'])
                sub_translated = t(cat, 'name', lang)
                sub_h = bilingual(cat['name_minihongo'], sub_translated)
                parts.append(f'<h3 id="{sub_slug}" class="section-heading">{sub_h}</h3>\n')

            # Haiku
            for hk in by_sort(haiku_by_cat.get(cat['id'], [])):
                mh = to_ruby_html(hk['minihongo']).replace(' / ', '<br>')
                pb = play_btn('h', hk.get('audio_file', ''))
                parts.append('  <div class="haiku">\n')
                parts.append(f'    <p lang="ja">{mh}</p>\n')
                if lang != 'mh':
                    translated_hk = to_ruby_html(t(hk, '', lang))
                    parts.append(f'    <p>{translated_hk}</p>\n')
                if pb:
                    parts.append(f'    {pb}\n')
                parts.append('  </div>\n')
                parts.append('\n')

            # Dialog groups
            for dg in by_sort(dgrp_by_cat.get(cat['id'], [])):
                dg_translated = t(dg, 'title', lang)
                title = to_ruby_html(bilingual(dg['title_minihongo'], dg_translated))
                lines = sorted(dlg_by_grp.get(dg['id'], []),
                              key=lambda d: int(d['line_number']))

                pb = play_btn('d', dg.get('audio_file', ''))
                parts.append(f'<h4 id="{slugify(dg["title_english"])}">{title} {pb}</h4>\n')
                parts.append(f'<details class="reading-text" open><summary>{ui("show_text", lang)}</summary>\n')
                parts.append('<div class="dialog">\n')
                for ln in lines:
                    speaker = to_ruby_html(ln['speaker_minihongo'])
                    body = to_ruby_html(ln['minihongo'])
                    parts.append(f'  <p lang="ja"><strong>{speaker}:</strong> {body}</p>\n')
                parts.append('</div>\n')
                if lang != 'mh':
                    parts.append('<div class="dialog-translation">\n')
                    for ln in lines:
                        speaker = to_ruby_html(t(ln, 'speaker', lang))
                        body = to_ruby_html(t(ln, '', lang))
                        parts.append(f'  <p><strong>{speaker}:</strong> {body}</p>\n')
                    parts.append('</div>\n')
                parts.append('</details>\n')
                parts.append('\n')

            # Stories
            for st in by_sort(stories_by_cat.get(cat['id'], [])):
                st_slug = slugify(st.get('title_english') or st['id'])
                st_translated = t(st, 'title', lang)
                title = to_ruby_html(bilingual(st['title_minihongo'], st_translated))

                mh_text = st['minihongo']
                mh_paras = re.split(r'(?<=[\u3002\u300d]) ', mh_text)
                mh_paras = [p for p in mh_paras if p.strip()]

                pb = play_btn('s', st.get('audio_file', ''))
                parts.append(f'<h4 id="{st_slug}">{title} {pb}</h4>\n')
                parts.append(f'<details class="reading-text" open><summary>{ui("show_text", lang)}</summary>\n')
                parts.append('<div class="story">\n')
                for para in mh_paras:
                    parts.append(f'  <p lang="ja">{to_ruby_html(para)}</p>\n')
                parts.append('</div>\n')
                if lang != 'mh':
                    translated_story = to_ruby_html(t(st, '', lang))
                    parts.append('<div class="story-translation">\n')
                    parts.append(f'  <p>{translated_story}</p>\n')
                    parts.append('</div>\n')
                parts.append('</details>\n')
                parts.append('\n')

    listen_toggle = (
        f'  <p><button class="nav-toggle listen-toggle" id="btn-listen">'
        f'{ui("listen_first", lang)}</button></p>\n\n'
    )
    return wrap_page('reading', ''.join(parts), lang, toc, pre_toc=listen_toggle)


# -- Practice -----------------------------------------------------------------

def _cando_card(c, dg_by_id, lang):
    """One real-life goal: the goal in the reader's language, the Minihongo
    sentence under it (or alone on mh), and two ways to work towards it."""
    mh_html = to_ruby_html(c['minihongo'])
    if lang == 'mh':
        title, sub = f'<span lang="ja">{mh_html}</span>', ''
    elif lang == 'ja':
        title = f'<span lang="ja">{esc(c["japanese"])}</span>'
        sub = f'<span class="cando-sub" lang="ja">{mh_html}</span>'
    else:
        title = esc(tr(c, 'english', lang))
        sub = f'<span class="cando-sub" lang="ja">{mh_html}</span>'

    # Kaiwa opens with this goal selected; engineering goals live on the
    # engineering page's own Kaiwa
    if c['id'].startswith('cando-eng-'):
        practise_href = f'lessons/engineering.html?goal={c["id"]}#engineering-ai'
    else:
        practise_href = f'kaiwa/index.html?goal={c["id"]}'
    actions = [f'<a class="cando-action" href="{practise_href}">{ui("practice_cando_practise", lang)}</a>']
    dg = dg_by_id.get(c['dialog_group_id'])
    if dg:
        actions.insert(0, f'<a class="cando-action" href="lessons/texts-dialogs.html#{slugify(dg["title_english"])}">'
                          f'{ui("practice_see_dialog", lang)}</a>')
    return (
        f'    <li class="cando">\n'
        f'      <label class="cando-main"><input type="checkbox" class="cando-check" data-id="{c["id"]}">'
        f'<span class="cando-text"><span class="cando-title">{title}</span>{sub}</span></label>\n'
        f'      <div class="cando-actions">{" ".join(actions)}</div>\n'
        f'    </li>\n'
    )


def gen_practice(candos, dialog_groups, dialogs, words, grammar, grammar_examples, lang):
    dg_by_id = {d['id']: d for d in dialog_groups}

    toc = []
    parts = []
    parts.append(f'  <p>{ui("practice_intro", lang)}</p>\n\n')

    # Daily spaced-repetition session (static/practice.js), first on the page
    toc.append(('daily', ui('practice_daily_heading', lang), []))
    parts.append(f'  <h2 id="daily" class="section-heading">{ui("practice_daily_heading", lang)}</h2>\n')
    parts.append(f'  <div id="practice-app" data-lang="{lang}"><p class="practice-loading">{ui("kaiwa_loading", lang)}</p></div>\n\n')

    # Real-life goals: tick what you have done outside the site. Progress is
    # filled in by app.js from localStorage (the template keeps {done}/{total}).
    ordered = by_sort(candos)
    groups = [
        ('practice_cando_everyday', [c for c in ordered if not c['id'].startswith('cando-eng-')]),
        ('practice_cando_work', [c for c in ordered if c['id'].startswith('cando-eng-')]),
    ]
    toc.append(('can-do', ui('practice_cando_heading', lang), []))
    parts.append(f'  <h2 id="can-do" class="section-heading">{ui("practice_cando_heading", lang)}</h2>\n')
    parts.append(f'  <p class="cando-hint">{ui("practice_cando_hint", lang)}</p>\n')
    progress_tpl = strip_html(ui('practice_cando_progress', lang))
    parts.append(
        f'  <div class="cando-progress" data-template="{esc(progress_tpl)}">'
        f'<p class="cando-progress__label" aria-live="polite"></p>'
        f'<div class="cando-progress__bar"><span></span></div></div>\n'
    )
    for key, group in groups:
        if not group:
            continue
        parts.append(f'  <h3 class="cando-group">{ui(key, lang)}</h3>\n')
        parts.append('  <ul class="cando-list">\n')
        parts.extend(_cando_card(c, dg_by_id, lang) for c in group)
        parts.append('  </ul>\n')
    parts.append('\n')

    # AI conversation partner: copyable prompt, word list interpolated from words.csv
    toc.append(('ai-partner', ui('practice_ai_heading', lang), []))
    parts.append(f'  <h2 id="ai-partner" class="section-heading">{ui("practice_ai_heading", lang)}</h2>\n')
    parts.append(f'  <p>{ui("practice_kaiwa_link", lang)}</p>\n')
    parts.append(f'  <p>{ui("practice_ai_body", lang)}</p>\n')
    word_list = ', '.join(f'{w["minihongo"]} ({tr(w, "english", lang) or w["english"]})'
                          for w in by_sort(words))
    prompts = {
        'en': (
            'You are my Japanese conversation partner for Minihongo practice.\n'
            f'Minihongo is Japanese restricted to {len(words)} base words plus standard grammar '
            '(particles, verb conjugation, te-form, polite ます/です).\n'
            '\n'
            'Rules:\n'
            '1. Reply ONLY in Japanese, using ONLY the words below. Express any other idea '
            'by combining them, like 体を助ける所 for hospital.\n'
            '2. Write every kanji with its reading in brackets: 人【ひと】.\n'
            '3. Keep replies to one or two short sentences.\n'
            '4. If I use a word outside the list, gently show me how to say it with these '
            'words, then continue.\n'
            '5. Use ます/です politeness. Modern grammar only.\n'
            '6. Start now: greet me and ask one simple question.\n'
            '\n'
            f'The {len(words)} words: {word_list}'
        ),
        'ko': (
            '당신은 미니혼고 연습을 위한 나의 일본어 회화 파트너입니다.\n'
            f'미니혼고는 기본 단어 {len(words)}개와 표준 문법'
            '(조사, 동사 활용, て형, 정중한 ます/です)만 쓰는 일본어입니다.\n'
            '\n'
            '규칙:\n'
            '1. 일본어로만, 아래 단어만 사용해서 답해 주세요. 다른 개념은 단어를 조합해서 '
            '표현해 주세요(예: 병원 = 体を助ける所).\n'
            '2. 모든 한자에 읽는 법을 괄호로 붙여 주세요: 人【ひと】.\n'
            '3. 답은 짧은 한두 문장으로 해 주세요.\n'
            '4. 내가 목록에 없는 단어를 쓰면, 이 단어들로 어떻게 말하는지 친절하게 '
            '알려 준 뒤 대화를 이어 가 주세요.\n'
            '5. ます/です 정중체를 쓰고, 현대 문법만 사용해 주세요.\n'
            '6. 지금 시작해 주세요: 인사하고 쉬운 질문을 하나 해 주세요.\n'
            '\n'
            f'{len(words)}개 단어: {word_list}'
        ),
        'ja': (
            'あなたは私のミニ本語練習のための日本語会話パートナーです。\n'
            f'ミニ本語は{len(words)}個の基本語と標準的な文法'
            '（助詞、活用、て形、丁寧なます・です）に限定した日本語です。\n'
            '\n'
            'ルール：\n'
            '1. 日本語のみで、下の語だけを使って返事してください。他の考えはそれらを組み合わせて '
            '表現してください（例：病院は「体を助ける所」）。\n'
            '2. 漢字には必ず読みを【】で書いてください：人【ひと】。\n'
            '3. 返事は一、二文の短い文にしてください。\n'
            '4. リスト外の語を私が使ったら、その語をこれらの語でどう言うか優しく教えてから '
            '続けてください。\n'
            '5. ます・です体を使い、現代の文法のみにしてください。\n'
            '6. 今すぐ始めてください：挨拶して、簡単な質問を一つしてください。\n'
            '\n'
            f'{len(words)}個の語：{word_list}'
        ),
        'mh': (
            'あなたは私【わたし】と話【はな】す人【ひと】です。\n'
            '下【した】の言【こと】葉【ば】だけで、短【みじか】く話【はな】してください。\n'
            '外【そと】の言【こと】葉【ば】を私【わたし】が言【い】った時【とき】は、'
            '下【した】の言【こと】葉【ば】で言【い】う方【かた】を教【おし】えてください。\n'
            '\n'
            f'言【こと】葉【ば】：{word_list}'
        ),
    }
    prompt = prompts[lang]
    parts.append('  <details class="ai-prompt-box">\n')
    parts.append(f'    <summary>{ui("practice_ai_show", lang)}</summary>\n')
    parts.append(f'    <pre id="ai-prompt">{esc(prompt)}</pre>\n')
    parts.append('  </details>\n')
    parts.append(
        f'  <button id="copy-prompt" data-copied="{strip_html(ui("practice_ai_copied", lang))}">'
        f'{ui("practice_ai_copy", lang)}</button>\n'
    )

    return wrap_page('practice', ''.join(parts), lang, toc)


# -- Understanding Japan page ---------------------------------------------------

def gen_understanding(categories, comprehension, lang):
    items_by_cat = defaultdict(list)
    for r in comprehension:
        items_by_cat[r['category_id']].append(r)

    cats = by_sort([c for c in categories
                    if c['page_id'] == 'understanding' and not c['parent_id']])

    intro_html = (
        f'  <p>{ui("understanding_intro", lang)}</p>\n'
        f'  <p>{ui("understanding_rules", lang)}</p>\n\n'
    )

    th_jp = ui('th_real_japanese', lang)
    th_gloss = ui('th_it_means', lang)
    th_en = ui('th_english' if lang == 'en' else 'th_meaning', lang)
    th_where = ui('th_where', lang)

    toc = []
    parts = []
    for cat in cats:
        slug = slugify(cat['name_english'])
        translated = t(cat, 'name', lang)
        toc.append((slug, to_ruby_html(esc(translated or eng_fallback(cat, lang)))))
        heading = bilingual(cat['name_minihongo'], translated)
        parts.append(f'  <h2 id="{slug}" class="section-heading">{heading}</h2>\n')

        note = t(cat, 'note', lang)
        if note:
            parts.append(f'  <p class="category-note">{to_ruby_html(esc(note))}</p>\n')

        parts.append('  <div class="table-scroll"><table class="compound-table">\n')
        if lang in LEARNER_LANGS:
            parts.append(f'    <thead><tr><th lang="ja">{th_jp}</th><th>{th_en}</th>'
                         f'<th lang="ja">{th_gloss}</th><th>{th_where}</th></tr></thead>\n')
        elif lang == 'ja':
            parts.append(f'    <thead><tr><th lang="ja">{th_jp}</th>'
                         f'<th lang="ja">{th_gloss}</th><th lang="ja">{th_where}</th></tr></thead>\n')
        else:
            parts.append(f'    <thead><tr><th lang="ja">{th_jp}</th>'
                         f'<th lang="ja">{th_gloss}</th></tr></thead>\n')
        parts.append('    <tbody>\n')

        # Real-Japanese rows: explicit columns only. t() would fall back to
        # the japanese column, i.e. return the item itself as its ja meaning.
        for r in by_sort(items_by_cat.get(cat['id'], [])):
            pb = play_btn('u', r.get('audio_file', ''))
            jp = render(r['japanese'])
            gloss = render(r['minihongo'])
            if lang in LEARNER_LANGS:
                cells = (f'<td lang="ja">{pb}{jp}</td><td>{esc(tr(r, "english", lang))}</td>'
                         f'<td lang="ja">{gloss}</td><td>{esc(tr(r, "where_english", lang))}</td>')
            elif lang == 'ja':
                cells = (f'<td lang="ja">{pb}{jp}</td><td lang="ja">{gloss}</td>'
                         f'<td lang="ja">{esc(r["where_japanese"])}</td>')
            else:
                cells = f'<td lang="ja">{pb}{jp}</td><td lang="ja">{gloss}</td>'
            parts.append(f'      <tr>{cells}</tr>\n')

        parts.append('    </tbody>\n')
        parts.append('  </table></div>\n\n')

    return wrap_page('understanding', ''.join(parts), lang, toc, pre_toc=intro_html)


def gen_engineering(categories, expressions, dialog_groups, dialogs, candos, words, lang):
    """Build the unlinked, indexable engineering field guide."""
    children = defaultdict(list)
    expressions_by_cat = defaultdict(list)
    lines_by_group = defaultdict(list)
    for category in categories:
        if category['page_id'] == 'engineering' and category['parent_id']:
            children[category['parent_id']].append(category)
    for row in expressions:
        expressions_by_cat[row['category_id']].append(row)
    for row in dialogs:
        lines_by_group[row['dialog_group_id']].append(row)

    roots = by_sort([c for c in categories
                     if c['page_id'] == 'engineering' and not c['parent_id']])
    toc, parts = [], [f'  <p>{ui("engineering_intro", lang)}</p>\n\n']
    for root in roots[:2]:
        root_slug = slugify(root['name_english'])
        root_label = t(root, 'name', lang)
        toc_children = []
        for category in by_sort(children[root['id']]):
            slug = f'eng-{slugify(category["name_english"])}'
            label = t(category, 'name', lang)
            toc_children.append((slug, to_ruby_html(esc(label))))
        toc.append((root_slug, to_ruby_html(esc(root_label)), toc_children))
        parts.append(f'  <h2 id="{root_slug}" class="section-heading">{bilingual(root["name_minihongo"], root_label)}</h2>\n')
        for category in by_sort(children[root['id']]):
            slug = f'eng-{slugify(category["name_english"])}'
            label = t(category, 'name', lang)
            parts.append(f'  <h3 id="{slug}">{bilingual(category["name_minihongo"], label)}</h3>\n')
            _render_common_table(parts, by_sort(expressions_by_cat[category['id']]), lang)

    eng_groups = by_sort([g for g in dialog_groups if g['category_id'] == 'cat-124'])
    toc.append(('engineering-dialogs', ui('engineering_dialog_heading', lang), []))
    parts.append(f'  <h2 id="engineering-dialogs" class="section-heading">{ui("engineering_dialog_heading", lang)}</h2>\n')
    for group in eng_groups:
        title = bilingual(group['title_minihongo'], t(group, 'title', lang))
        parts.append(f'  <section class="dialog"><h3>{title}</h3>\n')
        for line in sorted(lines_by_group[group['id']], key=lambda r: int(r['line_number'])):
            translated = tr(line, 'english', lang) if lang != 'mh' else ''
            parts.append(f'    <p><strong>{render(t(line, "speaker", lang))}:</strong> <span lang="ja">{to_ruby_html(line["minihongo"])}</span>')
            if translated:
                parts.append(f' <span class="dialog-trans">{esc(translated)}</span>')
            parts.append('</p>\n')
        parts.append('  </section>\n')

    eng_candos = [c for c in candos if c['id'].startswith('cando-eng-')]
    toc.append(('engineering-candos', ui('engineering_cando_heading', lang), []))
    parts.append(f'  <h2 id="engineering-candos" class="section-heading">{ui("engineering_cando_heading", lang)}</h2>\n  <div class="cando-list">\n')
    for c in by_sort(eng_candos):
        translated = tr(c, 'english', lang) if lang != 'mh' else ''
        trans = f' <span class="cando-trans">{esc(translated)}</span>' if translated else ''
        parts.append(f'    <label class="cando"><input type="checkbox" class="cando-check" data-id="{c["id"]}"> <span lang="ja">{to_ruby_html(c["minihongo"])}</span>{trans}</label>\n')
    parts.append('  </div>\n')

    toc.append(('engineering-ai', ui('engineering_ai_heading', lang), []))
    parts.append(f'  <h2 id="engineering-ai" class="section-heading">{ui("engineering_ai_heading", lang)}</h2>\n')
    engineering_chat_body = {
        'en': 'Choose an engineering goal and practice directly with an AI colleague.',
        'ko': '엔지니어용 목표를 골라 AI 동료와 바로 연습해 보세요.',
        'ja': 'エンジニア向けの目標を選び、AIの同僚と開発場面を直接練習できます。',
        'mh': '作【つく】る人【ひと】の目【め】を選【えら】び、AIの人【ひと】と話【はな】す。',
    }[lang]
    parts.append(f'  <p>{to_ruby_html(engineering_chat_body)}</p>\n')
    parts.append(f'  <div id="kaiwa-app" data-topic-set="engineering" data-lang="{lang}"><p class="kaiwa-loading">{ui("kaiwa_loading", lang)}</p></div>\n')
    return wrap_page('engineering', ''.join(parts), lang, toc)


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

    from validate_haiku import validate_haiku
    errors = validate_haiku()
    if errors:
        print("Haiku meter errors:", file=sys.stderr)
        for e in errors:
            print(f"  {e['id']}: {e['issue']}", file=sys.stderr)
            if 'details' in e:
                for line in e['details'].split('\n'):
                    print(f"    {line.strip()}", file=sys.stderr)
        sys.exit(1)

    from validate_vocab import build_vocab, run_validation, VALIDATE_CONTENT
    vocab, char_readings = build_vocab()
    vocab_errors = run_validation('content', VALIDATE_CONTENT, vocab, char_readings)
    if vocab_errors:
        print("Vocabulary errors:", file=sys.stderr)
        for e in vocab_errors:
            print(f"  {e['source']}: {e['issue']}", file=sys.stderr)
        sys.exit(1)

    dialog_groups = load_csv('dialog_groups')
    dialogs_data = load_csv('dialogs')
    stories = load_csv('stories')
    candos = load_csv('candos')
    comprehension = load_csv('comprehension')
    advanced = load_csv('advanced')

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
            ('going-further', gen_going_further(categories, compounds, expressions, advanced, lang)),
            ('reading', gen_reading(categories, haiku, dialog_groups, dialogs_data, stories, lang)),
            ('practice', gen_practice(candos, dialog_groups, dialogs_data, words, grammar, grammar_examples, lang)),
            ('understanding', gen_understanding(categories, comprehension, lang)),
            ('engineering', gen_engineering(categories, expressions, dialog_groups, dialogs_data, candos, words, lang)),
        ]

        for page_id, html in pages:
            path = out_dir / PAGE_FILES[page_id]
            path.write_text(html)
            print(f'  {path}')

        # Kaiwa is a hand-written template (site/pages/kaiwa/index.html) that
        # localizes itself through ui strings; give every edition its own copy.
        if lang != 'en':
            kaiwa_out = PAGES_OUT / lang / 'kaiwa' / 'index.html'
            kaiwa_out.parent.mkdir(parents=True, exist_ok=True)
            kaiwa_out.write_text((PAGES_OUT / 'kaiwa' / 'index.html').read_text())
            print(f'  {kaiwa_out}')


if __name__ == '__main__':
    main()
