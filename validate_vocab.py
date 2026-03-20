#!/usr/bin/env python3
"""Validate that all minihongo content uses only base vocabulary words and readings.

Checks:
  1. Every kanji used must appear in the base vocabulary (words.csv)
  2. Every furigana reading must match a known reading from base vocabulary
  3. No bare kanji without furigana
  4. No banned words (non-base kana words that look valid but aren't)

Exceptions:
  - compounds.csv minihongo column (real Japanese compound readings)
  - Counter forms: 一つ(ひとつ), 二つ(ふたつ), 三つ(みっつ)
  - Conjugation-variant readings of base kanji
  - Category/UI metadata fields (name_minihongo, note_minihongo, etc.)
"""

import csv
import re
import sys
from collections import defaultdict
from pathlib import Path

DATA = Path('data')

# Banned words: kana-only words that are NOT in the 207 base vocabulary.
# These look like they could be valid minihongo but they aren't.
# Add words here to prevent them from creeping back into mh content.
BANNED_WORDS = [
    'つなぐ',
]

# Counter readings: native readings with つ counter
COUNTER_READINGS = {
    '一': 'ひと',
    '二': 'ふた',
    '三': 'みっ',
}

# Per-character readings from multi-char base words.
# Allows split usage: e.g. 太陽(たいよう) -> 太【たい】陽【よう】
COMPOUND_CHAR_READINGS = {
    '大人': {'大': 'おとな', '人': ''},      # irregular: reading is on 大
    '全部': {'全': 'ぜん', '部': 'ぶ'},
    '動物': {'動': 'どう', '物': 'ぶつ'},
    '名前': {'名': 'な', '前': 'まえ'},
    '太陽': {'太': 'たい', '陽': 'よう'},
    '子供': {'子': 'こ', '供': 'ども'},
    '必要': {'必': 'ひつ', '要': 'よう'},
    '本当': {'本': 'ほん', '当': 'とう'},
    '空気': {'空': 'くう', '気': 'き'},
    '言葉': {'言': 'こと', '葉': 'ば'},
    '黄色': {'黄': 'き', '色': 'いろ'},
}

# Also allow standalone readings for chars that appear in compounds
STANDALONE_CHAR_READINGS = {
    '気': {'き'},
}

# Alternate readings of base kanji from conjugation, rendaku, on'yomi compounds.
# These are all readings of kanji already in the 207 base words,
# just in different grammatical/compound contexts.
ALTERNATE_READINGS = {
    '来': {'き', 'こ'},          # 来る(く) -> 来た(き), 来ない(こ)
    '金': {'おかね'},            # お金(かね) with honorific
    '入': {'い'},                # 入る(はい) -> 入れる(い)
    '出': {'だ'},                # 出る(で) -> 出す(だ)
    '言': {'こと'},              # 言う(い) -> 言葉(こと)
    '開': {'ひら'},              # 開く(あ) -> 開く(ひら)
    '動': {'どう'},              # 動く(うご) -> 動物(どう)
    '物': {'ぶつ'},              # 物(もの) -> 動物(ぶつ)
    '空': {'くう'},              # 空(そら) -> 空気(くう)
    '足': {'た'},                # 足(あし) -> 足りる(た)
    '口': {'ぐち'},              # 口(くち) -> 入口(ぐち) rendaku
    '話': {'はなし', 'はな'},    # 話す(はな/はなし)
    '作': {'づく'},              # 作る(つく) -> 言葉作り(づく) rendaku
    '少': {'すく'},              # 少し(すこ) -> 少ない(すく)
    '後': {'うし'},              # 後(あと) -> 後ろ(うし)
    '方': {'ほう'},              # 方(かた) -> 方(ほう)
    '日': {'に'},                # 日(にち) -> 毎日(に)
    '明': {'あす'},              # 明るい(あか) -> 明日(あす)
    '何': {'なん'},              # 何(なに) -> 何だ(なん)
    '四': {'し', 'よ'},           # 四(よん) -> 四月(し), 四時(よ)
    '七': {'しち'},               # 七(なな) -> 七月(しち)
    '九': {'く'},                 # 九(きゅう) -> 九月(く), 九時(く)
    '百': {'びゃく', 'ぴゃく'},   # 百(ひゃく) -> 三百(びゃく), 六百(ぴゃく)
    '六': {'ろっ'},               # 六(ろく) -> 六百(ろっぴゃく)
    '八': {'はっ', 'やっ'},       # 八(はち) -> 八百(はっ), 八つ(やっ)
    '一': {'ひと'},               # 一(いち) -> 一人(ひとり), 一つ(ひとつ)
    '二': {'ふた'},               # 二(に) -> 二つ(ふたつ)
    '三': {'みっ'},               # 三(さん) -> 三つ(みっつ)
    '五': {'いつ'},               # 五(ご) -> 五つ(いつつ)
}


def load_csv(name):
    with open(DATA / f'{name}.csv', newline='', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def build_vocab():
    """Build kanji->readings map from ALL minihongo text in words.csv."""
    words = load_csv('words')
    vocab = defaultdict(set)
    char_readings = defaultdict(set)

    mh_cols = ['minihongo', 'definition_minihongo', 'example_minihongo']

    for w in words:
        for col in mh_cols:
            text = w.get(col, '')
            if not text:
                continue
            for m in re.finditer(
                r'([\u4e00-\u9fff\u3400-\u4dbf]+)【([^】]+)】', text
            ):
                kanji, reading = m.group(1), m.group(2)
                vocab[kanji].add(reading)
                if len(kanji) == 1:
                    char_readings[kanji].add(reading)
                else:
                    # Register individual chars from multi-char base words.
                    # For 2-char words, split the reading between chars.
                    # For others, just mark chars as known.
                    for ch in kanji:
                        char_readings.setdefault(ch, set())
                    if len(kanji) == 2:
                        # Try to split reading: common patterns for 2-char compounds
                        # Each reading is registered so split kanji usage is valid
                        # e.g. 太陽(たいよう) -> 太(たい) + 陽(よう)
                        # We can't auto-split reliably, so add to COMPOUND_CHAR_READINGS
                        pass

    # Add compound char readings
    for compound, chars in COMPOUND_CHAR_READINGS.items():
        for ch, reading in chars.items():
            if reading:
                char_readings[ch].add(reading)

    # Add standalone char readings
    for ch, readings in STANDALONE_CHAR_READINGS.items():
        char_readings.setdefault(ch, set()).update(readings)

    # Add alternate readings
    for kanji, readings in ALTERNATE_READINGS.items():
        char_readings[kanji].update(readings)
        vocab[kanji].update(readings)

    # Add counter readings
    for kanji, reading in COUNTER_READINGS.items():
        char_readings[kanji].add(reading)

    return vocab, char_readings


def is_counter_context(text, start):
    """Check if annotated kanji at position is followed by つ."""
    m = re.match(
        r'[\u4e00-\u9fff\u3400-\u4dbf]+【[^】]+】つ', text[start:]
    )
    return m is not None


def validate_text(text, vocab, char_readings, source):
    """Validate a single minihongo text field."""
    if not text:
        return []

    errors = []

    # Check for banned words
    for word in BANNED_WORDS:
        if word in text:
            errors.append({
                'source': source,
                'issue': f'banned word: {word}',
            })

    for m in re.finditer(
        r'([\u4e00-\u9fff\u3400-\u4dbf]+)【([^】]+)】', text
    ):
        kanji, reading = m.group(1), m.group(2)

        # Counter readings exception
        if kanji in COUNTER_READINGS and is_counter_context(text, m.start()):
            if reading == COUNTER_READINGS[kanji]:
                continue

        # Exact compound match (e.g. 言葉->ことば, 太陽->たいよう)
        if kanji in vocab and reading in vocab[kanji]:
            continue

        # Single char with known reading (base or alternate)
        if len(kanji) == 1 and kanji in char_readings:
            if reading in char_readings[kanji]:
                continue
            errors.append({
                'source': source,
                'issue': f'wrong reading: {kanji}【{reading}】(known: {"/".join(sorted(char_readings[kanji]))})',
            })
            continue

        # Multi-char: check if all individual chars are known base kanji
        if len(kanji) > 1:
            unknown_chars = [
                ch for ch in kanji
                if ch not in char_readings
                and not any(ch in vk for vk in vocab)
            ]
            if unknown_chars:
                errors.append({
                    'source': source,
                    'issue': f'unknown kanji: {"".join(unknown_chars)} in {kanji}【{reading}】',
                })
            # If all chars are known, the compound is valid (new combination)
            continue

        # Single unknown kanji
        errors.append({
            'source': source,
            'issue': f'unknown kanji: {kanji} in {kanji}【{reading}】',
        })

    # Check for bare kanji (missing furigana)
    stripped = re.sub(r'[\u4e00-\u9fff\u3400-\u4dbf]+【[^】]+】', '', text)
    bare = re.findall(r'[\u4e00-\u9fff\u3400-\u4dbf]+', stripped)
    for k in bare:
        if k == '々':
            continue
        errors.append({
            'source': source,
            'issue': f'bare kanji (no furigana): {k}',
        })

    return errors


# Content columns to validate (the actual lessons, stories, dialogs, etc.)
VALIDATE_CONTENT = {
    'words': ['minihongo', 'definition_minihongo', 'example_minihongo'],
    'expressions': ['minihongo'],
    'grammar': ['minihongo', 'explanation_minihongo'],
    'grammar_examples': ['minihongo'],
    'haiku': ['minihongo'],
    'dialogs': ['minihongo'],
    'dialog_groups': ['title_minihongo'],
    'stories': ['minihongo', 'title_minihongo'],
    # compounds: only definition_minihongo (minihongo col uses real Japanese)
    'compounds': ['definition_minihongo'],
}

# Metadata columns (categories, UI, pages) - validate separately, less strict
VALIDATE_META = {
    'categories': ['name_minihongo', 'note_minihongo'],
    'pages': ['name_minihongo'],
    'ui_strings': ['mh'],
    'dialogs': ['speaker_minihongo'],
}


def run_validation(label, file_columns, vocab, char_readings):
    """Run validation on a set of file:column pairs. Return error list."""
    errors = []
    for csv_name, columns in file_columns.items():
        rows = load_csv(csv_name)
        for row in rows:
            row_id = row.get('id', row.get('key', '?'))
            for col in columns:
                text = row.get(col, '')
                if not text:
                    continue
                source = f'{csv_name}:{row_id}:{col}'
                errors.extend(
                    validate_text(text, vocab, char_readings, source)
                )
    return errors


def main():
    vocab, char_readings = build_vocab()
    print(f'Base vocabulary: {len(vocab)} entries, {len(char_readings)} unique kanji')
    print()

    content_errors = run_validation('content', VALIDATE_CONTENT, vocab, char_readings)
    meta_errors = run_validation('metadata', VALIDATE_META, vocab, char_readings)

    if not content_errors and not meta_errors:
        print('All vocabulary valid - OK')
        return 0

    exit_code = 0

    if content_errors:
        print(f'{len(content_errors)} content issues (FAIL):\n')
        for e in content_errors:
            print(f'  {e["source"]}')
            print(f'    {e["issue"]}')
            print()
        exit_code = 1

    if meta_errors:
        print(f'{len(meta_errors)} metadata issues (WARN):\n')
        for e in meta_errors:
            print(f'  {e["source"]}')
            print(f'    {e["issue"]}')
            print()

    return exit_code


if __name__ == '__main__':
    sys.exit(main())
