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
import hashlib
import re
import sys
from collections import defaultdict
from pathlib import Path

DATA = Path('data')

# Banned words: kana-only words that are NOT in the base vocabulary.
# These look like they could be valid minihongo but they aren't.
# Add words here to prevent them from creeping back into mh content.
#
# This list is the only kana-word guard: kanji are validated against the
# vocabulary, but kana-only words pass unchecked (full coverage would need a
# tokenizer dependency like fugashi). When a leak ships, fix it and ban it here.
BANNED_WORDS = [
    'つなぐ',
    'ございます',  # ありがとうございます leaked into 9 dialog lines; mh uses ありがとう
    'けど',        # taught form is でも
    'ちょっと',    # taught form is 少し
    'たくさん',    # taught form is 多い
    'いっぱい',
    'やっぱり',
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
# These are all readings of kanji already in the 206 base words,
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
    '一': {'ひと'},               # 一(いち) -> 一人(ひとり), 一つ(ひとつ)
    '二': {'ふた'},               # 二(に) -> 二つ(ふたつ)
    '三': {'みっ'},               # 三(さん) -> 三つ(みっつ)
    '四': {'し', 'よ', 'よっ'},   # 四(よん) -> 四月(し), 四時(よ), 四つ(よっ)
    '五': {'いつ'},               # 五(ご) -> 五つ(いつつ)
    '六': {'ろっ', 'むっ'},       # 六(ろく) -> 六百(ろっ), 六つ(むっ)
    '七': {'しち'},               # 七(なな) -> 七月(しち)
    '八': {'はっ', 'やっ'},       # 八(はち) -> 八百(はっ), 八つ(やっ)
    '九': {'く', 'ここの'},       # 九(きゅう) -> 九月(く), 九つ(ここの)
    '十': {'とお'},               # 十(じゅう) -> 十(とお) counter form
    '百': {'びゃく', 'ぴゃく'},   # 百(ひゃく) -> 三百(びゃく), 六百(ぴゃく)
    '分': {'ぶん', 'ふん', 'ぷん'},  # 分(わ) -> 多分(ぶん); clock minutes 五分(ふん), 三分(ぷん)
    '時': {'じ'},                 # 時(とき) -> 三時(じ) clock hours
    '光': {'ひか'},               # 光(ひかり) -> 光る(ひか) verb stem
    '年': {'ねん'},               # 年(とし) -> 百年(ひゃくねん) on'yomi
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
    'candos': ['minihongo'],
    # compounds: only definition_minihongo (minihongo col uses real Japanese)
    'compounds': ['definition_minihongo'],
    # comprehension: only the gloss (japanese/tts_text cols use real Japanese)
    'comprehension': ['minihongo'],
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


# Word-count claims in prose must match the real vocab size, or a claim has drifted
# (e.g. the books said "182 base words" after the list grew to 206). Patterns target
# unambiguous base-vocabulary mentions, not the 202-compounds count.
COUNT_CLAIM_PATTERNS = [
    re.compile(r'(\d+)\s+base words'),     # en: "206 base words"
    re.compile(r'(\d+)-word vocabulary'),  # en: "206-word vocabulary"
    re.compile(r'(\d+)\s*の基本語'),        # ja: "206の基本語"
    re.compile(r'(\d+)\s*語の漢字'),        # ja: "206語の漢字"
    # Tagline formats. These were unguarded, which is how a book tagline drifted to
    # 207 unnoticed. The books now interpolate the count, but the site copies live in
    # ui_strings/pages as plain text and still need checking.
    re.compile(r'(\d+)\s+words\b'),        # en tagline: "206 words. Say anything."
    re.compile(r'(\d+)\s*語'),             # ja tagline: "206語で何でも言える。"
    re.compile(r'(\d+)\s*の言葉'),          # mh tagline: "206の言葉。何でも言える。"
    re.compile(r'(\d+)\s+core words'),     # README: "206 core words by category"
    re.compile(r'(\d+)\s+base vocabulary'),  # README: "words.csv  # 206 base vocabulary"
]

# Tracked docs that state the current word count. RESEARCH.md and DILEMMA.md are
# excluded: they discuss comparative and tiered counts (Toki Pona's 120 words,
# "~60-80 words" loanword tiers) that legitimately differ from the vocab size.
COUNT_CLAIM_DOCS = ['README.md', '.claude/skills/minihongo/SKILL.md']


def check_count_claims(expected):
    """Verify every base-word-count claim in prose equals the real vocab size."""
    errors = []
    for csv_name in ('ui_strings', 'pages'):
        for row in load_csv(csv_name):
            row_id = row.get('id', row.get('key', '?'))
            for col, text in row.items():
                if not text:
                    continue
                for pat in COUNT_CLAIM_PATTERNS:
                    for m in pat.finditer(text):
                        n = int(m.group(1))
                        if n != expected:
                            errors.append({
                                'source': f'{csv_name}:{row_id}:{col}',
                                'issue': f'word-count claim says {n}, words.csv has {expected}',
                            })
    return errors


def check_doc_count_claims(expected):
    """Verify base-word-count claims in tracked markdown docs."""
    errors = []
    for doc in COUNT_CLAIM_DOCS:
        path = Path(doc)
        if not path.exists():
            continue
        lines = path.read_text(encoding='utf-8').splitlines()
        for lineno, line in enumerate(lines, 1):
            for pat in COUNT_CLAIM_PATTERNS:
                for m in pat.finditer(line):
                    n = int(m.group(1))
                    if n != expected:
                        errors.append({
                            'source': f'{doc}:{lineno}',
                            'issue': f'word-count claim says {n}, words.csv has {expected}',
                        })
    return errors


# ── Artifact freshness ──────────────────────────────────────────────
# Anki decks, PDF books and audio are built locally and uploaded to GitHub releases
# via `make {anki,pdf,audio}-release`. deploy.yml DOWNLOADS those releases as-is and
# never rebuilds them, so when a build input changes without a matching re-release the
# published artifact silently goes stale - exactly how the books drifted to "182 base
# words" while words.csv already held 206.
#
# An artifact's build inputs are: its generator script(s), every CSV those scripts
# load via load_csv() (DERIVED by resolve_sources, so adding a load_csv() call can't
# silently leave an input unguarded), and any non-CSV `extra` (e.g. the imported typst
# template). Each release writes a sha256 manifest of these; check_artifact_freshness
# recomputes them and reports divergence (sha256sum -c compatible). Excluded by design
# (environmental or separately tracked): audio/*.mp3 blobs, print-only covers, fonts,
# the typst compiler + pinned @preview packages.
ARTIFACT_SOURCES = {
    'anki': {
        'manifest': '.anki-manifest',
        'rebuild': 'make anki-release',
        'generators': ['generate_anki.py'],
        'extra': [],
    },
    'pdf': {
        'manifest': '.pdf-manifest',
        'rebuild': 'make pdf-release',
        'generators': ['generate_pdf.py'],
        'extra': ['typst/template.typ'],
    },
    'audio': {
        'manifest': '.audio-manifest',
        'rebuild': 'make audio-release',
        'generators': ['generate_audio.py'],
        'extra': [],
    },
}

# Literal load_csv('name') calls; dynamic names (load_csv(var)) are not detected.
LOAD_CSV_RE = re.compile(r"""load_csv\(\s*['"]([a-z_]+)['"]""")


def resolve_sources(cfg):
    """An artifact's full input set: generator scripts + the CSVs they load + extras."""
    paths = set(cfg['generators']) | set(cfg['extra'])
    for gen in cfg['generators']:
        for name in LOAD_CSV_RE.findall(Path(gen).read_text(encoding='utf-8')):
            paths.add(str(DATA / f'{name}.csv'))
    return sorted(paths)


def _sha256(path):
    h = hashlib.sha256()
    with open(path, 'rb') as f:
        for chunk in iter(lambda: f.read(65536), b''):
            h.update(chunk)
    return h.hexdigest()


def write_manifest(artifact):
    """Record sha256 of an artifact's build inputs (sha256sum -c compatible)."""
    cfg = ARTIFACT_SOURCES.get(artifact)
    if not cfg:
        print(f'unknown artifact: {artifact} (known: {", ".join(ARTIFACT_SOURCES)})')
        return 2
    lines = [f'{_sha256(p)}  {p}' for p in resolve_sources(cfg)]
    Path(cfg['manifest']).write_text('\n'.join(lines) + '\n', encoding='utf-8')
    print(f'wrote {cfg["manifest"]} ({len(lines)} inputs)')
    return 0


def check_artifact_freshness():
    """Compare each artifact's recorded source hashes against the current CSVs.

    Returns per-artifact dicts: {artifact, status, detail, rebuild} where status is
    'fresh', 'stale', or 'untracked' (no manifest written yet).
    """
    results = []
    for artifact, cfg in ARTIFACT_SOURCES.items():
        manifest = Path(cfg['manifest'])
        if not manifest.exists():
            results.append({'artifact': artifact, 'status': 'untracked',
                            'detail': [], 'rebuild': cfg['rebuild']})
            continue
        drift = []
        for line in manifest.read_text(encoding='utf-8').splitlines():
            line = line.strip()
            if not line:
                continue
            recorded, _, path = line.partition('  ')
            p = Path(path)
            if not p.exists():
                drift.append(f'{path} (missing)')
            elif _sha256(p) != recorded:
                drift.append(f'{path} (changed)')
        results.append({'artifact': artifact,
                        'status': 'stale' if drift else 'fresh',
                        'detail': drift, 'rebuild': cfg['rebuild']})
    return results


def report_freshness(strict=False):
    """Print published-artifact freshness. Returns 1 if strict and any are stale."""
    any_stale = False
    for r in check_artifact_freshness():
        if r['status'] == 'fresh':
            print(f'  {r["artifact"]}: current')
        elif r['status'] == 'untracked':
            print(f'  {r["artifact"]}: untracked (no manifest) - run `{r["rebuild"]}`')
        else:
            any_stale = True
            print(f'  {r["artifact"]}: STALE - {len(r["detail"])} source(s) changed '
                  'since last release')
            for d in r['detail']:
                print(f'      {d}')
            print(f'    published artifact is out of date; run `{r["rebuild"]}`')
    return 1 if (strict and any_stale) else 0


def main():
    vocab, char_readings = build_vocab()
    word_count = len(load_csv('words'))
    print(
        f'Base vocabulary: {len(vocab)} kanji entries, '
        f'{len(char_readings)} unique kanji, {word_count} words'
    )
    print()

    content_errors = run_validation('content', VALIDATE_CONTENT, vocab, char_readings)
    meta_errors = run_validation('metadata', VALIDATE_META, vocab, char_readings)
    count_errors = check_count_claims(word_count) + check_doc_count_claims(word_count)

    exit_code = 0
    if not content_errors and not meta_errors and not count_errors:
        print('All vocabulary valid - OK')
    else:
        for label, errs in (
            ('content', content_errors),
            ('metadata', meta_errors),
            ('word-count claim', count_errors),
        ):
            if not errs:
                continue
            print(f'{len(errs)} {label} issues (FAIL):\n')
            for e in errs:
                print(f'  {e["source"]}')
                print(f'    {e["issue"]}')
                print()
            exit_code = 1

    print()
    print('Artifact freshness:')
    report_freshness(strict=False)  # warn-only; does not block the lint

    return exit_code


if __name__ == '__main__':
    argv = sys.argv[1:]
    if argv[:1] == ['--write-manifest']:
        if len(argv) < 2:
            print('usage: validate_vocab.py --write-manifest <anki|pdf>')
            sys.exit(2)
        sys.exit(write_manifest(argv[1]))
    if argv[:1] == ['--check-freshness']:
        print('Artifact freshness:')
        sys.exit(report_freshness(strict=True))
    sys.exit(main())
