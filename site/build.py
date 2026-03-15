#!/usr/bin/env python3
"""
Minihongo static site builder.

- Template engine with loops, conditionals, filters
- Build-time web components (custom elements with slots + props)
- Fragment generation for SPA navigation
- Multilingual output (en, ja, mh) from single page source
- Zero dependencies beyond Python 3.10+

Usage: python site/build.py
"""

import csv
import hashlib
import os
import re
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime
from pathlib import Path

from engine import Engine, BUILTIN_FILTERS

ROOT = Path(__file__).parent
COMPONENTS = ROOT / "components"
TEMPLATES = ROOT / "templates"
PAGES = ROOT / "pages"
STATIC = ROOT / "static"
OUT = ROOT.parent / "docs"
DATA = ROOT.parent / "data"

LANGS = ['en', 'ja', 'mh']
LANG_COL = {'en': 'english', 'ja': 'japanese', 'mh': 'minihongo'}
HTML_LANGS = {'en': 'en', 'ja': 'ja', 'mh': 'ja'}
LANG_LABELS = {'en': 'English', 'ja': '日本語', 'mh': 'ミニ本語'}
BASE_URLS = {'en': '/', 'ja': '/ja/', 'mh': '/mh/'}

STATIC_DESCS = {'_404': 'Page not found.'}

MEANING_COL_MAP = {'en': 'english', 'ja': 'japanese', 'mh': 'definition_minihongo'}
CAT_NAME_COL_MAP = {'en': 'name_english', 'ja': 'name_japanese', 'mh': 'name_minihongo'}
EXPLANATION_COL_MAP = {'en': 'explanation_english', 'ja': 'explanation_japanese', 'mh': 'explanation_minihongo'}
TRANSLATION_COL_MAP = {'en': 'english', 'ja': 'japanese', 'mh': ''}
SPEAKER_COL_MAP = {'en': 'speaker_english', 'ja': 'speaker_japanese', 'mh': ''}
TITLE_COL_MAP = {'en': 'title_english', 'ja': 'title_japanese', 'mh': 'title_minihongo'}


# ── Data loading ───────────────────────────────────────────────────

def load_csv_table(name):
    with open(DATA / f'{name}.csv', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def load_all_data():
    """Load all CSV tables into a dict."""
    tables = {}
    for f in sorted(DATA.glob('*.csv')):
        tables[f.stem] = load_csv_table(f.stem)
    return tables


def load_ui_strings(data):
    """Build {key: {lang: value}} from ui_strings rows."""
    return {r['key']: r for r in data.get('ui_strings', [])}


# ── Template context builders ──────────────────────────────────────

def ui_str(ui_strings, key, lang):
    """Get UI string with fallback: lang -> en -> mh. Applies ruby conversion."""
    ruby = BUILTIN_FILTERS['ruby']
    row = ui_strings.get(key, {})
    for l in [lang, 'en', 'mh']:
        val = row.get(l, '').strip()
        if val:
            return ruby(val)
    return key


def build_page_id_map(data):
    """Build {page_file: page_id} from pages.csv path column."""
    m = {p['path']: p['id'] for p in data.get('pages', []) if p.get('path')}
    m['index.html'] = None
    m['404.html'] = '_404'
    return m


def build_nav_labels(data, lang):
    """Build nav label dict from pages.csv for a language."""
    ruby = BUILTIN_FILTERS['ruby']
    col = LANG_COL[lang]
    labels = {}
    for p in sorted(data.get('pages', []), key=lambda r: int(r['sort_order'])):
        name = p.get(f'name_{col}', '').strip()
        if not name:
            name = p.get('name_english', '').strip()
        if not name:
            name = p.get('name_minihongo', '').strip()
        labels[p['id']] = ruby(name)
    return labels


def build_meta_desc(data, ui_strings, page_file, lang, page_id_map):
    """Get meta description for a page file."""
    page_id = page_id_map.get(page_file)
    if page_id and page_id in STATIC_DESCS:
        return STATIC_DESCS[page_id]
    if page_id:
        col = {'en': 'desc_en', 'ja': 'desc_ja', 'mh': 'desc_mh'}[lang]
        for p in data.get('pages', []):
            if p['id'] == page_id:
                val = p.get(col, '').strip() or p.get('desc_en', '').strip()
                return re.sub(r'【[^】]+】', '', val)
    # Homepage fallback
    desc = ui_str(ui_strings, 'home_tagline', lang)
    return re.sub(r'<[^>]+>', '', desc)


def lang_switcher_html(lang):
    """Generate language switcher <select>."""
    options = []
    for l in LANGS:
        selected = ' selected' if l == lang else ''
        options.append(f'<option value="{l}"{selected}>{LANG_LABELS[l]}</option>')
    return (
        f'<select class="lang-switch" aria-label="Language" onchange="switchLang(this.value)">'
        f'{"".join(options)}'
        f'</select>'
    )


def build_page_context(data, ui_strings, lang, page_file, base_url, page_id_map):
    """Build the full template context for a page."""
    ruby = BUILTIN_FILTERS['ruby']
    strip_fg = BUILTIN_FILTERS['strip_furigana']
    labels = build_nav_labels(data, lang)
    lang_base = BASE_URLS[lang] if base_url == "/" else base_url

    # Page-specific names from pages.csv
    page_id = page_id_map.get(page_file)
    page_name = ''
    page_name_plain = ''
    page_desc = ''
    if page_id:
        col = LANG_COL[lang]
        for p in data.get('pages', []):
            if p['id'] == page_id:
                raw = p.get(f'name_{col}', '') or p.get('name_english', '')
                page_name = ruby(raw)
                page_name_plain = strip_fg(raw)
                desc_raw = p.get(f'desc_{lang}', '') or p.get('desc_en', '')
                page_desc = ruby(desc_raw)
                break

    # Site name without ruby/furigana for <title>
    site_row = ui_strings.get('site_name', {})
    site_raw = site_row.get(lang, '') or site_row.get('en', '')
    site_name_plain = strip_fg(site_raw)

    return {
        # All CSV data available as data.*
        'data': data,
        # Language
        'lang': lang,
        'LANG_COL': LANG_COL[lang],
        # Layout variables
        'BASE_URL': lang_base,
        'HTML_LANG': HTML_LANGS[lang],
        'NAV_VOCABULARY': labels.get('vocabulary', 'Vocabulary'),
        'NAV_GRAMMAR': labels.get('grammar', 'Grammar'),
        'NAV_WORD_BUILDING': labels.get('word-building', 'Word Building'),
        'NAV_READING': labels.get('reading', 'Reading'),
        'FURIGANA_LABEL': ui_str(ui_strings, 'show_readings', lang),
        'DARK_MODE_LABEL': ui_str(ui_strings, 'dark_mode', lang),
        'LANG_SWITCHER': lang_switcher_html(lang),
        'META_DESCRIPTION': build_meta_desc(data, ui_strings, page_file, lang, page_id_map),
        'PAGE_NAME': page_name,
        'PAGE_NAME_PLAIN': page_name_plain,
        'PAGE_DESC': page_desc,
        'SITE_NAME_PLAIN': site_name_plain,
        'MEANING_COL': MEANING_COL_MAP[lang],
        'CAT_NAME_COL': CAT_NAME_COL_MAP[lang],
        'EXPLANATION_COL': EXPLANATION_COL_MAP[lang],
        'TRANSLATION_COL': TRANSLATION_COL_MAP[lang],
        'SPEAKER_COL': SPEAKER_COL_MAP[lang],
        'TITLE_COL': TITLE_COL_MAP[lang],
        'COPYRIGHT_YEAR': str(datetime.now().year),
        # Toast strings
        'TOAST_OFFLINE': ui_str(ui_strings, 'toast_offline', lang),
        'TOAST_ONLINE': ui_str(ui_strings, 'toast_online', lang),
        'TOAST_INSTALL': ui_str(ui_strings, 'toast_install', lang),
        'TOAST_INSTALL_BTN': ui_str(ui_strings, 'toast_install_btn', lang),
        'TOAST_UPDATED': ui_str(ui_strings, 'toast_updated', lang),
        # UI strings (full dict for template access)
        'ui': {k: ui_str(ui_strings, k, lang) for k in ui_strings},
    }


# ── Web component expansion ───────────────────────────────────────

def load_components():
    """Load component templates. Filename must contain a hyphen."""
    return {
        f.stem: f.read_text()
        for f in sorted(COMPONENTS.glob("*.html"))
        if "-" in f.stem
    }


def _parse_attrs(attrs_str):
    """Parse HTML attributes from a tag string."""
    return dict(re.findall(r'([\w-]+)="([^"]*)"', attrs_str))


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
    """Replace <slot> elements in a component template."""
    out = re.sub(
        r'<slot\s+name="([^"]+)">(.*?)</slot>',
        lambda m: slots.get(m.group(1), m.group(2)),
        template, flags=re.DOTALL,
    )
    out = re.sub(
        r'<slot>(.*?)</slot>',
        lambda m: slots.get("", m.group(1)),
        out, flags=re.DOTALL,
    )
    return out


def expand(html, components):
    """Expand custom element tags inside-out (innermost first).

    Supports:
    - Slot filling: <slot name="x"> replaced by <div slot="x">content</div>
    - Props: HTML attributes become {{prop}} substitutions in the component
    """
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
        attrs_str = m.group(2)
        inner = m.group(3)

        template = components[tag]

        # Prop substitution: HTML attributes -> {{prop}} in component template
        props = _parse_attrs(attrs_str)
        for key, val in props.items():
            if key in ('class', 'id', 'style', 'lang'):
                continue
            template = re.sub(
                r'\{\{\s*' + re.escape(key) + r'\s*\}\}',
                val, template,
            )

        slots = extract_slots(inner)
        filled = fill_slots(template, slots)

        # Forward id/class from custom element to component root element
        for attr in ('id', 'class'):
            if attr in props:
                filled = re.sub(
                    r'^(\s*<\w+)',
                    rf'\1 {attr}="{props[attr]}"',
                    filled,
                    count=1,
                )

        html = html[:m.start()] + filled + html[m.end():]

    return html


def resolve_includes(html):
    """Pre-resolve {% include "file" %} before component expansion."""
    _INC_RE = re.compile(r'\{%\s*include\s+["\']([^"\']+)["\']\s*%\}')
    while True:
        new = _INC_RE.sub(lambda m: (TEMPLATES / m.group(1)).read_text(), html)
        if new == html:
            break
        html = new
    return html


def extract_fragment(html):
    """Pull out <main id="content">...</main> for SPA navigation."""
    m = re.search(r'<main\s+id="content"[^>]*>.*?</main>', html, re.DOTALL)
    return m.group(0) if m else html


# ── Build ──────────────────────────────────────────────────────────

def _cleanup_stale_builds():
    """Remove orphan .docs_build_* temp dirs from interrupted builds."""
    for d in OUT.parent.glob('.docs_build_*'):
        if d.is_dir():
            shutil.rmtree(d)
            print(f"  cleaned up {d.name}")


def check():
    """Run template lint + schema validation. Returns True if all pass."""
    ok = True

    # Template lint
    from lint import lint_all
    errors, file_count = lint_all()
    if errors:
        for e in errors:
            print(f"  {e}")
        print(f"\nlint: {len(errors)} error(s) in {file_count} file(s)")
        ok = False
    else:
        print(f"lint: OK - {file_count} file(s)")

    # Schema validation (frictionless)
    try:
        result = subprocess.run(
            ['frictionless', 'validate', str(DATA / 'datapackage.json')],
            capture_output=True, text=True,
        )
        if result.returncode != 0:
            print(result.stdout)
            if result.stderr:
                print(result.stderr)
            ok = False
        else:
            print("schema: OK")
    except FileNotFoundError:
        print("schema: skipped (frictionless not installed)")

    return ok


def build():
    base_url = os.environ.get("BASE_URL", "/")
    if not base_url.endswith("/"):
        base_url += "/"

    _cleanup_stale_builds()

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

    # Copy audio files if available (from generate_audio.py output or CI download)
    audio_dir = ROOT.parent / "audio"
    if audio_dir.exists():
        shutil.copytree(audio_dir, OUT / "audio")
        print(f"audio: copied from {audio_dir}")

    # Copy Anki decks if available (from generate_anki.py or CI download)
    apkg_files = sorted(ROOT.parent.glob("minihongo-*.apkg"))
    if apkg_files:
        for f in apkg_files:
            shutil.copy2(f, OUT / f.name)
        print(f"anki: copied {len(apkg_files)} deck(s)")

    # Copy PDF books if available (from generate_pdf.py or CI download)
    pdf_files = sorted(ROOT.parent.glob("minihongo-*.pdf"))
    if pdf_files:
        for f in pdf_files:
            shutil.copy2(f, OUT / f.name)
        print(f"pdf: copied {len(pdf_files)} book(s)")

    for f in ROOT.glob("*.js"):
        shutil.copy2(f, OUT / f.name)
    for f in ROOT.glob("*.json"):
        shutil.copy2(f, OUT / f.name)

    # Read CSS for inlining (eliminates render-blocking stylesheet request)
    css_path = STATIC / 'style.css'
    inline_css = css_path.read_text() if css_path.exists() else ''

    loader = lambda path: (TEMPLATES / path).read_text()
    engine = Engine(loader=loader)
    components = load_components()
    data = load_all_data()
    ui_strings = load_ui_strings(data)
    page_id_map = build_page_id_map(data)
    print(f"components: {', '.join(components)}")

    (OUT / "_f").mkdir()

    for src in sorted(PAGES.rglob("*.html")):
        rel = src.relative_to(PAGES)
        lang = _detect_lang(rel)

        # Determine page file (without lang prefix)
        page_file = str(rel).replace(f'{lang}/', '') if lang != 'en' else str(rel)

        # 1. Pre-resolve includes, then expand web components
        html = resolve_includes(src.read_text())
        html = expand(html, components)

        # 2. Render through template engine (resolves all {{ }} and {% %})
        ctx = build_page_context(data, ui_strings, lang, page_file, base_url, page_id_map)
        html = engine.render(html, ctx)

        # 3. Inline CSS to eliminate render-blocking request
        if inline_css:
            html = html.replace(
                '<link rel="stylesheet" href="/static/style.css">',
                f'<style>{inline_css}</style>',
            )

        # Full page
        dest = OUT / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(html)

        # SPA fragment (skip 404)
        if rel.name == '404.html':
            print(f"  {rel}")
            continue
        if lang == 'en':
            frag = OUT / '_f' / rel
        else:
            page_rel = Path(*rel.parts[1:])
            frag = OUT / lang / '_f' / page_rel
        frag.parent.mkdir(parents=True, exist_ok=True)
        frag.write_text(extract_fragment(html))

        print(f"  {rel}")

    # sitemap.xml
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

    # robots.txt
    (OUT / 'robots.txt').write_text(
        f'User-agent: *\nAllow: /\nSitemap: {site_url}/sitemap.xml\n'
    )
    print("  robots.txt")

    # Auto-generate PRECACHE list from built files
    precache = ["'./'", "'static/style.css'", "'static/app.js'"]
    for f in sorted(OUT.rglob("*.html")):
        rel_path = str(f.relative_to(OUT))
        if f.name == '404.html':
            continue
        # index.html -> directory URL (e.g. 'ja/' instead of 'ja/index.html')
        url = rel_path.replace('index.html', '') if rel_path.endswith('index.html') else rel_path
        if not url or url == './' or url == '/':
            continue  # already in static list as './'
        precache.append(f"'{url}'")
    precache_js = '[\n  ' + ',\n  '.join(precache) + ',\n]'

    # Cache busting hash
    h = hashlib.sha256()
    for f in sorted(OUT.rglob("*")):
        if f.is_file() and f.name != "sw.js":
            h.update(f.read_bytes())
    cache_hash = h.hexdigest()[:8]

    sw = OUT / "sw.js"
    sw_text = sw.read_text()
    sw_text = sw_text.replace("{{PRECACHE}}", precache_js)
    sw_text = sw_text.replace("{{CACHE_HASH}}", cache_hash)
    sw.write_text(sw_text)

    app_js = OUT / "static" / "app.js"
    app_js.write_text(app_js.read_text().replace("{{CACHE_HASH}}", cache_hash))

    print(f"  cache: {cache_hash}")

    print(f"-> {OUT}/")


def _detect_lang(rel_path):
    s = str(rel_path)
    for prefix in ['ja/', 'mh/']:
        if s.startswith(prefix):
            return prefix.rstrip('/')
    return 'en'


if __name__ == "__main__":
    if '--check' in sys.argv:
        sys.exit(0 if check() else 1)
    build()
