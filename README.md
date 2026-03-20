# ミニ本語 Minihongo

206 words. Infinite expression. Learn to express any idea in Japanese with the minimum vocabulary.

Live at [minihongo.com](https://minihongo.com)

## Goals

- **Make Japanese accessible to everyone.** Even extremely busy people or those with cognitive disabilities can learn 206 words. That is enough to express any idea.
- **Give anyone the minimum tools for self-expression.** Being able to name feelings and needs lowers aggression and frustration.
- **Break down language barriers between communities.** Small minorities can communicate with society at large without relying on ethnic community interpreters. Shared language increases mutual understanding and reduces isolation.

## Lessons

| Lesson | What |
|--------|------|
| Vocabulary | 206 core words by category |
| Grammar | Particles, conjugation, sentence patterns |
| Word Building | Compounds, circumlocution, expressions |
| Reading | Haiku, dialogs, and short stories |

## Languages

Three versions of the entire site:

- **English** - Standard explanations
- **日本語** - Full Japanese translation
- **ミニ本語** - Everything written using only the 206 base words, with furigana

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
| `minihongo-mh.apkg` | Minihongo (definitions in the 206 base words) |

```
make anki                 # build all 3 decks (requires genanki + audio/)
make anki-download        # download decks from latest GitHub release
make anki-release         # build and show upload command
python3 generate_anki.py en   # build only one language
```

Decks are stored as GitHub release assets (tagged `anki-vN`) and downloaded at build time (CI) or manually (`make anki-download`). `site/build.py` copies `.apkg` files into `docs/` if present.

**Deck structure (same for each language):**
- **Vocabulary** (206 words x 2 = 412 cards) - Recognition (JP -> translation) and Recall (translation -> JP), grouped by category
- **Grammar** (106 cards) - Example sentence with audio -> explanation, grouped by topic

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
├── words.csv               # 206 base vocabulary
├── categories.csv          # Hierarchical sections (self-ref parent_id)
├── grammar.csv             # Grammar points
├── grammar_examples.csv    # Examples per grammar point
├── compounds.csv           # Kanji compounds from the 206
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

This repo includes a `/minihongo` skill for [Claude Code](https://claude.com/claude-code). It makes the AI speak entirely in Minihongo - only the 206 base words, with furigana.

```
/minihongo
```

The skill lives at `.claude/skills/minihongo/SKILL.md`.

## References

The vocabulary and grammar draw on research into minimal languages, linguistic universals, and simplified communication systems.

### Vocabulary Foundations

- **[Swadesh List](https://en.wikipedia.org/wiki/Swadesh_list)** - Morris Swadesh's 100/207-word core vocabulary lists, used in historical linguistics to compare languages. The 100-word list defines concepts found in every natural language (body, water, fire, eat, die, stone, mountain, etc.). Used to validate base word coverage and identify practical gaps.
- **[Natural Semantic Metalanguage (NSM)](https://nsm-approach.net/)** - Anna Wierzbicka and Cliff Goddard's theory identifying ~65 semantic primes: concepts proven irreducible across 30+ languages. NSM Chart v20 (May 2022). Key insight: some concepts (SMALL, SAME, MAYBE) genuinely cannot be decomposed into other words. Used to ensure the vocabulary has no structural holes.
  - [NSM Semantic Primes Chart v20](https://nsm-approach.net/wp-content/uploads/2022/05/Chart-of-NSM-Semantic-Primes_English_v20_May-2022.pdf)
  - [150 Canonical Sentences v7](https://intranet.secure.griffith.edu.au/__data/assets/pdf_file/0018/346032/150_NSM_CanonicalSentences_v5_05_2017.pdf)
  - Goddard & Wierzbicka 2014, *Studies in Language*
  - Goddard & Wierzbicka 2018, *Meaning and Universal Grammar* Vol. 1-2, Benjamins
- **[Toki Pona](https://tokipona.org/)** - Sonja Lang's conlang proves ~120 root words can express any idea through compounding. Validates the core philosophy: combine primitives instead of memorizing thousands of words.
- **[Basic English](https://en.wikipedia.org/wiki/Basic_English)** - C.K. Ogden's 850-word simplified English (1930) showed a controlled vocabulary can cover everyday communication. Minihongo pushes further: fewer words, full grammar.
- **[Semantic primes research](https://en.wikipedia.org/wiki/Semantic_primes)** - Cross-linguistic studies identifying concepts present in every known language.

### Grammar Foundations

- **[Yasashii Nihongo (Easy Japanese)](https://en.wikipedia.org/wiki/Easy_Japanese)** - Government-backed simplified Japanese framework (Immigration Services Agency, Agency for Cultural Affairs, 2020). Developed by Hirosaki University Sociolinguistics Lab (1999) for foreigners and people with disabilities. Requires masu/desu register, drops keigo/passive/causative. Directly informs Minihongo's grammar design.
  - [Hirosaki University Yasashii Nihongo research](https://pmc.ncbi.nlm.nih.gov/articles/PMC8063522/)
  - [Yasashii Nihongo in disaster communication](https://qz.com/1587361/how-yasashii-nihongo-or-easy-japanese-keeps-foreigners-safe)
- **[Greenberg's Linguistic Universals](https://en.wikipedia.org/wiki/Linguistic_universal)** - Joseph Greenberg's 45 universals (1963) identify grammatical features present across all/most languages. Confirmed: predication, negation, questioning, modification are absolute universals. Tense marking and passive voice are NOT universal.
- **[WALS - World Atlas of Language Structures](https://wals.info/)** - Survey of 2,500+ languages confirming typological patterns. Used to validate which grammar features are truly universal vs culturally specific.
- **[JLPT N5 Grammar](https://jlptsensei.com/jlpt-n5-grammar-list/)** - The most basic level of the Japanese Language Proficiency Test (~130 grammar points). Used as a practical benchmark for what grammar enables daily communication in Japan.
  - [Bunpro N5 Grammar Deck](https://bunpro.jp/decks/nn10ai/Bunpro-N5-Grammar)
- **NSM Universal Syntax** - NSM identifies 10 universal syntactic frame types (predication, complementation, causation, conditional, temporal, locative, possession, existence, negation, evaluation). Used to verify Minihongo's grammar covers the universal baseline.

### Number Systems

- **[Piraha anumeracy](https://news.mit.edu/2008/language-0624)** - Frank et al. (2008). Piraha speakers have zero exact number words and cannot learn counting, proving exact number is a cultural technology enabled by language.
- **[Munduruku arithmetic](https://www.science.org/doi/abs/10.1126/science.1102085)** - Pica et al. (2004). Munduruku speakers (words for 1-4 only) can do approximate but not exact arithmetic above 4-5.
- **[WALS Chapter 131: Numeral Bases](https://wals.info/chapter/131)** - Survey of 196 languages showing 10% have restricted number systems (not reliably past ~20).
- **Esperanto number system** - 12 root morphemes (0-9, 10, 100, 1000) generate any number via multiplicative-additive rules. Model for minimal productive number systems.

### Textbook References

- **Genki I & II** (Banno et al., Japan Times) - Grammar progression used as practical benchmark
- **Minna no Nihongo I** (3A Corporation) - Alternative grammar progression comparison
- **[Tae Kim's Guide to Japanese Grammar](https://www.guidetojapanese.org/)** - Essential grammar reference

## Design

- Noto Sans JP for Japanese text
- Light/dark theme toggle
- Furigana toggle (CSS-based ruby visibility)
- Mobile-responsive, single-column layout
- Toast banners for offline/install/update notifications
