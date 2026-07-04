# ミニ本語 Minihongo

231 words. Infinite expression. Learn to express any idea in Japanese with the minimum vocabulary.

Live at [minihongo.com](https://minihongo.com)

## Goals

- **Make Japanese accessible to everyone.** Even extremely busy people or those with cognitive disabilities can learn 231 words. That is enough to express any idea.
- **Give anyone the minimum tools for self-expression.** Being able to name feelings and needs lowers aggression and frustration.
- **Break down language barriers between communities.** Small minorities can communicate with society at large without relying on ethnic community interpreters. Shared language increases mutual understanding and reduces isolation.

## Lessons

| Lesson | What |
|--------|------|
| Vocabulary | 231 core words by category |
| Grammar | Particles, conjugation, sentence patterns |
| Word Building | Compounds, circumlocution, expressions |
| Reading | Haiku, dialogs, and short stories |
| Practice | Real-life can-do checklist, quizzes, AI conversation prompt |
| Understanding Japan | Real Japanese to recognize, never say: signs, clerk phrases, announcements, forms |

## Languages

Three versions of the entire site:

- **English** - Standard explanations
- **日本語** - Full Japanese translation
- **ミニ本語** - Everything built from the 231 base words, with furigana

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

Spaced-repetition flashcard decks for [Anki](https://apps.ankiweb.net/) with audio on every card. Three language versions:

| Deck | Translation language |
|------|---------------------|
| `minihongo-en.apkg` | English |
| `minihongo-ja.apkg` | Japanese |
| `minihongo-mh.apkg` | Minihongo (definitions in the 231 base words) |

```
make anki                 # build all 3 decks (requires genanki + audio/)
make anki-download        # download decks from latest GitHub release
make anki-release         # build and show upload command
python3 generate_anki.py en   # build only one language
```

Decks are stored as GitHub release assets (tagged `anki-vN`) and downloaded at build time (CI) or manually (`make anki-download`). `site/build.py` copies `.apkg` files into `docs/` if present.

**Deck structure (same for each language):**
- **Vocabulary** (231 words x 2 = 446 cards) - Recognition (JP -> translation) and Recall (translation -> JP), grouped by category
- **Grammar** (~140 cards) - Example sentence with audio -> explanation, grouped by topic
- **Listening** (43 cards) - Whole dialog/story audio -> transcript and translation

Anki ships only the core course above. An expressions deck (`minihongo-{en,ja}-expressions.apkg`) was built previously but is now **frozen** - a grab-bag of circumlocutions, loanwords, and false friends with no single job. It is no longer built (see `BUILD_EXPRESSION_DECKS` in `generate_anki.py`); the last-released assets remain downloadable but are not updated. Advanced vocabulary lives on the Going Further web page, not in Anki.

Requires: `pip install genanki`

## Measurement

The goal is fluency for daily life, so the funnel is measured against it (GoatCounter, aggregate-only, no accounts). Review monthly:

1. Visits and per-lesson pageviews - do learners get past Vocabulary?
2. `download` events - Anki/PDF adoption
3. `audio-*` events - is listening content used at all?
4. `quiz-*-done` events - do learners practice or only read?
5. `cando-*` events - self-reported real-life milestones (one per item, ever)
6. `cando-complete` - a learner claims all 15 daily-life can-dos
7. `ai-prompt-copy` - demand signal for a real conversation tutor

The other half of measurement is qualitative: the NGO loop in OUTREACH.md.

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
├── words.csv               # 231 base vocabulary
├── categories.csv          # Hierarchical sections (self-ref parent_id)
├── grammar.csv             # Grammar points
├── grammar_examples.csv    # Examples per grammar point
├── compounds.csv           # Kanji compounds from the base words
├── expressions.csv         # Creative descriptions from base words
├── comprehension.csv       # Understanding Japan - receptive-only real Japanese
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

This repo includes a `/minihongo` skill for [Claude Code](https://claude.com/claude-code). It makes the AI speak entirely in Minihongo - built from the 231 base words, with furigana.

```
/minihongo
```

The skill lives at `.claude/skills/minihongo/SKILL.md`.

## References

See [RESEARCH.md](RESEARCH.md) for full references, pattern-based teaching research, and analysis of how minimal sentence patterns apply to Japanese.

## Design

- Noto Sans JP for Japanese text
- Light/dark theme toggle
- Furigana toggle (CSS-based ruby visibility)
- Mobile-responsive, single-column layout
- Toast banners for offline/install/update notifications

## License

- **Code** (build scripts, site engine, validators): [MIT](LICENSE)
- **Content** (`data/*.csv` and the generated site content, books, decks, audio): [CC BY-SA 4.0](LICENSE-CONTENT)
