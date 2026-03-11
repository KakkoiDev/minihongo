#!/usr/bin/env python3
"""Generate Anki decks (.apkg) for Minihongo in three languages.

Output:
  minihongo-en.apkg  - English translations
  minihongo-ja.apkg  - Japanese translations
  minihongo-mh.apkg  - Minihongo definitions

Deck hierarchy (same for each language):
  Minihongo (EN/JA/MH)
  ├── 01 Vocabulary
  │   ├── 01 Pronouns & People
  │   └── ...
  └── 02 Grammar
      ├── 01 Sentence Structure
      └── ...

Card types:
  Vocabulary - double card (recognition + recall), audio on all Japanese
  Grammar    - example sentence with audio -> explanation

Requires: pip install genanki
"""

import csv
import random
import re
import sys
from pathlib import Path

import genanki

# ── Config ──────────────────────────────────────────────────────────

DATA = Path('data')
AUDIO = Path('audio')

# Language config: translation column mappings
LANGS = {
    'en': {
        'deck_name': 'Minihongo (EN)',
        'output': 'minihongo-en.apkg',
        'word_translation': 'english',
        'example_translation': 'example_english',
        'grammar_name': 'english',
        'grammar_explanation': 'explanation_english',
        'grammar_example_translation': 'english',
        'category_name': 'name_english',
        # Model IDs must differ per language so Anki treats them as separate models
        'vocab_model_id': 2007392101,
        'grammar_model_id': 2007392102,
    },
    'ja': {
        'deck_name': 'Minihongo (JA)',
        'output': 'minihongo-ja.apkg',
        'word_translation': 'japanese',
        'example_translation': 'example_japanese',
        'grammar_name': 'japanese',
        'grammar_explanation': 'explanation_japanese',
        'grammar_example_translation': 'japanese',
        'category_name': 'name_japanese',
        'vocab_model_id': 2007392111,
        'grammar_model_id': 2007392112,
    },
    'mh': {
        'deck_name': 'Minihongo (MH)',
        'output': 'minihongo-mh.apkg',
        'word_translation': 'definition_minihongo',
        'example_translation': 'example_minihongo',
        'grammar_name': 'minihongo',
        'grammar_explanation': 'explanation_minihongo',
        'grammar_example_translation': 'minihongo',
        'category_name': 'name_minihongo',
        'vocab_model_id': 2007392121,
        'grammar_model_id': 2007392122,
    },
}

# ── Furigana helpers ────────────────────────────────────────────────


def to_ruby_html(text):
    """Convert 漢字【かんじ】 to <ruby>漢字<rt>かんじ</rt></ruby>."""
    return re.sub(
        r'([\u4e00-\u9fff\u3400-\u4dbf]+)【([^】]+)】',
        r'<ruby>\1<rt>\2</rt></ruby>',
        text,
    )


def strip_furigana(text):
    """Remove furigana brackets: 漢字【かんじ】 -> 漢字."""
    return re.sub(r'【[^】]+】', '', text)


# ── Card models ─────────────────────────────────────────────────────

SHARED_CSS = """
.card {
    font-family: "Noto Sans JP", "Hiragino Sans", "Yu Gothic", system-ui, sans-serif;
    font-size: 20px;
    text-align: center;
    color: #2B2B2B;
    background: #FFFFFF;
    padding: 24px;
    line-height: 1.7;
}
.card-type {
    font-size: 12px;
    color: #666666;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 15px;
}
.word {
    font-size: 32px;
    font-weight: bold;
    margin: 20px 0;
    line-height: 2;
}
.sentence {
    font-size: 22px;
    margin: 15px 0;
    line-height: 1.8;
}
.translation {
    font-size: 22px;
    margin: 15px 0;
    line-height: 1.6;
}
.explanation {
    font-size: 18px;
    margin: 15px 0;
    text-align: left;
    line-height: 1.6;
}
.grammar-name {
    font-size: 14px;
    color: #666666;
    margin-top: 10px;
}
.audio { margin: 10px 0; text-align: center; }
.tags {
    display: inline-block;
    background: #F7F7F7;
    padding: 4px 12px;
    border-radius: 0.75rem;
    font-size: 12px;
    color: #666666;
    border: 1px solid #E5E5E5;
    margin-top: 10px;
}
.hint {
    font-size: 18px;
    font-style: italic;
    margin: 10px 0;
    color: #666666;
}
ruby { ruby-align: center; }
ruby rt { font-size: 12px; font-weight: normal; color: #666666; }
hr#answer { border: none; border-top: 3px solid #BC002D; margin: 20px 0; }

.night_mode .card {
    color: #E8E8E8;
    background: #1A1A1A;
}
.night_mode .card-type,
.night_mode .grammar-name,
.night_mode .hint { color: #999999; }
.night_mode .tags {
    background: #252525;
    border-color: #333333;
    color: #999999;
}
.night_mode ruby rt { color: #999999; }
.night_mode hr#answer { border-top-color: #BC002D; }

/* Audio replay button - match website play-btn style */
.replay-button, .replaybutton {
    display: flex !important;
    align-items: center;
    justify-content: center;
    width: 2.5rem;
    height: 2.5rem;
    margin: 0 auto;
    border: 2px solid #E5E5E5;
    border-radius: 0.75rem;
    background: #FFFFFF;
    cursor: pointer;
    text-decoration: none;
}
.replay-button *, .replaybutton * { display: none !important; }
.replay-button::before, .replaybutton::before {
    content: "";
    flex-shrink: 0;
    width: 1.2rem;
    height: 1.2rem;
    background: #2B70C9;
    -webkit-mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath d='M3 9v6h4l5 5V4L7 9H3zm13.5 3A4.5 4.5 0 0014 8.5v7a4.47 4.47 0 002.5-3.5zM14 3.23v2.06a6.51 6.51 0 010 13.42v2.06A8.51 8.51 0 0014 3.23z'/%3E%3C/svg%3E") center / contain no-repeat;
    mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath d='M3 9v6h4l5 5V4L7 9H3zm13.5 3A4.5 4.5 0 0014 8.5v7a4.47 4.47 0 002.5-3.5zM14 3.23v2.06a6.51 6.51 0 010 13.42v2.06A8.51 8.51 0 0014 3.23z'/%3E%3C/svg%3E") center / contain no-repeat;
}
.night_mode .replay-button, .night_mode .replaybutton {
    border-color: #333333;
    background: #1A1A1A;
}
"""


def create_vocab_model(lang_cfg):
    """Vocab double-card: recognition + recall."""
    return genanki.Model(
        lang_cfg['vocab_model_id'],
        f'Minihongo Vocab ({lang_cfg["deck_name"]})',
        fields=[
            {'name': 'Word'},
            {'name': 'Translation'},
            {'name': 'Example'},
            {'name': 'ExampleTranslation'},
            {'name': 'AudioWord'},
            {'name': 'AudioExample'},
            {'name': 'Category'},
        ],
        templates=[
            {
                'name': 'Recognition',
                'qfmt': '''
<div class="card-type">Recognition</div>
<div class="word">{{Word}}</div>
<div class="audio">{{AudioWord}}</div>
''',
                'afmt': '''
<div class="card-type">Recognition</div>
<div class="word">{{Word}}</div>
<div class="audio">{{AudioWord}}</div>
<hr id="answer">
<div class="translation">{{Translation}}</div>
{{#Example}}
<div class="sentence">{{Example}}</div>
<div class="audio">{{AudioExample}}</div>
{{#ExampleTranslation}}<div class="translation">{{ExampleTranslation}}</div>{{/ExampleTranslation}}
{{/Example}}
''',
            },
            {
                'name': 'Recall',
                'qfmt': '''
<div class="card-type">Recall</div>
<div class="translation">{{Translation}}</div>
<div class="tags">{{Category}}</div>
''',
                'afmt': '''
<div class="card-type">Recall</div>
<div class="translation">{{Translation}}</div>
<hr id="answer">
<div class="word">{{Word}}</div>
<div class="audio">{{AudioWord}}</div>
{{#Example}}
<div class="sentence">{{Example}}</div>
<div class="audio">{{AudioExample}}</div>
{{/Example}}
''',
            },
        ],
        css=SHARED_CSS,
    )


def create_grammar_model(lang_cfg):
    """Grammar card: example sentence + audio -> explanation."""
    return genanki.Model(
        lang_cfg['grammar_model_id'],
        f'Minihongo Grammar ({lang_cfg["deck_name"]})',
        fields=[
            {'name': 'GrammarName'},
            {'name': 'Example'},
            {'name': 'ExampleTranslation'},
            {'name': 'Explanation'},
            {'name': 'AudioExample'},
            {'name': 'Category'},
        ],
        templates=[
            {
                'name': 'Grammar',
                'qfmt': '''
<div class="card-type">Grammar</div>
<div class="sentence">{{Example}}</div>
<div class="audio">{{AudioExample}}</div>
<div class="grammar-name">{{GrammarName}}</div>
''',
                'afmt': '''
<div class="card-type">Grammar</div>
<div class="sentence">{{Example}}</div>
<div class="audio">{{AudioExample}}</div>
<div class="grammar-name">{{GrammarName}}</div>
<hr id="answer">
<div class="translation">{{ExampleTranslation}}</div>
<div class="explanation">{{Explanation}}</div>
''',
            },
        ],
        css=SHARED_CSS,
    )


# ── Data loading ────────────────────────────────────────────────────

def load_csv(name):
    with open(DATA / f'{name}.csv', newline='', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def load_categories():
    """Load categories as {id: row}."""
    return {r['id']: r for r in load_csv('categories')}


# ── Deck building ───────────────────────────────────────────────────

def audio_ref(subdir, filename):
    """Return [sound:file] ref and absolute path, or empty if missing."""
    if not filename:
        return '', None
    path = AUDIO / subdir / filename
    if not path.exists():
        return '', None
    return f'[sound:{filename}]', str(path)


def get_field(row, col, ruby=False):
    """Get a field value, optionally converting furigana to ruby HTML."""
    val = row.get(col, '') or ''
    return to_ruby_html(val) if ruby and val else val


def build_vocab_decks(categories, lang_cfg):
    """Build vocabulary subdecks grouped by category."""
    words = load_csv('words')
    model = create_vocab_model(lang_cfg)
    decks = []
    media = []
    cat_name_col = lang_cfg['category_name']
    is_jp = lang_cfg['word_translation'] in ('japanese', 'definition_minihongo')

    by_cat = {}
    for w in words:
        by_cat.setdefault(w['category_id'], []).append(w)

    vocab_cats = sorted(
        [c for c in categories.values() if c['page_id'] == 'vocabulary'],
        key=lambda c: int(c['sort_order']),
    )

    for cat in vocab_cats:
        cat_words = by_cat.get(cat['id'], [])
        if not cat_words:
            continue

        sort = int(cat['sort_order'])
        cat_label = strip_furigana(cat[cat_name_col]) if is_jp else cat[cat_name_col]
        name = f"{lang_cfg['deck_name']}::01 Vocabulary::{sort:02d} {cat_label}"
        deck = genanki.Deck(random.randint(10**9, 10**10 - 1), name)

        for w in sorted(cat_words, key=lambda r: int(r['sort_order'])):
            word_ref, word_path = audio_ref('w', w.get('audio_word', ''))
            ex_ref, ex_path = audio_ref('w', w.get('audio_example', ''))
            if word_path:
                media.append(word_path)
            if ex_path:
                media.append(ex_path)

            translation = get_field(w, lang_cfg['word_translation'], ruby=is_jp)
            example_html = to_ruby_html(w['example_minihongo']) if w.get('example_minihongo') else ''
            example_trans = get_field(w, lang_cfg['example_translation'], ruby=is_jp)

            note = genanki.Note(
                model=model,
                fields=[
                    to_ruby_html(w['minihongo']),
                    translation,
                    example_html,
                    example_trans,
                    word_ref,
                    ex_ref,
                    cat_label,
                ],
                tags=[cat_label.replace(' ', '_')],
            )
            deck.add_note(note)

        decks.append(deck)

    return decks, media


def build_grammar_decks(categories, lang_cfg):
    """Build grammar subdecks grouped by category."""
    grammar = {g['id']: g for g in load_csv('grammar')}
    examples = load_csv('grammar_examples')
    model = create_grammar_model(lang_cfg)
    decks = []
    media = []
    cat_name_col = lang_cfg['category_name']
    is_jp = lang_cfg['grammar_explanation'] in ('explanation_japanese', 'explanation_minihongo')

    by_cat = {}
    for ex in examples:
        g = grammar.get(ex['grammar_id'])
        if not g:
            continue
        by_cat.setdefault(g['category_id'], []).append((g, ex))

    grammar_cats = sorted(
        [c for c in categories.values() if c['page_id'] == 'grammar'],
        key=lambda c: int(c['sort_order']),
    )

    for idx, cat in enumerate(grammar_cats, 1):
        items = by_cat.get(cat['id'], [])
        if not items:
            continue

        cat_label = strip_furigana(cat[cat_name_col]) if is_jp else cat[cat_name_col]
        name = f"{lang_cfg['deck_name']}::02 Grammar::{idx:02d} {cat_label}"
        deck = genanki.Deck(random.randint(10**9, 10**10 - 1), name)

        for g, ex in sorted(items, key=lambda x: int(x[1]['sort_order'])):
            ex_ref, ex_path = audio_ref('ge', ex.get('audio_file', ''))
            if ex_path:
                media.append(ex_path)

            grammar_name = get_field(g, lang_cfg['grammar_name'], ruby=is_jp)
            ex_trans = get_field(ex, lang_cfg['grammar_example_translation'], ruby=is_jp)
            explanation = get_field(g, lang_cfg['grammar_explanation'], ruby=is_jp)

            note = genanki.Note(
                model=model,
                fields=[
                    grammar_name,
                    to_ruby_html(ex['minihongo']),
                    ex_trans,
                    explanation,
                    ex_ref,
                    cat_label,
                ],
                tags=[cat_label.replace(' ', '_')],
            )
            deck.add_note(note)

        decks.append(deck)

    return decks, media


def build_deck(lang, categories):
    """Build a complete deck for one language."""
    lang_cfg = LANGS[lang]

    vocab_decks, vocab_media = build_vocab_decks(categories, lang_cfg)
    vocab_cards = sum(len(d.notes) * 2 for d in vocab_decks)

    grammar_decks, grammar_media = build_grammar_decks(categories, lang_cfg)
    grammar_cards = sum(len(d.notes) for d in grammar_decks)

    all_decks = vocab_decks + grammar_decks
    all_media = vocab_media + grammar_media

    output = Path(lang_cfg['output'])
    package = genanki.Package(all_decks)
    package.media_files = all_media
    package.write_to_file(str(output))

    print(f'  Vocab:   {len(vocab_decks)} subdecks, {vocab_cards} cards')
    print(f'  Grammar: {len(grammar_decks)} subdecks, {grammar_cards} cards')
    print(f'  Audio:   {len(all_media)} files -> {output}')

    return output


# ── Main ────────────────────────────────────────────────────────────

def main():
    langs = sys.argv[1:] if len(sys.argv) > 1 else list(LANGS.keys())
    for lang in langs:
        if lang not in LANGS:
            print(f'Unknown language: {lang}. Choose from: {", ".join(LANGS)}')
            sys.exit(1)

    categories = load_categories()

    for lang in langs:
        print(f'\n[{lang}] {LANGS[lang]["deck_name"]}')
        build_deck(lang, categories)

    print('\nDone.')


if __name__ == '__main__':
    main()
