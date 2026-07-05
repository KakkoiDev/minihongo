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
  ├── 02 Grammar
  │   ├── 01 Sentence Structure
  │   └── ...
  └── 03 Listening
      ├── 01 Dialogs
      └── 02 Stories

Anki ships only this core course. An expressions deck existed once and was
frozen, then removed (2026-07): an over-eager grab-bag with no single job.
Last-released expressions .apkg assets stay on GitHub as-is; the build code
lives in git history if it is ever wanted back.

Card types:
  Vocabulary - double card (recognition + recall), audio on all Japanese
  Grammar    - example sentence with audio -> explanation
  Listening  - audio only -> title, transcript, translation

Requires: pip install genanki
"""

import hashlib
import random
import re
import sys
from pathlib import Path

import genanki

from mh_common import DATA, load_csv, strip_furigana

# ── Config ──────────────────────────────────────────────────────────

AUDIO = Path('audio')

# Language config: translation column mappings
DECKS = {
    'en': {
        'deck_name': 'Minihongo (EN)',
        'output': 'minihongo-en.apkg',
        'word_translation': 'english',
        'example_translation': 'example_english',
        'grammar_name': 'english',
        'grammar_explanation': 'explanation_english',
        'grammar_example_translation': 'english',
        'category_name': 'name_english',
        'reading_translation': 'english',
        'vocab_model_id': 2007390001,
        'grammar_model_id': 2007390002,
        'listening_model_id': 2007390003,
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
        'reading_translation': 'japanese',
        'vocab_model_id': 2007390011,
        'grammar_model_id': 2007390012,
        'listening_model_id': 2007390013,
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
        # MH deck: no separate reading translation - it would repeat the transcript
        'reading_translation': '',
        'vocab_model_id': 2007390021,
        'grammar_model_id': 2007390022,
        'listening_model_id': 2007390023,
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
    margin: 20px 0 15px;
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


def create_listening_model(lang_cfg):
    """Listening card: audio only -> title, transcript, translation."""
    return genanki.Model(
        lang_cfg['listening_model_id'],
        f'Minihongo Listening ({lang_cfg["deck_name"]})',
        fields=[
            {'name': 'Title'},
            {'name': 'TitleTranslation'},
            {'name': 'Transcript'},
            {'name': 'Translation'},
            {'name': 'Audio'},
            {'name': 'Category'},
        ],
        templates=[
            {
                'name': 'Listening',
                'qfmt': '''
<div class="card-type">Listening</div>
<div class="audio">{{Audio}}</div>
''',
                'afmt': '''
<div class="card-type">Listening</div>
<div class="audio">{{Audio}}</div>
<hr id="answer">
<div class="word">{{Title}}</div>
{{#TitleTranslation}}<div class="grammar-name">{{TitleTranslation}}</div>{{/TitleTranslation}}
<div class="explanation">{{Transcript}}</div>
{{#Translation}}<div class="explanation">{{Translation}}</div>{{/Translation}}
''',
            },
        ],
        css=SHARED_CSS,
    )


# ── Data loading ────────────────────────────────────────────────────


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
            # JA/MH render the example "translation" as the same Japanese sentence; blank it
            # when identical to the example (modulo furigana), keeping only genuine
            # differences (e.g. natural phrasing vs a minihongo circumlocution). EN untouched.
            if is_jp and strip_furigana(w.get(lang_cfg['example_translation'], '')) == strip_furigana(w.get('example_minihongo', '')):
                example_trans = ''

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
            # Same dedup as vocab: blank the example translation when it is just the
            # example sentence again (JA/MH), keeping only genuine differences.
            if is_jp and strip_furigana(ex.get(lang_cfg['grammar_example_translation'], '')) == strip_furigana(ex.get('minihongo', '')):
                ex_trans = ''
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


def build_listening_decks(lang_cfg):
    """Build listening subdecks: whole dialogs and stories, audio-first."""
    dialog_groups = load_csv('dialog_groups')
    dialogs = load_csv('dialogs')
    stories = load_csv('stories')
    model = create_listening_model(lang_cfg)
    media = []
    missing = []
    trans_col = lang_cfg['reading_translation']

    lines_by_grp = {}
    for d in dialogs:
        lines_by_grp.setdefault(d['dialog_group_id'], []).append(d)

    def make_deck(label, idx):
        name = f"{lang_cfg['deck_name']}::03 Listening::{idx:02d} {label}"
        return genanki.Deck(random.randint(10**9, 10**10 - 1), name)

    dialog_deck = make_deck('Dialogs', 1)
    for dg in sorted(dialog_groups, key=lambda r: int(r['sort_order'])):
        ref, path = audio_ref('d', dg.get('audio_file', ''))
        if not path:
            missing.append(f"dialogs/{dg['id']}: audio/d/{dg.get('audio_file', '?')}")
            continue
        media.append(path)
        lines = sorted(lines_by_grp.get(dg['id'], []),
                       key=lambda d: int(d['line_number']))
        transcript = ''.join(
            f'<p><strong>{to_ruby_html(ln["speaker_minihongo"])}:</strong> '
            f'{to_ruby_html(ln["minihongo"])}</p>'
            for ln in lines
        )
        translation = ''
        if trans_col:
            translation = ''.join(
                f'<p><strong>{ln.get("speaker_" + trans_col, "")}:</strong> '
                f'{ln.get(trans_col, "")}</p>'
                for ln in lines
            )
        dialog_deck.add_note(genanki.Note(
            model=model,
            fields=[
                to_ruby_html(dg['title_minihongo']),
                dg.get(f'title_{trans_col}', '') if trans_col else '',
                transcript,
                translation,
                ref,
                'Dialogs',
            ],
            tags=['Listening', 'Dialogs'],
        ))

    story_deck = make_deck('Stories', 2)
    for st in sorted(stories, key=lambda r: int(r['sort_order'])):
        ref, path = audio_ref('s', st.get('audio_file', ''))
        if not path:
            missing.append(f"stories/{st['id']}: audio/s/{st.get('audio_file', '?')}")
            continue
        media.append(path)
        paras = [p for p in re.split(r'(?<=[。」]) ', st['minihongo']) if p.strip()]
        transcript = ''.join(f'<p>{to_ruby_html(p)}</p>' for p in paras)
        translation = st.get(trans_col, '') if trans_col else ''
        story_deck.add_note(genanki.Note(
            model=model,
            fields=[
                to_ruby_html(st['title_minihongo']),
                st.get(f'title_{trans_col}', '') if trans_col else '',
                transcript,
                translation,
                ref,
                'Stories',
            ],
            tags=['Listening', 'Stories'],
        ))

    # A listening card without audio is an empty front - refuse to ship it.
    if missing:
        print('Listening deck: missing audio files (run `make audio-download`):',
              file=sys.stderr)
        for m in missing:
            print(f'  {m}', file=sys.stderr)
        sys.exit(1)

    return [dialog_deck, story_deck], media


def build_deck(lang, categories):
    """Build a complete deck for one language."""
    lang_cfg = DECKS[lang]

    vocab_decks, vocab_media = build_vocab_decks(categories, lang_cfg)
    vocab_cards = sum(len(d.notes) * 2 for d in vocab_decks)

    grammar_decks, grammar_media = build_grammar_decks(categories, lang_cfg)
    grammar_cards = sum(len(d.notes) for d in grammar_decks)

    listening_decks, listening_media = build_listening_decks(lang_cfg)
    listening_cards = sum(len(d.notes) for d in listening_decks)

    all_decks = vocab_decks + grammar_decks + listening_decks
    all_media = vocab_media + grammar_media + listening_media

    output = Path(lang_cfg['output'])
    package = genanki.Package(all_decks)
    package.media_files = all_media
    package.write_to_file(str(output))

    print(f'  Vocab:      {len(vocab_decks)} subdecks, {vocab_cards} cards')
    print(f'  Grammar:    {len(grammar_decks)} subdecks, {grammar_cards} cards')
    print(f'  Listening:  {len(listening_decks)} subdecks, {listening_cards} cards')
    print(f'  Audio:      {len(all_media)} files -> {output}')

    return output


# ── Main ────────────────────────────────────────────────────────────

def main():
    args = sys.argv[1:]
    force_style = '--force-style' in args
    langs = [a for a in args if not a.startswith('--')] or list(DECKS.keys())

    for lang in langs:
        if lang not in DECKS:
            print(f'Unknown language: {lang}. Choose from: {", ".join(DECKS)}')
            sys.exit(1)

    if force_style:
        # Offset model IDs by CSS hash so Anki creates new models with updated styles
        css_hash = int(hashlib.sha256(SHARED_CSS.encode()).hexdigest()[:6], 16)
        for cfg in DECKS.values():
            cfg['vocab_model_id'] += css_hash
            cfg['grammar_model_id'] += css_hash
            cfg['listening_model_id'] += css_hash
        print(f'--force-style: model IDs offset by {css_hash} (CSS hash)')

    categories = load_categories()

    for lang in langs:
        print(f'\n[{lang}] {DECKS[lang]["deck_name"]}')
        build_deck(lang, categories)

    print('\nDone.')


if __name__ == '__main__':
    main()
