#!/usr/bin/env python3
"""Generate TTS audio for all minihongo content using Microsoft Edge TTS.

Voices:
  - ja-JP-KeitaNeural (male) - words, grammar, compounds, expressions, stories, haiku
  - ja-JP-NanamiNeural (female) - dialog speaker B lines

Output:
  audio/
    w/       words (w_{romaji}.mp3) + examples (w_{romaji}_ex.mp3)
    ge/      grammar examples (ge_{id_num}.mp3)
    c/       compounds (c_{romaji}.mp3)
    e/       expressions (e_{id_num}.mp3)
    h/       haiku (h_{id_num}.mp3) - one per haiku
    d/       dialogs (d_{group_id}.mp3) - merged per group
    s/       stories (s_{id_num}.mp3) - merged per story

Requires: pip install edge-tts
Requires: ffmpeg (for merging dialog/story audio)
"""

import asyncio
import csv
import hashlib
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

# ── Config ──────────────────────────────────────────────────────────

VOICE_MALE = 'ja-JP-KeitaNeural'
VOICE_FEMALE = 'ja-JP-NanamiNeural'
DATA = Path('data')
AUDIO_OUT = Path('audio')
SILENCE_MS = 600  # silence between merged segments

# ── Kana to romaji ──────────────────────────────────────────────────

_COMBO = {
    'きゃ': 'kya', 'きゅ': 'kyu', 'きょ': 'kyo',
    'しゃ': 'sha', 'しゅ': 'shu', 'しょ': 'sho',
    'ちゃ': 'cha', 'ちゅ': 'chu', 'ちょ': 'cho',
    'にゃ': 'nya', 'にゅ': 'nyu', 'にょ': 'nyo',
    'ひゃ': 'hya', 'ひゅ': 'hyu', 'ひょ': 'hyo',
    'みゃ': 'mya', 'みゅ': 'myu', 'みょ': 'myo',
    'りゃ': 'rya', 'りゅ': 'ryu', 'りょ': 'ryo',
    'ぎゃ': 'gya', 'ぎゅ': 'gyu', 'ぎょ': 'gyo',
    'じゃ': 'ja', 'じゅ': 'ju', 'じょ': 'jo',
    'びゃ': 'bya', 'びゅ': 'byu', 'びょ': 'byo',
    'ぴゃ': 'pya', 'ぴゅ': 'pyu', 'ぴょ': 'pyo',
}

_SINGLE = {
    'あ': 'a', 'い': 'i', 'う': 'u', 'え': 'e', 'お': 'o',
    'か': 'ka', 'き': 'ki', 'く': 'ku', 'け': 'ke', 'こ': 'ko',
    'さ': 'sa', 'し': 'shi', 'す': 'su', 'せ': 'se', 'そ': 'so',
    'た': 'ta', 'ち': 'chi', 'つ': 'tsu', 'て': 'te', 'と': 'to',
    'な': 'na', 'に': 'ni', 'ぬ': 'nu', 'ね': 'ne', 'の': 'no',
    'は': 'ha', 'ひ': 'hi', 'ふ': 'fu', 'へ': 'he', 'ほ': 'ho',
    'ま': 'ma', 'み': 'mi', 'む': 'mu', 'め': 'me', 'も': 'mo',
    'や': 'ya', 'ゆ': 'yu', 'よ': 'yo',
    'ら': 'ra', 'り': 'ri', 'る': 'ru', 'れ': 're', 'ろ': 'ro',
    'わ': 'wa', 'を': 'wo', 'ん': 'n',
    'が': 'ga', 'ぎ': 'gi', 'ぐ': 'gu', 'げ': 'ge', 'ご': 'go',
    'ざ': 'za', 'じ': 'ji', 'ず': 'zu', 'ぜ': 'ze', 'ぞ': 'zo',
    'だ': 'da', 'ぢ': 'ji', 'づ': 'zu', 'で': 'de', 'ど': 'do',
    'ば': 'ba', 'び': 'bi', 'ぶ': 'bu', 'べ': 'be', 'ぼ': 'bo',
    'ぱ': 'pa', 'ぴ': 'pi', 'ぷ': 'pu', 'ぺ': 'pe', 'ぽ': 'po',
}

# Katakana equivalents
_KATA_OFFSET = ord('ア') - ord('あ')
for _hira, _rom in list(_SINGLE.items()):
    _SINGLE[chr(ord(_hira) + _KATA_OFFSET)] = _rom
for _hira, _rom in list(_COMBO.items()):
    _kata = ''.join(chr(ord(c) + _KATA_OFFSET) for c in _hira)
    _COMBO[_kata] = _rom
_SINGLE['ー'] = '-'  # long vowel mark (handled specially)


def kana_to_romaji(text):
    """Convert hiragana/katakana to romaji."""
    result = []
    i = 0
    while i < len(text):
        # Two-char combos first
        if i + 1 < len(text) and text[i:i+2] in _COMBO:
            result.append(_COMBO[text[i:i+2]])
            i += 2
        # Small tsu = double next consonant
        elif text[i] in ('っ', 'ッ'):
            if i + 1 < len(text):
                nxt = text[i+1:i+2]
                if nxt in _SINGLE:
                    rom = _SINGLE[nxt]
                    result.append(rom[0] if rom[0].isalpha() else '')
                elif i + 2 <= len(text) and text[i+1:i+3] in _COMBO:
                    rom = _COMBO[text[i+1:i+3]]
                    result.append(rom[0])
            i += 1
        # Long vowel mark
        elif text[i] in ('ー', '-'):
            if result:
                last = result[-1]
                if last and last[-1] in 'aiueo':
                    result.append(last[-1])
            i += 1
        # Single kana
        elif text[i] in _SINGLE:
            result.append(_SINGLE[text[i]])
            i += 1
        # Non-kana (spaces, punctuation, etc.)
        else:
            c = text[i]
            if c.isspace():
                result.append('_')
            elif c.isalnum():
                result.append(c.lower())
            # skip punctuation
            i += 1
    return ''.join(result)


# ── Text processing ─────────────────────────────────────────────────

_FURIGANA_RE = re.compile(r'【[^】]+】')
_FURIGANA_EXTRACT_RE = re.compile(r'([^【]*)【([^】]+)】')


def strip_furigana(text):
    """Remove bracket furigana, leaving kanji for TTS engine."""
    return _FURIGANA_RE.sub('', text)


def extract_reading(text):
    """Extract reading from furigana brackets. Return kana string."""
    parts = []
    last = 0
    for m in _FURIGANA_EXTRACT_RE.finditer(text):
        # Text before this match (between brackets)
        before_start = m.start()
        if before_start > last:
            parts.append(text[last:before_start])
        # The kanji part is replaced by its reading
        parts.append(m.group(2))
        last = m.end()
    if last < len(text):
        parts.append(text[last:])
    reading = ''.join(parts)
    # Clean up non-kana leftovers
    reading = re.sub(r'[、。！？・\s/]', '', reading)
    return reading


def furigana_to_reading(text):
    """Replace kanji【reading】 with reading, keep everything else (punctuation, kana).

    e.g. あの人【ひと】は誰【だれ】？ -> あのひとはだれ？
    """
    # Replace kanji+【reading】 with just reading
    # \S+【 would eat kana too, so only match CJK ideographs before 【
    return re.sub(r'[\u4e00-\u9fff\u3400-\u4dbf]+【([^】]+)】', r'\1', text)


def text_for_tts(text):
    """Prepare text for TTS: strip furigana brackets, keep kanji for context.

    Kanji gives TTS better context for disambiguation than raw kana
    (e.g. 入る reads as hairu, but はいる can become wairu).
    """
    text = strip_furigana(text)
    # Normalize haiku line separator
    text = text.replace(' / ', '、')
    return text.strip()


def to_romaji_filename(text, reading_col=''):
    """Convert Japanese text to romaji filename."""
    if reading_col:
        # Compounds have an explicit reading column
        return kana_to_romaji(reading_col)
    reading = extract_reading(text)
    if not reading:
        reading = strip_furigana(text)
    romaji = kana_to_romaji(reading)
    # Truncate long names, deduplicate underscores
    romaji = re.sub(r'_+', '_', romaji).strip('_')
    if len(romaji) > 60:
        romaji = romaji[:60]
    return romaji or 'unknown'


# ── CSV helpers ──────────────────────────────────────────────────────

def load_csv(name):
    with open(DATA / f'{name}.csv', newline='', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def id_num(row_id):
    """Extract numeric part: 'word-42' -> '42'."""
    return row_id.rsplit('-', 1)[-1]


# ── TTS generation ──────────────────────────────────────────────────

_cache = {}  # text_hash -> path (avoid re-generating identical text)


async def tts_generate(text, voice, output_path, retries=3):
    """Generate a single MP3 file using edge-tts."""
    import edge_tts

    # Content-hash cache
    h = hashlib.sha256(f'{text}|{voice}'.encode()).hexdigest()[:12]
    if h in _cache and _cache[h].exists():
        import shutil
        shutil.copy2(_cache[h], output_path)
        return

    for attempt in range(retries):
        try:
            communicate = edge_tts.Communicate(text, voice)
            await communicate.save(str(output_path))
            _cache[h] = output_path
            # Small delay to avoid rate limiting
            await asyncio.sleep(0.3)
            return
        except Exception as e:
            if attempt < retries - 1:
                wait = 2 ** (attempt + 1)
                print(f'    retry in {wait}s ({e})')
                await asyncio.sleep(wait)
            else:
                raise


def merge_mp3s(parts, output_path):
    """Merge multiple MP3 files with silence gaps using ffmpeg."""
    if not parts:
        return
    if len(parts) == 1:
        import shutil
        shutil.copy2(parts[0], output_path)
        return

    # Build ffmpeg filter: concat with silence between each
    inputs = []
    filter_parts = []
    for i, p in enumerate(parts):
        inputs.extend(['-i', str(p)])
        filter_parts.append(f'[{i}:a]')

    # Use anullsrc for silence between segments
    silence_filter = f'anullsrc=r=24000:cl=mono:d={SILENCE_MS / 1000}'
    n = len(parts)

    # Build complex filter
    filter_str = ''
    silence_idx = n
    for i in range(n - 1):
        inputs.extend(['-f', 'lavfi', '-i', f'{silence_filter}'])
    # Interleave: audio0, silence, audio1, silence, ..., audioN
    concat_inputs = []
    for i in range(n):
        concat_inputs.append(f'[{i}:a]')
        if i < n - 1:
            concat_inputs.append(f'[{silence_idx + i}:a]')
    total = n + (n - 1)
    filter_str = f'{"".join(concat_inputs)}concat=n={total}:v=0:a=1[out]'

    cmd = ['ffmpeg', '-y'] + inputs + [
        '-filter_complex', filter_str,
        '-map', '[out]',
        '-c:a', 'libmp3lame', '-b:a', '128k',
        str(output_path)
    ]
    subprocess.run(cmd, capture_output=True, check=True)


# ── Generation tasks ────────────────────────────────────────────────

async def gen_words():
    """Generate audio for all words + example sentences."""
    words = load_csv('words')
    out = AUDIO_OUT / 'w'
    out.mkdir(parents=True, exist_ok=True)

    # Detect romaji collisions
    seen = {}
    for row in words:
        romaji = to_romaji_filename(row['minihongo'])
        base = f'w_{romaji}'
        seen.setdefault(base, []).append(row['id'])
    collisions = {b for b, ids in seen.items() if len(ids) > 1}

    results = []
    for row in words:
        romaji = to_romaji_filename(row['minihongo'])
        base = f'w_{romaji}'
        suffix = f'_{id_num(row["id"])}' if base in collisions else ''
        # Word audio
        word_file = f'{base}{suffix}.mp3'
        word_path = out / word_file
        if not word_path.exists():
            tts_text = strip_furigana(row['minihongo'])
            await tts_generate(tts_text, VOICE_MALE, word_path)
            print(f'  {word_file}')

        # Example sentence audio
        ex_file = None
        if row.get('example_minihongo', '').strip():
            ex_file = f'{base}{suffix}_ex.mp3'
            ex_path = out / ex_file
            if not ex_path.exists():
                tts_text = text_for_tts(row['example_minihongo'])
                await tts_generate(tts_text, VOICE_MALE, ex_path)
                print(f'  {ex_file}')

        results.append((row['id'], word_file, ex_file))
    return results


async def gen_grammar_examples():
    """Generate audio for grammar example sentences."""
    examples = load_csv('grammar_examples')
    out = AUDIO_OUT / 'ge'
    out.mkdir(parents=True, exist_ok=True)

    results = []
    for row in examples:
        num = id_num(row['id'])
        filename = f'ge_{num}.mp3'
        path = out / filename
        if not path.exists():
            tts_text = text_for_tts(row['minihongo'])
            await tts_generate(tts_text, VOICE_MALE, path)
            print(f'  {filename}')
        results.append((row['id'], filename))
    return results


async def gen_compounds():
    """Generate audio for compound words."""
    compounds = load_csv('compounds')
    out = AUDIO_OUT / 'c'
    out.mkdir(parents=True, exist_ok=True)

    # Detect romaji collisions and add ID suffix
    seen_names = {}
    for row in compounds:
        romaji = to_romaji_filename(row['minihongo'], row.get('reading', ''))
        base = f'c_{romaji}'
        if base in seen_names:
            seen_names[base].append(row['id'])
        else:
            seen_names[base] = [row['id']]
    collisions = {b for b, ids in seen_names.items() if len(ids) > 1}

    results = []
    for row in compounds:
        romaji = to_romaji_filename(row['minihongo'], row.get('reading', ''))
        base = f'c_{romaji}'
        if base in collisions:
            filename = f'c_{romaji}_{id_num(row["id"])}.mp3'
        else:
            filename = f'{base}.mp3'
        path = out / filename
        if not path.exists():
            # Use reading for TTS if available (compounds are kanji-only)
            tts_text = row.get('reading', '') or text_for_tts(row['minihongo'])
            await tts_generate(tts_text, VOICE_MALE, path)
            print(f'  {filename}')
        results.append((row['id'], filename))
    return results


async def gen_expressions():
    """Generate audio for expressions."""
    expressions = load_csv('expressions')
    out = AUDIO_OUT / 'e'
    out.mkdir(parents=True, exist_ok=True)

    results = []
    for row in expressions:
        num = id_num(row['id'])
        romaji = to_romaji_filename(row['minihongo'], row.get('reading', ''))
        # Use ID number as prefix to avoid filename collisions
        filename = f'e_{num}_{romaji}.mp3'
        if len(filename) > 80:
            filename = f'e_{num}.mp3'
        path = out / filename
        if not path.exists():
            tts_text = row.get('reading', '') or text_for_tts(row['minihongo'])
            await tts_generate(tts_text, VOICE_MALE, path)
            print(f'  {filename}')
        results.append((row['id'], filename))
    return results


async def gen_haiku():
    """Generate audio for each haiku (one file per haiku)."""
    haiku = load_csv('haiku')
    out = AUDIO_OUT / 'h'
    out.mkdir(parents=True, exist_ok=True)

    results = []
    for row in haiku:
        num = id_num(row['id'])
        filename = f'h_{num}.mp3'
        path = out / filename
        if not path.exists():
            tts_text = text_for_tts(row['minihongo'])
            await tts_generate(tts_text, VOICE_MALE, path)
            print(f'  {filename}')
        results.append((row['id'], filename))
    return results


async def gen_dialogs():
    """Generate merged audio per dialog group. Speaker A=male, B=female."""
    groups = load_csv('dialog_groups')
    dialogs = load_csv('dialogs')
    out = AUDIO_OUT / 'd'
    out.mkdir(parents=True, exist_ok=True)

    # Group lines by dialog_group_id
    lines_by_group = {}
    for d in dialogs:
        gid = d['dialog_group_id']
        lines_by_group.setdefault(gid, []).append(d)
    for lines in lines_by_group.values():
        lines.sort(key=lambda r: int(r['line_number']))

    results = []
    for group in groups:
        gid = group['id']
        num = id_num(gid)
        filename = f'd_{num}.mp3'
        path = out / filename
        if path.exists():
            results.append((gid, filename))
            continue

        lines = lines_by_group.get(gid, [])
        if not lines:
            continue

        # Generate individual line audio
        tmp_parts = []
        with tempfile.TemporaryDirectory() as tmp:
            for i, line in enumerate(lines):
                voice = VOICE_FEMALE if line['speaker_minihongo'] == 'B' else VOICE_MALE
                tts_text = text_for_tts(line['minihongo'])
                part_path = Path(tmp) / f'{i:03d}.mp3'
                await tts_generate(tts_text, voice, part_path)
                tmp_parts.append(part_path)

            merge_mp3s(tmp_parts, path)
        print(f'  {filename} ({len(lines)} lines)')
        results.append((gid, filename))
    return results


async def gen_stories():
    """Generate merged audio per story."""
    stories = load_csv('stories')
    out = AUDIO_OUT / 's'
    out.mkdir(parents=True, exist_ok=True)

    results = []
    for row in stories:
        num = id_num(row['id'])
        filename = f's_{num}.mp3'
        path = out / filename
        if path.exists():
            results.append((row['id'], filename))
            continue

        # Split story into sentences (separated by spaces in the data)
        full_text = text_for_tts(row['minihongo'])
        sentences = [s.strip() for s in re.split(r'\s+', full_text) if s.strip()]

        # Generate each sentence, then merge
        with tempfile.TemporaryDirectory() as tmp:
            parts = []
            for i, sentence in enumerate(sentences):
                part_path = Path(tmp) / f'{i:03d}.mp3'
                await tts_generate(sentence, VOICE_MALE, part_path)
                parts.append(part_path)

            merge_mp3s(parts, path)
        print(f'  {filename} ({len(sentences)} sentences)')
        results.append((row['id'], filename))
    return results


# ── DB update ───────────────────────────────────────────────────────

def update_csv(name, results, id_field='id', audio_field='audio_file'):
    """Add/update audio_file column in a CSV."""
    path = DATA / f'{name}.csv'
    with open(path, newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        fieldnames = list(reader.fieldnames)
        rows = list(reader)

    if audio_field not in fieldnames:
        fieldnames.append(audio_field)

    lookup = {r[0]: r[1] for r in results}
    for row in rows:
        rid = row[id_field]
        if rid in lookup:
            row[audio_field] = lookup[rid]
        elif audio_field not in row:
            row[audio_field] = ''

    with open(path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def update_words_csv(results):
    """Update words.csv with both audio_word and audio_example columns."""
    path = DATA / 'words.csv'
    with open(path, newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        fieldnames = list(reader.fieldnames)
        rows = list(reader)

    for col in ('audio_word', 'audio_example'):
        if col not in fieldnames:
            fieldnames.append(col)

    lookup = {r[0]: (r[1], r[2]) for r in results}
    for row in rows:
        if row['id'] in lookup:
            word_f, ex_f = lookup[row['id']]
            row['audio_word'] = word_f
            row['audio_example'] = ex_f or ''
        else:
            row.setdefault('audio_word', '')
            row.setdefault('audio_example', '')

    with open(path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def update_datapackage():
    """Add audio_file fields to datapackage.json schema."""
    path = DATA / 'datapackage.json'
    with open(path, encoding='utf-8') as f:
        pkg = json.load(f)

    audio_field = {'name': 'audio_file', 'type': 'string'}
    audio_word = {'name': 'audio_word', 'type': 'string'}
    audio_example = {'name': 'audio_example', 'type': 'string'}

    for res in pkg['resources']:
        fields = res['schema']['fields']
        field_names = [f['name'] for f in fields]

        if res['name'] == 'words':
            if 'audio_word' not in field_names:
                fields.append(audio_word)
            if 'audio_example' not in field_names:
                fields.append(audio_example)
        elif res['name'] in ('grammar_examples', 'compounds', 'expressions',
                              'haiku', 'dialog_groups', 'stories'):
            if 'audio_file' not in field_names:
                fields.append(audio_field)

    with open(path, 'w', encoding='utf-8') as f:
        json.dump(pkg, f, indent=2, ensure_ascii=False)
        f.write('\n')


# ── Main ────────────────────────────────────────────────────────────

async def main():
    import argparse
    parser = argparse.ArgumentParser(description='Generate TTS audio for minihongo')
    parser.add_argument('--only', choices=['words', 'grammar', 'compounds',
                                           'expressions', 'haiku', 'dialogs', 'stories'],
                        help='Generate only one category')
    parser.add_argument('--db-only', action='store_true',
                        help='Only update CSV schemas, no audio generation')
    args = parser.parse_args()

    if args.db_only:
        print('Updating datapackage.json...')
        update_datapackage()
        print('Done.')
        return

    AUDIO_OUT.mkdir(exist_ok=True)

    tasks = {
        'words': (gen_words, lambda r: update_words_csv(r)),
        'grammar': (gen_grammar_examples, lambda r: update_csv('grammar_examples', r)),
        'compounds': (gen_compounds, lambda r: update_csv('compounds', r)),
        'expressions': (gen_expressions, lambda r: update_csv('expressions', r)),
        'haiku': (gen_haiku, lambda r: update_csv('haiku', r)),
        'dialogs': (gen_dialogs, lambda r: update_csv('dialog_groups', r)),
        'stories': (gen_stories, lambda r: update_csv('stories', r)),
    }

    to_run = [args.only] if args.only else list(tasks.keys())

    for name in to_run:
        gen_fn, update_fn = tasks[name]
        print(f'\n[{name}]')
        results = await gen_fn()
        update_fn(results)
        print(f'  -> {len(results)} items')

    print(f'\nUpdating datapackage.json...')
    update_datapackage()
    print('Done.')


if __name__ == '__main__':
    asyncio.run(main())
