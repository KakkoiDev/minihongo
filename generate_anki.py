#!/usr/bin/env python3
"""Generate Anki deck (.apkg) for Minihongo vocabulary and grammar.

Deck hierarchy:
  Minihongo
  ├── 01 Vocabulary
  │   ├── 01 Pronouns & People
  │   ├── 02 Objects & Materials
  │   └── ...
  └── 02 Grammar
      ├── 01 Sentence Structure
      ├── 02 Particles
      └── ...

Card types:
  Vocabulary - double card (recognition + recall), audio on all Japanese
  Grammar    - grammar point + example with audio -> English explanation

Requires: pip install genanki
"""

import csv
import random
import re
from pathlib import Path

import genanki

# ── Config ──────────────────────────────────────────────────────────

DATA = Path('data')
AUDIO = Path('audio')
OUTPUT = Path('minihongo.apkg')

MASTER_DECK = 'Minihongo'

# Stable model IDs (random but fixed for consistent imports)
VOCAB_MODEL_ID = 2007392001
GRAMMAR_MODEL_ID = 2007392002

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
    font-family: "Hiragino Kaku Gothic Pro", "Noto Sans JP", "Noto Sans", sans-serif;
    font-size: 20px;
    text-align: center;
    color: #333;
    background-color: #fafafa;
    padding: 20px;
}
.card-type {
    font-size: 12px;
    color: #888;
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
.english {
    font-size: 22px;
    color: #444;
    margin: 15px 0;
}
.explanation {
    font-size: 18px;
    color: #555;
    margin: 15px 0;
    text-align: left;
    line-height: 1.6;
}
.grammar-name {
    font-size: 14px;
    color: #888;
    margin-top: 10px;
}
.audio { margin: 10px 0; }
.tags {
    display: inline-block;
    background: #e0e0e0;
    padding: 4px 12px;
    border-radius: 12px;
    font-size: 12px;
    color: #555;
    margin-top: 10px;
}
.hint {
    font-size: 18px;
    color: #666;
    font-style: italic;
    margin: 10px 0;
}
ruby { ruby-align: center; }
ruby rt { font-size: 12px; font-weight: normal; color: #666; }
hr#answer { border: none; border-top: 1px solid #ddd; margin: 20px 0; }
"""


def create_vocab_model():
    """Vocab double-card: recognition + recall."""
    return genanki.Model(
        VOCAB_MODEL_ID,
        'Minihongo Vocab',
        fields=[
            {'name': 'Word'},
            {'name': 'English'},
            {'name': 'Example'},
            {'name': 'ExampleEnglish'},
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
<div class="english">{{English}}</div>
{{#Example}}
<div class="sentence">{{Example}}</div>
<div class="audio">{{AudioExample}}</div>
{{/Example}}
''',
            },
            {
                'name': 'Recall',
                'qfmt': '''
<div class="card-type">Recall</div>
<div class="english">{{English}}</div>
<div class="tags">{{Category}}</div>
''',
                'afmt': '''
<div class="card-type">Recall</div>
<div class="english">{{English}}</div>
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


def create_grammar_model():
    """Grammar card: example sentence + audio -> English explanation."""
    return genanki.Model(
        GRAMMAR_MODEL_ID,
        'Minihongo Grammar',
        fields=[
            {'name': 'GrammarName'},
            {'name': 'GrammarNameEN'},
            {'name': 'Example'},
            {'name': 'ExampleEnglish'},
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
<div class="english">{{ExampleEnglish}}</div>
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


def build_vocab_decks(categories):
    """Build vocabulary subdecks grouped by category."""
    words = load_csv('words')
    model = create_vocab_model()
    decks = []
    media = []

    # Group by category
    by_cat = {}
    for w in words:
        cid = w['category_id']
        by_cat.setdefault(cid, []).append(w)

    # Get vocab categories (cat-1 through cat-15)
    vocab_cats = sorted(
        [c for c in categories.values() if c['page_id'] == 'vocabulary'],
        key=lambda c: int(c['sort_order']),
    )

    for cat in vocab_cats:
        cat_words = by_cat.get(cat['id'], [])
        if not cat_words:
            continue

        sort = int(cat['sort_order'])
        name = f"{MASTER_DECK}::01 Vocabulary::{sort:02d} {cat['name_english']}"
        deck = genanki.Deck(random.randint(10**9, 10**10 - 1), name)

        for w in sorted(cat_words, key=lambda r: int(r['sort_order'])):
            word_ref, word_path = audio_ref('w', w.get('audio_word', ''))
            ex_ref, ex_path = audio_ref('w', w.get('audio_example', ''))
            if word_path:
                media.append(word_path)
            if ex_path:
                media.append(ex_path)

            example_html = to_ruby_html(w['example_minihongo']) if w.get('example_minihongo') else ''
            example_en = w.get('example_english', '')

            note = genanki.Note(
                model=model,
                fields=[
                    to_ruby_html(w['minihongo']),
                    w['english'],
                    example_html,
                    example_en,
                    word_ref,
                    ex_ref,
                    cat['name_english'],
                ],
                tags=[cat['name_english'].replace(' ', '_')],
            )
            deck.add_note(note)

        decks.append(deck)

    return decks, media


def build_grammar_decks(categories):
    """Build grammar subdecks grouped by category."""
    grammar = {g['id']: g for g in load_csv('grammar')}
    examples = load_csv('grammar_examples')
    model = create_grammar_model()
    decks = []
    media = []

    # Group examples by grammar_id -> category
    by_cat = {}
    for ex in examples:
        gid = ex['grammar_id']
        g = grammar.get(gid)
        if not g:
            continue
        cid = g['category_id']
        by_cat.setdefault(cid, []).append((g, ex))

    # Get grammar categories
    grammar_cats = sorted(
        [c for c in categories.values() if c['page_id'] == 'grammar'],
        key=lambda c: int(c['sort_order']),
    )

    for cat in grammar_cats:
        items = by_cat.get(cat['id'], [])
        if not items:
            continue

        # Grammar categories start after vocab, number them 01+
        cat_idx = grammar_cats.index(cat) + 1
        name = f"{MASTER_DECK}::02 Grammar::{cat_idx:02d} {cat['name_english']}"
        deck = genanki.Deck(random.randint(10**9, 10**10 - 1), name)

        for g, ex in sorted(items, key=lambda x: int(x[1]['sort_order'])):
            ex_ref, ex_path = audio_ref('ge', ex.get('audio_file', ''))
            if ex_path:
                media.append(ex_path)

            note = genanki.Note(
                model=model,
                fields=[
                    to_ruby_html(g['minihongo']),
                    g['english'],
                    to_ruby_html(ex['minihongo']),
                    ex['english'],
                    g['explanation_english'],
                    ex_ref,
                    cat['name_english'],
                ],
                tags=[cat['name_english'].replace(' ', '_')],
            )
            deck.add_note(note)

        decks.append(deck)

    return decks, media


# ── Main ────────────────────────────────────────────────────────────

def main():
    categories = load_categories()

    print('Building vocabulary decks...')
    vocab_decks, vocab_media = build_vocab_decks(categories)
    vocab_cards = sum(len(d.notes) * 2 for d in vocab_decks)

    print('Building grammar decks...')
    grammar_decks, grammar_media = build_grammar_decks(categories)
    grammar_cards = sum(len(d.notes) for d in grammar_decks)

    all_decks = vocab_decks + grammar_decks
    all_media = vocab_media + grammar_media

    package = genanki.Package(all_decks)
    package.media_files = all_media
    package.write_to_file(str(OUTPUT))

    print(f'\nVocab:   {len(vocab_decks)} subdecks, {vocab_cards} cards (recognition + recall)')
    print(f'Grammar: {len(grammar_decks)} subdecks, {grammar_cards} cards')
    print(f'Audio:   {len(all_media)} files')
    print(f'Output:  {OUTPUT}')


if __name__ == '__main__':
    main()
