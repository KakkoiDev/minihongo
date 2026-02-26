#!/usr/bin/env python3
"""
Minihongo static site builder.

- Build-time web components (custom elements with <slot> expansion)
- htmz fragment generation for partial page loads
- Zero dependencies beyond Python 3.10+

Usage: python site/build.py
"""

import hashlib
import os
import re
import shutil
from pathlib import Path

ROOT = Path(__file__).parent
COMPONENTS = ROOT / "components"
PAGES = ROOT / "pages"
STATIC = ROOT / "static"
OUT = ROOT.parent / "docs"


def load_components():
    """Load component templates. Filename must contain a hyphen (web component spec)."""
    return {
        f.stem: f.read_text()
        for f in sorted(COMPONENTS.glob("*.html"))
        if "-" in f.stem
    }


def extract_slots(inner_html):
    """Parse slotted content from inside a component usage.

    Named slots:   <span slot="title">Hello</span>  -> slots["title"] = "Hello"
    Default slot:  everything else                    -> slots[""]
    """
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
    # Named: <slot name="x">fallback</slot>
    out = re.sub(
        r'<slot\s+name="([^"]+)">(.*?)</slot>',
        lambda m: slots.get(m.group(1), m.group(2)),
        template,
        flags=re.DOTALL,
    )
    # Default: <slot>fallback</slot>
    out = re.sub(
        r'<slot>(.*?)</slot>',
        lambda m: slots.get("", m.group(1)),
        out,
        flags=re.DOTALL,
    )
    return out


def expand(html, components):
    """Expand custom element tags inside-out (innermost first).

    Uses a regex that only matches components whose inner content
    contains no other component tags. Repeats until all are expanded.
    """
    comp_names = "|".join(re.escape(n) for n in components)
    if not comp_names:
        return html

    # Match a component whose content has NO nested component opening tags.
    # The negative lookahead (?!<(comp-names)) at each char prevents matching
    # outer components before their children are expanded.
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

    if OUT.exists():
        shutil.rmtree(OUT)
    OUT.mkdir(parents=True)

    if STATIC.exists():
        shutil.copytree(STATIC, OUT / "static")

    # Copy root-level files (sw.js etc.)
    for f in ROOT.glob("*.js"):
        shutil.copy2(f, OUT / f.name)

    components = load_components()
    print(f"components: {', '.join(components)}")

    frag_dir = OUT / "_f"
    frag_dir.mkdir()

    for src in sorted(PAGES.rglob("*.html")):
        rel = src.relative_to(PAGES)
        html = expand(src.read_text(), components)
        html = html.replace("{{BASE_URL}}", base_url)

        # Full page
        dest = OUT / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(html)

        # htmz fragment (just the <main> element)
        frag = frag_dir / rel
        frag.parent.mkdir(parents=True, exist_ok=True)
        frag.write_text(extract_fragment(html))

        print(f"  {rel}")

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
