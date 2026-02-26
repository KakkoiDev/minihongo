# ミニ本語 Minihongo

181 words. Infinite expression. Learn to express any idea in Japanese with the minimum vocabulary.

## Lessons

| # | Lesson | What |
|---|--------|------|
| 1 | ひらがな | 46 base + dakuten + combinations |
| 2 | 言葉 | 181 core words by category |
| 3 | 文法 | Particles, conjugation, sentence patterns |
| 4 | カタカナ | Full katakana + special rules |
| 5 | 言葉作り | Compounds, circumlocution, loanwords |
| 6 | 読み物 | Texts and dialogs |

## Stack

- Plain HTML + CSS, no framework
- Python build script (`site/build.py`) — build-time web components with `<slot>` expansion
- [htmz](https://leanrada.com/htmz/) for partial page loads
- GitHub Pages

## Build

```
python site/build.py
```

Requires Python 3.10+. Zero external dependencies.

Output goes to `docs/`.

## Structure

```
site/
├── build.py              # Static site generator
├── components/           # Reusable HTML components
│   ├── page-layout.html
│   ├── vocab-card.html
│   ├── kana-table.html
│   └── grammar-point.html
├── pages/                # Source pages
│   ├── index.html
│   └── lessons/
├── static/
│   └── style.css
└── sw.js                 # Service worker
docs/                     # Built output (GitHub Pages)
```

## Design

- Noto Sans JP for Japanese text
- Light/dark via `prefers-color-scheme`
- Pure CSS furigana toggle
- Mobile-responsive
