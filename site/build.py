#!/usr/bin/env python3
"""
Minihongo static site builder.

- Build-time web components (custom elements with <slot> expansion)
- htmz fragment generation for partial page loads
- Multilingual output (en, ja, mh) from single page source
- Zero dependencies beyond Python 3.10+

Usage: python site/build.py
"""

import csv
import hashlib
import os
import re
import shutil
import tempfile
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).parent
COMPONENTS = ROOT / "components"
PAGES = ROOT / "pages"
STATIC = ROOT / "static"
OUT = ROOT.parent / "docs"
DATA = ROOT.parent / "data"

LANGS = ['en', 'ja', 'mh']
LANG_COL = {'en': 'english', 'ja': 'japanese', 'mh': 'minihongo'}
# mh uses Japanese script, so html lang is 'ja' for it too
HTML_LANGS = {'en': 'en', 'ja': 'ja', 'mh': 'ja'}
LANG_LABELS = {'en': 'English', 'ja': '日本語', 'mh': 'ミニ本語'}
BASE_URLS = {'en': '/', 'ja': '/ja/', 'mh': '/mh/'}


def load_csv(name):
    with open(DATA / f'{name}.csv', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def to_ruby_html(text):
    """Convert bracket notation 人【ひと】 to <ruby>人<rt>ひと</rt></ruby>."""
    return re.sub(
        r'([\u4e00-\u9fff\u3005]+)【([^】]+)】',
        r'<ruby>\1<rt>\2</rt></ruby>',
        text,
    )


def load_nav_labels():
    """Load page names per language from pages.csv."""
    pages = sorted(load_csv('pages'), key=lambda r: int(r['sort_order']))
    labels = {}
    for lang in LANGS:
        lang_labels = {}
        for p in pages:
            col = LANG_COL[lang]
            name = p.get(f'name_{col}', '').strip()
            if not name:
                name = p.get('name_english', '').strip()
            if not name:
                name = p.get('name_minihongo', '').strip()
            lang_labels[p['id']] = to_ruby_html(name)
        labels[lang] = lang_labels
    return labels


def load_meta_descriptions():
    """Load page descriptions per language from pages.csv for <meta> tags."""
    pages = load_csv('pages')
    # Map page IDs to descriptions per lang
    descs = {}
    for lang in LANGS:
        col = {'en': 'desc_en', 'ja': 'desc_ja', 'mh': 'desc_mh'}[lang]
        lang_descs = {}
        for p in pages:
            val = p.get(col, '').strip()
            if not val:
                val = p.get('desc_en', '').strip()
            # Strip furigana brackets for meta tag (plain text)
            lang_descs[p['id']] = re.sub(r'【[^】]+】', '', val)
        descs[lang] = lang_descs
    return descs


# Map page filenames to page IDs for description lookup
PAGE_ID_MAP = {
    'index.html': None,  # homepage uses site-level description
    '404.html': '_404',
    'lessons/2-vocabulary.html': 'vocabulary',
    'lessons/3-grammar.html': 'grammar',
    'lessons/5-word-building.html': 'word-building',
    'lessons/6-texts-dialogs.html': 'reading',
}

STATIC_DESCS = {
    '_404': 'Page not found.',
}


def load_ui_strings():
    """Load ui_strings.csv into nested dict: {key: {lang: value}}."""
    rows = load_csv('ui_strings')
    return {r['key']: r for r in rows}


def ui_str(ui_strings, key, lang):
    """Get UI string with fallback: lang -> en -> mh."""
    row = ui_strings.get(key, {})
    for l in [lang, 'en', 'mh']:
        val = row.get(l, '').strip()
        if val:
            return to_ruby_html(val)
    return key


def detect_lang(rel_path):
    """Detect language from relative page path."""
    s = str(rel_path)
    for prefix in ['ja/', 'mh/']:
        if s.startswith(prefix):
            return prefix.rstrip('/')
    return 'en'


def lang_switcher_html(rel_path, lang):
    """Generate language switcher select with lang codes as values."""
    options = []
    for l in LANGS:
        label = LANG_LABELS[l]
        selected = ' selected' if l == lang else ''
        options.append(f'<option value="{l}"{selected}>{label}</option>')

    return (
        f'<select class="lang-switch" onchange="switchLang(this.value)">'
        f'{"".join(options)}'
        f'</select>'
    )


def load_components():
    """Load component templates. Filename must contain a hyphen (web component spec)."""
    return {
        f.stem: f.read_text()
        for f in sorted(COMPONENTS.glob("*.html"))
        if "-" in f.stem
    }


def extract_slots(inner_html):
    """Parse slotted content from inside a component usage."""
    slots = {}
    named_re = re.compile(r'<(\w+)\s+slot="([^"]+)"[^>]*>(.*?)</\1>', re.DOTALL)
    for m in named_re.finditer(inner_html):
        slots[m.group(2)] = m.group(3).strip()
    default = named_re.sub("", inner_html).strip()
    if default:
        slots[""] = default
    return slots


def fill_slots(template, slots):
    """Replace <slot> elements in a component template with actual content."""
    out = re.sub(
        r'<slot\s+name="([^"]+)">(.*?)</slot>',
        lambda m: slots.get(m.group(1), m.group(2)),
        template,
        flags=re.DOTALL,
    )
    out = re.sub(
        r'<slot>(.*?)</slot>',
        lambda m: slots.get("", m.group(1)),
        out,
        flags=re.DOTALL,
    )
    return out


def expand(html, components):
    """Expand custom element tags inside-out (innermost first)."""
    comp_names = "|".join(re.escape(n) for n in components)
    if not comp_names:
        return html

    inner_re = re.compile(
        rf"<({comp_names})([^>]*)>((?:(?!<(?:{comp_names})[\s>]).)*)</\1>",
        re.DOTALL,
    )

    while True:
        m = inner_re.search(html)
        if not m:
            break
        tag = m.group(1)
        inner = m.group(3)
        slots = extract_slots(inner)
        filled = fill_slots(components[tag], slots)
        html = html[: m.start()] + filled + html[m.end() :]

    return html


def extract_fragment(html):
    """Pull out <main id="content">...</main> for htmz partial loading."""
    m = re.search(r'<main\s+id="content"[^>]*>.*?</main>', html, re.DOTALL)
    return m.group(0) if m else html


def build():
    base_url = os.environ.get("BASE_URL", "/")
    if not base_url.endswith("/"):
        base_url += "/"

    # Build to temp dir, then swap atomically to avoid serving partial state
    tmp_dir = Path(tempfile.mkdtemp(dir=OUT.parent, prefix='.docs_build_'))
    _build_to(tmp_dir, base_url)
    old = OUT.with_name('.docs_old') if OUT.exists() else None
    if old:
        OUT.rename(old)
    tmp_dir.rename(OUT)
    if old:
        shutil.rmtree(old)


def _build_to(OUT, base_url):
    OUT.mkdir(parents=True, exist_ok=True)

    if STATIC.exists():
        shutil.copytree(STATIC, OUT / "static")

    # Copy root-level files (sw.js, manifest.json, etc.)
    for f in ROOT.glob("*.js"):
        shutil.copy2(f, OUT / f.name)
    for f in ROOT.glob("*.json"):
        shutil.copy2(f, OUT / f.name)

    components = load_components()
    nav_labels = load_nav_labels()
    ui_strings = load_ui_strings()
    meta_descs = load_meta_descriptions()
    print(f"components: {', '.join(components)}")

    (OUT / "_f").mkdir()

    for src in sorted(PAGES.rglob("*.html")):
        rel = src.relative_to(PAGES)
        lang = detect_lang(rel)
        lang_base = BASE_URLS[lang] if base_url == "/" else base_url

        html = expand(src.read_text(), components)
        html = html.replace("{{BASE_URL}}", lang_base)
        html = html.replace("{{HTML_LANG}}", HTML_LANGS[lang])

        # Nav labels
        labels = nav_labels[lang]
        html = html.replace("{{NAV_VOCABULARY}}", labels.get('vocabulary', 'Vocabulary'))
        html = html.replace("{{NAV_GRAMMAR}}", labels.get('grammar', 'Grammar'))
        html = html.replace("{{NAV_WORD_BUILDING}}", labels.get('word-building', 'Word Building'))
        html = html.replace("{{NAV_READING}}", labels.get('reading', 'Reading'))

        # Furigana toggle label
        html = html.replace("{{FURIGANA_LABEL}}", ui_str(ui_strings, 'show_readings', lang))

        # Dark mode toggle label
        html = html.replace("{{DARK_MODE_LABEL}}", ui_str(ui_strings, 'dark_mode', lang))

        # Language switcher
        switcher = lang_switcher_html(rel, lang)
        html = html.replace("{{LANG_SWITCHER}}", switcher)

        # Copyright year
        html = html.replace("{{COPYRIGHT_YEAR}}", str(datetime.now().year))

        # Meta description
        page_file = str(rel).replace(f'{lang}/', '') if lang != 'en' else str(rel)
        page_id = PAGE_ID_MAP.get(page_file)
        if page_id and page_id in STATIC_DESCS:
            desc = STATIC_DESCS[page_id]
        elif page_id:
            desc = meta_descs[lang].get(page_id, '')
        else:
            desc = ui_str(ui_strings, 'home_tagline', lang)
            desc = re.sub(r'<[^>]+>', '', desc)  # strip any HTML from ruby
        html = html.replace('{{META_DESCRIPTION}}', desc)

        # Toast strings
        for toast_key in ['toast_offline', 'toast_online', 'toast_install',
                          'toast_install_btn', 'toast_updated']:
            placeholder = '{{' + toast_key.upper() + '}}'
            html = html.replace(placeholder, ui_str(ui_strings, toast_key, lang))

        # Full page
        dest = OUT / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(html)

        # htmz fragment: place under {lang}/_f/ so base + '_f/' works
        # Skip 404 page - no fragment needed
        if rel.name == '404.html':
            print(f"  {rel}")
            continue
        if lang == 'en':
            frag = OUT / '_f' / rel
        else:
            page_rel = Path(*rel.parts[1:])  # strip lang prefix
            frag = OUT / lang / '_f' / page_rel
        frag.parent.mkdir(parents=True, exist_ok=True)
        frag.write_text(extract_fragment(html))

        print(f"  {rel}")

    # Generate sitemap.xml
    site_url = os.environ.get("SITE_URL", "https://minihongo.com")
    sitemap_urls = []
    for f in sorted(OUT.rglob("*.html")):
        rel_path = f.relative_to(OUT)
        if '_f/' in str(rel_path) or rel_path.name == '404.html':
            continue
        path = str(rel_path).replace('index.html', '')
        sitemap_urls.append(f'  <url><loc>{site_url}/{path}</loc></url>')
    sitemap = (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
        + '\n'.join(sitemap_urls) + '\n'
        '</urlset>\n'
    )
    (OUT / 'sitemap.xml').write_text(sitemap)
    print("  sitemap.xml")

    # Generate robots.txt
    robots = f'User-agent: *\nAllow: /\nSitemap: {site_url}/sitemap.xml\n'
    (OUT / 'robots.txt').write_text(robots)
    print("  robots.txt")

    # 404.html is built as a regular page (site/pages/404.html)
    # and lands in the right place for GitHub Pages

    # Hash all output files for cache busting
    h = hashlib.sha256()
    for f in sorted(OUT.rglob("*")):
        if f.is_file() and f.name != "sw.js":
            h.update(f.read_bytes())
    cache_hash = h.hexdigest()[:8]

    # Inject hash into sw.js
    sw = OUT / "sw.js"
    sw.write_text(sw.read_text().replace("{{CACHE_HASH}}", cache_hash))
    print(f"  cache: {cache_hash}")

    print(f"-> {OUT}/")


if __name__ == "__main__":
    build()
