"""Shared constants and helpers for the root generators and validator.

Used by generate_{pages,audio,anki,pdf}.py and validate_vocab.py. The site/
subsystem stays self-contained: engine.py ships its own filter implementations.

This file is a build input for every release artifact (see ARTIFACT_SOURCES in
validate_vocab.py), so editing it marks audio/anki/pdf manifests stale.
"""
import csv
import re
from pathlib import Path

DATA = Path('data')

LANGS = ['en', 'ja', 'mh']
LANG_COL = {'en': 'english', 'ja': 'japanese', 'mh': 'minihongo'}

_FURIGANA_RE = re.compile(r'【[^】]+】')


def load_csv(name):
    """Read data/{name}.csv into a list of dicts."""
    with open(DATA / f'{name}.csv', newline='', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def strip_furigana(text):
    """Remove bracket furigana: 漢字【かんじ】 -> 漢字."""
    if not text:
        return ''
    return _FURIGANA_RE.sub('', text)
