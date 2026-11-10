#!/usr/bin/env python3
"""Validate the one-to-one mapping between core words and visual cues."""
import csv
import json
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).parent
WORDS = ROOT / 'data' / 'words.csv'
MANIFEST = ROOT / 'data' / 'word_images.json'
IMAGES = ROOT / 'site' / 'static' / 'word-images'


def png_size(path):
    with path.open('rb') as f:
        header = f.read(24)
    if len(header) != 24 or header[:8] != b'\x89PNG\r\n\x1a\n':
        raise ValueError('not a PNG')
    return struct.unpack('>II', header[16:24])


def validate():
    with WORDS.open(encoding='utf-8', newline='') as f:
        words = {row['id']: row for row in csv.DictReader(f)}
    entries = json.loads(MANIFEST.read_text(encoding='utf-8'))
    errors = []
    seen = set()
    for entry in entries:
        word_id = entry.get('id', '')
        if word_id in seen:
            errors.append(f'{word_id}: duplicate manifest entry')
            continue
        seen.add(word_id)
        if word_id not in words:
            errors.append(f'{word_id}: not present in words.csv')
            continue
        expected = f'icons/{word_id}.png'
        if entry.get('icon') != expected:
            errors.append(f'{word_id}: manifest path must be {expected}')
        if entry.get('word') != words[word_id]['minihongo']:
            errors.append(f'{word_id}: Japanese label differs from words.csv')
        image = IMAGES / f'{word_id}.png'
        if not image.is_file():
            errors.append(f'{word_id}: image missing')
            continue
        try:
            if png_size(image) != (128, 128):
                errors.append(f'{word_id}: image must be 128x128')
        except ValueError as exc:
            errors.append(f'{word_id}: {exc}')
        if image.stat().st_size > 100_000:
            errors.append(f'{word_id}: image exceeds 100 KB')
    for word_id in sorted(set(words) - seen):
        errors.append(f'{word_id}: no manifest entry')
    extras = {p.stem for p in IMAGES.glob('*.png')} - set(words)
    for word_id in sorted(extras):
        errors.append(f'{word_id}: image has no word')
    return errors


if __name__ == '__main__':
    failures = validate()
    if failures:
        print('Word image validation failed:', file=sys.stderr)
        for failure in failures:
            print(f'  {failure}', file=sys.stderr)
        sys.exit(1)
    print('Word images valid: 231 mapped 128x128 PNG files')
