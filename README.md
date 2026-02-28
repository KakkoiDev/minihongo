# ミニ本語 Minihongo

182 words. Infinite expression. Learn to express any idea in Japanese with the minimum vocabulary.

Live at [minihongo.com](https://minihongo.com)

## Lessons

| # | Lesson | What |
|---|--------|------|
| 2 | 言葉 | 182 core words by category |
| 3 | 文法 | Particles, conjugation, sentence patterns |
| 5 | 言葉作り | Compounds, circumlocution, loanwords |
| 6 | 読み物 | Haiku, dialogs, and short stories |

## Languages

Three versions of the entire site:

- **English** - Standard explanations
- **日本語** - Full Japanese translation
- **ミニ本語** - Everything written using only the 182 base words, with furigana

## Stack

- Plain HTML + CSS, no framework
- CSV data files generate all page content via `generate_pages.py`
- Python build script (`site/build.py`) - build-time web components with `<slot>` expansion
- [htmz](https://leanrada.com/htmz/) for partial page loads (SPA navigation without JS framework)
- PWA with service worker, offline support, install prompt
- GitHub Pages via GitHub Actions

## Build

```
make build
```

Or step by step:

```
python generate_pages.py   # CSV data -> HTML pages
python site/build.py       # pages + components -> docs/
```

Requires Python 3.10+. Zero external dependencies.

## Dev

```
make watch
```

Starts a local server on port 3000 with auto-rebuild on file changes.

## Structure

```
data/
├── words.csv             # 182 base vocabulary
├── categories.csv        # Word/section categories
├── compounds.csv         # Real kanji compounds from the 182
├── expressions.csv       # BYOV and common word expressions
├── grammar.csv           # Grammar points
├── grammar_examples.csv  # Grammar examples
├── haiku.csv             # Haiku texts
├── dialogs.csv           # Dialog lines
├── stories.csv           # Short stories
├── ui_strings.csv        # UI text (en/ja/mh)
└── pages.csv             # Page metadata
generate_pages.py         # CSV -> site/pages/ HTML generator
site/
├── build.py              # Static site generator
├── components/           # Reusable HTML components
│   └── page-layout.html  # Main layout with nav, htmz, toast system
├── pages/                # Source pages (en, ja/, mh/)
├── static/
│   └── style.css
├── sw.js                 # Service worker
└── manifest.json         # PWA manifest
docs/                     # Built output (gitignored, built in CI)
```

## Design

- Noto Sans JP for Japanese text
- Light/dark theme toggle
- Furigana toggle (CSS-based ruby visibility)
- Mobile-responsive, single-column layout
- Toast banners for offline/install/update notifications
