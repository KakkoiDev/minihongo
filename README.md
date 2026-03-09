# ミニ本語 Minihongo

182 words. Infinite expression. Learn to express any idea in Japanese with the minimum vocabulary.

Live at [minihongo.com](https://minihongo.com)

## Goals

- **Make Japanese accessible to everyone.** Even extremely busy people or those with cognitive disabilities can learn 182 words. That is enough to express any idea.
- **Give anyone the minimum tools for self-expression.** Being able to name feelings and needs lowers aggression and frustration.
- **Break down language barriers between communities.** Small minorities can communicate with society at large without relying on ethnic community interpreters. Shared language increases mutual understanding and reduces isolation.

## Lessons

| Lesson | What |
|--------|------|
| Vocabulary | 182 core words by category |
| Grammar | Particles, conjugation, sentence patterns |
| Word Building | Compounds, circumlocution, expressions |
| Reading | Haiku, dialogs, and short stories |

## Languages

Three versions of the entire site:

- **English** - Standard explanations
- **日本語** - Full Japanese translation
- **ミニ本語** - Everything written using only the 182 base words, with furigana

## Stack

- Plain HTML + CSS, no framework
- CSV as flat-file database - normalized tables with foreign keys, versionable in git, editable in any spreadsheet. Schema and referential integrity validated with [Frictionless Data](https://framework.frictionlessdata.io/)
- Python build script (`site/build.py`) - build-time web components with `<slot>` expansion
- SPA navigation via fetch + DOMParser (no framework)
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

## Audio

Audio files are not in the repo. They are stored as GitHub release assets and downloaded at build time (CI) or manually (local dev).

```
make audio-download       # download audio from latest GitHub release
make audio                # generate audio locally (requires edge-tts + ffmpeg)
make audio-release        # package audio for upload to GitHub releases
```

**How it works:**
1. `generate_audio.py` uses Microsoft Edge TTS to create MP3s from the minihongo text in each CSV
2. Audio files go into `audio/` (gitignored) with subdirectories: `w/` (words), `ge/` (grammar), `c/` (compounds), `e/` (expressions), `h/` (haiku), `d/` (dialogs), `s/` (stories)
3. `site/build.py` copies `audio/` into `docs/audio/` if the directory exists
4. The service worker skips audio files (no caching). Play buttons are disabled when offline
5. Audio releases are tagged `audio-vN` on GitHub. CI downloads the latest release during the Pages build

**Updating audio after content changes:**
1. Edit CSV data
2. Delete affected files in `audio/` (the script skips existing files)
3. Run `make audio` to regenerate
4. Run `make audio-release` and upload with `gh release create`

## Anki Deck

A spaced-repetition flashcard deck for [Anki](https://apps.ankiweb.net/) with audio on every card.

```
make anki                 # build minihongo.apkg (requires genanki + audio/)
make anki-release         # build and show upload command
```

Download the latest deck from [GitHub Releases](https://github.com/KakkoiDev/minihongo/releases) (tagged `anki-vN`).

**Deck structure:**
- **Vocabulary** (182 words x 2 = 364 cards) - Recognition (JP -> EN) and Recall (EN -> JP), grouped by category
- **Grammar** (45 cards) - Example sentence with audio -> English explanation, grouped by topic

Requires: `pip install genanki`

## Dev

```
make serve                # build and serve (no file watching)
make watch                # build, serve, and rebuild on file changes
make watch PORT=8000      # custom port (default 3000)
```

`make watch` requires [entr](https://eradman.com/entrern/).

## Structure

```
data/
├── datapackage.json        # Frictionless schema + FK constraints
├── words.csv               # 182 base vocabulary
├── categories.csv          # Hierarchical sections (self-ref parent_id)
├── grammar.csv             # Grammar points
├── grammar_examples.csv    # Examples per grammar point
├── compounds.csv           # Kanji compounds from the 182
├── expressions.csv         # Creative descriptions from base words
├── haiku.csv, dialogs.csv, stories.csv  # Reading content
├── ui_strings.csv          # UI text (en/ja/mh)
└── pages.csv               # Page metadata and nav labels
generate_pages.py           # CSV data -> site/pages/ HTML
generate_audio.py           # CSV data -> audio/ MP3s (edge-tts)
generate_anki.py            # CSV data + audio -> minihongo.apkg
SCHEMA.md                   # Relational schema documentation
site/
├── engine.py               # Template engine (for/if/set/include/filters)
├── build.py                # Static site generator
├── lint.py                 # Template syntax linter
├── components/             # Build-time web components
│   ├── page-layout.html    # Main layout with nav, htmz, toast
│   └── grammar-point.html  # Reusable grammar card
├── templates/              # Data-driven page templates
│   ├── vocabulary.html     # Renders words.csv
│   └── grammar.html        # Renders grammar.csv + examples
├── pages/                  # Generated pages (en/, ja/, mh/)
│   ├── index.html
│   └── lessons/…
├── static/
│   ├── app.js              # Theme, furigana, lang switch, toast, PWA
│   └── style.css
├── sw.js                   # Service worker
└── manifest.json           # PWA manifest
audio/                      # TTS audio files (gitignored, from GH release)
docs/                       # Built output (gitignored, built in CI)
```

## Claude Code Skill

This repo includes a `/minihongo` skill for [Claude Code](https://claude.com/claude-code). It makes the AI speak entirely in Minihongo - only the 182 base words, with furigana.

```
/minihongo
```

The skill lives at `.claude/skills/minihongo/SKILL.md`.

## References

The 182-word list draws on research into minimal and constructed vocabularies:

- **[Toki Pona](https://tokipona.org/)** - Sonja Lang's conlang proves ~120 root words can express any idea through compounding. Minihongo borrows this philosophy: combine primitives instead of memorizing thousands of words.
- **[Swadesh List](https://en.wikipedia.org/wiki/Swadesh_list)** - Morris Swadesh's 100/207-word core vocabulary lists, used in historical linguistics to compare languages. Many Minihongo base words overlap with Swadesh universals (body, water, fire, eat, die, etc.).
- **[Natural Semantic Metalanguage (NSM)](https://nsm-approach.net/)** - Anna Wierzbicka's theory that all human languages share ~65 semantic primes (I, you, want, know, good, bad, big, small...). These primes informed which abstract concepts to include.
- **[Basic English](https://en.wikipedia.org/wiki/Basic_English)** - C.K. Ogden's 850-word simplified English (1930) showed a controlled vocabulary can cover everyday communication. Minihongo pushes further: fewer words, full grammar.
- **[Semantic primes research](https://en.wikipedia.org/wiki/Semantic_primes)** - Cross-linguistic studies identifying concepts that exist in every known language. Used to validate that the 182 words cover universal human expression.

## Design

- Noto Sans JP for Japanese text
- Light/dark theme toggle
- Furigana toggle (CSS-based ruby visibility)
- Mobile-responsive, single-column layout
- Toast banners for offline/install/update notifications
