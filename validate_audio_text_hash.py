#!/usr/bin/env python3
"""Fail when a row's audio-relevant text changed since its audio was generated.

Audio filenames for words/compounds/expressions/comprehension/advanced embed a
romaji hash of their text, so an edit there forces a new filename and can't go
unnoticed. grammar_examples, haiku, stories and dialog_groups instead key their
audio file on the row/group ID alone (see generate_audio.py) - an edit to the
text does not change the filename, so a stale file can silently ship next to
changed text. This tracks a hash of each such row's synthesized text and fails
when it drifts from the value recorded at the last `--write` (run right after
`python generate_audio.py`).
"""
import hashlib
import json
import sys
from pathlib import Path

from mh_common import load_csv

MANIFEST = Path('.audio-text-hashes.json')


def _hash(text):
    return hashlib.sha256(text.encode('utf-8')).hexdigest()[:16]


def _dialog_group_texts():
    groups = load_csv('dialog_groups')
    dialogs = load_csv('dialogs')
    lines_by_group = {}
    for d in dialogs:
        lines_by_group.setdefault(d['dialog_group_id'], []).append(d)
    for lines in lines_by_group.values():
        lines.sort(key=lambda r: int(r['line_number']))
    return {
        g['id']: ''.join(l['minihongo'] for l in lines_by_group.get(g['id'], []))
        for g in groups
    }


def current_hashes():
    hashes = {}
    for row in load_csv('grammar_examples'):
        hashes[f'grammar_examples:{row["id"]}'] = _hash(row['minihongo'])
    for row in load_csv('haiku'):
        hashes[f'haiku:{row["id"]}'] = _hash(row['minihongo'])
    for row in load_csv('stories'):
        hashes[f'stories:{row["id"]}'] = _hash(row['minihongo'])
    for gid, text in _dialog_group_texts().items():
        hashes[f'dialog_groups:{gid}'] = _hash(text)
    return hashes


def write_manifest():
    hashes = current_hashes()
    MANIFEST.write_text(json.dumps(hashes, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(f'wrote {MANIFEST} ({len(hashes)} rows)')
    return 0


def check():
    if not MANIFEST.exists():
        print(f'{MANIFEST} missing; run with --write right after generating audio', file=sys.stderr)
        return 2
    recorded = json.loads(MANIFEST.read_text(encoding='utf-8'))
    current = current_hashes()
    drift = sorted(k for k in current if recorded.get(k) != current[k])
    if drift:
        print(f'{len(drift)} row(s) have text that changed since their audio was generated:')
        for k in drift:
            print(f'  {k}')
        print('Regenerate audio for these rows, then run `python validate_audio_text_hash.py --write`.')
        return 1
    print('Audio text hashes match - OK')
    return 0


def main():
    if '--write' in sys.argv:
        return write_manifest()
    return check()


if __name__ == '__main__':
    sys.exit(main())
