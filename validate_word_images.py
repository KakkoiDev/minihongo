#!/usr/bin/env python3
"""Validate the one-to-one mapping between core words and vector cues."""
import csv
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).parent
WORDS = ROOT / 'data' / 'words.csv'
MANIFEST = ROOT / 'data' / 'word_images.json'
IMAGES = ROOT / 'site' / 'static' / 'word-images'


def validate_svg(path):
    """Return vector-format errors without requiring a browser renderer."""
    errors = []
    try:
        root = ET.parse(path).getroot()
    except ET.ParseError as exc:
        return [f'invalid SVG XML: {exc}']
    if root.tag.rsplit('}', 1)[-1] != 'svg':
        errors.append('root element is not svg')
    if root.get('width') != '128' or root.get('height') != '128':
        errors.append('SVG must be 128x128')
    tags = [node.tag.rsplit('}', 1)[-1] for node in root.iter()]
    if 'image' in tags:
        errors.append('SVG embeds a raster image')
    if not any(tag in {'path', 'circle', 'ellipse', 'line', 'polyline', 'polygon', 'rect'} for tag in tags):
        errors.append('SVG has no vector geometry')
    if path.stat().st_size > 30_000:
        errors.append('SVG exceeds 30 KB')
    return errors


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
        expected = f'static/word-images/{word_id}.svg'
        if entry.get('icon') != expected:
            errors.append(f'{word_id}: manifest path must be {expected}')
        if entry.get('word') != words[word_id]['minihongo']:
            errors.append(f'{word_id}: Japanese label differs from words.csv')
        image = IMAGES / f'{word_id}.svg'
        if not image.is_file():
            errors.append(f'{word_id}: image missing')
            continue
        errors.extend(f'{word_id}: {error}' for error in validate_svg(image))
    for word_id in sorted(set(words) - seen):
        errors.append(f'{word_id}: no manifest entry')
    extras = {p.stem for p in IMAGES.glob('*.svg')} - set(words)
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
    print('Word images valid: 231 mapped, lightweight 128x128 vector files')
