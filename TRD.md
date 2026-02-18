# Minihongo Technical Requirements Document

**Status**: Authoritative spec — single source of truth for the project.

Minihongo ミニ本語 is a minimal Japanese fluency system. 354 core words + grammar + loanwords = ability to express any idea. The curriculum is self-bootstrapping: the language explains itself.

---

## 1. Lesson Plan (6 Lessons)

| # | Lesson | Content | Cards |
|---|--------|---------|-------|
| 1 | Hiragana | 46 base + 25 dakuten/handakuten + 33 combinations = 104 chars | ~208 (2 templates) |
| 2 | Vocabulary | All 354 base words grouped by category | ~1,062 (3 templates) |
| 3 | Grammar | 16 particles, verb conjugation, sentence patterns, complex sentences | ~150 (3 templates) |
| 4 | Katakana | 46 base + 25 dakuten/handakuten + 33 combinations + special rules (ー, ッ, ファ etc) | ~208 (2 templates) |
| 5 | Word Building | Real compounds (~310) + creative circumlocution (~200) + loanwords (250) + false friends | ~2,580 (3 templates) |
| 6 | Texts & Dialogs | Short stories, conversations, practical scenarios in minihongo | ~150 (3 templates) |

**Reference pages**: Hiragana chart, Katakana chart, vocabulary lookup, grammar cheat sheet.

### Lesson 1: Hiragana

**Objective**: Read and write all hiragana.

Content:
- 5 vowels (あいうえお)
- 10 consonant rows (か-わ)
- Dakuten (がざだば) and handakuten (ぱ)
- Combinations (きゃ, しゃ, etc.)
- Long vowels, small っ

**Prerequisite for everything.** All subsequent content is in kana/kanji.

### Lesson 2: Vocabulary

**Objective**: Learn all 354 base words.

Words are grouped by category:
- Pronouns & People
- Objects & Materials
- Nature & Elements
- Living Things
- Body Parts
- Verbs (67 words)
- Adjectives & Qualities
- Colors & Senses
- Time & Space
- Logic & Connectors & Essentials

All words presented in kana/kanji with furigana. Every word appears inside a sentence that uses only the 354-word vocabulary.

### Lesson 3: Grammar

**Objective**: Master particles, conjugation, and sentence patterns.

Content:
1. Core particles: は, が, を, に, で, の
2. Additional particles: も, と, や, から, まで, へ, か, ね, よ, しか
3. Verb conjugation: 3 groups, masu form, te form, ta form, nai form
4. Sentence patterns: SOV, questions, negation, desire (たい)
5. Te-form patterns: ている, てもいい, てはいけない, てみる, ておく
6. Complex sentences: もし...たら, ...ので, ...けど, relative clauses

### Lesson 4: Katakana

**Objective**: Read and write all katakana.

Content:
- All 46 base katakana (mapped to known hiragana)
- Dakuten, handakuten, combinations
- Special katakana rules: long vowels (ー), small ッ, ファ/フィ/フェ/フォ

### Lesson 5: Word Building

**Objective**: Expand expression through compounds, circumlocution, and loanwords.

Sub-sections:
1. **Real compounds** (~310): Productive patterns (~方, ~物, ~手, ~中), nature/body/abstract compounds
2. **Creative circumlocution** (~200): Describe anything by combining base words (e.g., 空へ行く機械 = airplane)
3. **Loanwords** (250): Essential katakana loanwords across all categories
4. **False friends**: Wasei-eigo traps with correct meanings

> **PENDING**: User wants to review the 300-word katakana loanword selection before finalizing. Current target is 250 after review.

### Lesson 6: Texts & Dialogs

**Objective**: Read and produce connected text in minihongo.

Content:
- Short stories using only the 354-word vocabulary
- Conversations: daily life, shopping, directions, introductions
- Practical scenarios demonstrating circumlocution in action

---

## 2. Key Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Romaji | **None** | All content in kana/kanji with furigana. Romaji is a crutch. |
| Bilingual | **English / Minihongo toggle** | Site explains itself in its own language. |
| TTS engine | **Edge TTS** | Free, high quality. `ja-JP-NanamiNeural` / `ja-JP-KeitaNeural`. |
| Card style | **Sentence-based** | Every word in context. Only 354-word vocabulary in sentences. |
| Furigana | **Tappable reveal** | Question side shows kanji; tap to reveal reading. |
| Katakana words | **Review pending** | User will review the 300-word selection before finalizing. |

---

## 3. Website

### Tech Stack

- **Plain HTML + CSS** — no framework, no build step beyond pandoc
- **Hosting**: GitHub Pages (CNAME: minihongo.com)
- **Build**: `content/*.md -> build.sh (pandoc + template) -> docs/*.html`
- **CSS**: Single file, classless-friendly. Noto Sans JP for Japanese.

### Build Process

```
content/*.md -> build.sh (pandoc + HTML template) -> docs/*.html -> git push
```

- One shell script wraps markdown in shared HTML template
- Template: header, nav, footer, bilingual toggle, furigana toggle

### Sitemap

```
minihongo.com/
├── index.html                  # Landing page
├── lessons/
│   ├── 1-hiragana.html
│   ├── 2-vocabulary.html
│   ├── 3-grammar.html
│   ├── 4-katakana.html
│   ├── 5-word-building.html
│   └── 6-texts-dialogs.html
├── reference/
│   ├── hiragana.html           # Hiragana chart
│   ├── katakana.html           # Katakana chart
│   ├── vocabulary.html         # Full 354-word list
│   └── grammar.html            # Grammar cheat sheet
├── anki.html                   # Anki deck download
└── minihongo.apkg              # Anki deck file
```

### Bilingual Toggle

- `<div class="en">` and `<div class="mh">` blocks in same page
- JS toggle: swap visibility via CSS class on `<body>`
- Persists via localStorage
- Minihongo content uses the self-bootstrapped grammar (written in 354 words)

### Furigana Toggle

- Show/hide readings above kanji
- JS toggle + localStorage persistence
- Default: furigana shown

### Design

- Clean, minimal, lots of whitespace
- Noto Sans JP for Japanese text
- Mobile-responsive via simple CSS
- Light/dark via `prefers-color-scheme` only
- No animations, no icons, no bloat

---

## 4. Anki Deck

### Core Principle

Every word is presented inside a sentence. Every sentence uses only the 354 base vocabulary (+ the loanword being taught, for loanword cards). Self-bootstrapping: the deck teaches itself.

### TTS

- **Engine**: Microsoft Edge TTS (`edge-tts`)
- **Voices**: `ja-JP-NanamiNeural` (female) / `ja-JP-KeitaNeural` (male)
- **Audio**: One MP3 per sentence, cached by content hash

### Card Model: Sentence

**Fields:**

| Field | Content | Example |
|-------|---------|---------|
| Sentence | Target sentence with furigana `漢字[かな]` | 私[わたし]は 毎日[まいにち] 水[みず]を 飲[の]みます。 |
| Audio | `[sound:hash.mp3]` | |
| Translation | English meaning | I drink water every day. |
| KeyWord | Word being taught | 飲む |
| KeyMeaning | English meaning of key word | to drink |
| Category | Lesson/deck tag | core-verb |
| Notes | Extra context | 飲み物 = drink (noun) |

**3 Templates per note:**

1. **Reading** — Front: sentence in kanji (furigana tappable). Back: audio + translation + key word meaning.
2. **Listening** — Front: audio only. Back: sentence + furigana + translation + key word meaning.
3. **Production** — Front: translation + key word hint. Back: sentence + furigana + audio.

### Card Model: Kana (Hiragana & Katakana)

**Fields:** `Character`, `Reading`, `Audio`, `Row`

**2 Templates per note:**

1. **Recognition**: Character -> Reading + Audio
2. **Production**: Reading -> Character + Audio

### Deck Structure

```
Minihongo/
├── 0. Hiragana/             # 104 chars, 2 templates
├── 1. Vocabulary/           # 354 words, 3 templates each
├── 2. Grammar/              # ~50 pattern sentences, 3 templates
├── 3. Katakana/             # 104 chars, 2 templates
├── 4. Word Building/        # Compounds + loanwords + false friends, 3 templates
└── 5. Dialogs/              # Conversation cards, 3 templates
```

### Sentence Rules

1. Every sentence uses only words from the 354 base set (+ loanword being taught for loanword cards)
2. One sentence per vocabulary word minimum
3. Sentences: natural, short (5-12 words), everyday situations
4. Grammar cards reuse vocabulary sentences, highlight grammar point
5. Compound/circumlocution cards: sentence demonstrates the construction
6. False friend cards: sentence shows the correct Japanese meaning

### Sentence Validation

```
Parse sentence -> strip furigana -> tokenize (fugashi/mecab) -> check against 354-word list -> flag violations
```

### Tagging

```
Tags:
  lesson:1, lesson:2, ... lesson:6
  category:noun, category:verb, category:adjective
  category:particle, category:compound, category:loanword
  category:false-friend, category:circumlocution
  tier:core, tier:loanword
```

### Card Counts (Estimated)

| Deck | Notes | Cards |
|------|-------|-------|
| 0. Hiragana | 104 | 208 (x2) |
| 1. Vocabulary | 354 | 1,062 (x3) |
| 2. Grammar | ~50 | ~150 (x3) |
| 3. Katakana | 104 | 208 (x2) |
| 4. Word Building | ~860 | ~2,580 (x3) |
| 5. Dialogs | ~50 | ~150 (x3) |
| **Total** | **~1,522** | **~4,358** |

### Generation Pipeline

```bash
# 1. Prepare sentence data (CSV per deck)
python scripts/validate_sentences.py       # Check against 354-word list

# 2. Generate audio
python scripts/generate_audio.py --all     # Edge TTS, cached by hash

# 3. Build deck
python scripts/generate_deck.py -o minihongo.apkg
```

### Dependencies

- `edge-tts` — Microsoft TTS
- `genanki` — .apkg generation
- `fugashi` + `unidic-lite` — tokenization for sentence validation

---

## 5. Source Files

| File | Used In |
|------|---------|
| comprehensive_japanese_vocabulary_v4_no_redundancy.md | Lesson 2, Reference, Anki |
| minimal_japanese_grammar_v4_pure.md | Lesson 3, Reference, Bilingual |
| grammar_guide_pure_354_validated.md | Lesson 3, Reference |
| grammar_examples_v4_vocabulary_test.md | Lesson 3 practice |
| word_combinations_v4_validated.md | Lesson 5, Reference, Anki |
| creative_compounds_v4.md | Lesson 5, Anki |
| katakana_loanwords_expanded.md | Lesson 5, Reference, Anki |
| thinking_in_minimal_japanese.md | Landing page, About |

---

## 6. Implementation Phases

### Phase 1: Content Preparation
- [ ] Normalize all .md source files into consistent format
- [ ] Split vocabulary into lesson groups
- [ ] Write English lesson text for each of 6 lessons
- [ ] Write minihongo lesson text for bilingual toggle
- [ ] Validate: every example uses only 354-word set
- [ ] Review and finalize katakana loanword selection (250 words)

### Phase 2: Anki Deck
- [ ] Write sentence data (CSV per deck)
- [ ] Build validation script (fugashi tokenizer)
- [ ] Generate audio (Edge TTS)
- [ ] Build deck (genanki)
- [ ] Test in Anki: formatting, tags, deck structure
- [ ] Export minihongo.apkg

### Phase 3: Website
- [ ] Create HTML template (header, nav, footer, bilingual toggle, furigana toggle)
- [ ] Pick CSS (classless base)
- [ ] Write build.sh (pandoc)
- [ ] Build 6 lesson pages
- [ ] Build 4 reference pages (hiragana chart, katakana chart, vocabulary, grammar)
- [ ] Anki deck download page
- [ ] GitHub Pages + CNAME setup

### Phase 4: Polish
- [ ] Wire bilingual toggle (JS + localStorage)
- [ ] Wire furigana toggle (JS + localStorage)
- [ ] Mobile testing
- [ ] Link verification
