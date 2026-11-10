import csv
import json
from pathlib import Path

from validate_word_images import validate, validate_svg

ROOT = Path(__file__).parents[1]


def words():
    with (ROOT / 'data' / 'words.csv').open(encoding='utf-8', newline='') as f:
        return list(csv.DictReader(f))


def manifest():
    return json.loads((ROOT / 'data' / 'word_images.json').read_text(encoding='utf-8'))


def test_image_validator_accepts_repository_assets():
    assert validate() == []


def test_every_word_has_one_manifest_entry():
    assert {row['id'] for row in words()} == {entry['id'] for entry in manifest()}
    assert len(manifest()) == len({entry['id'] for entry in manifest()}) == 231


def test_manifest_japanese_is_the_authored_word():
    expected = {row['id']: row['minihongo'] for row in words()}
    assert all(entry['word'] == expected[entry['id']] for entry in manifest())


def test_every_picture_is_a_small_real_svg():
    for entry in manifest():
        image = ROOT / 'site' / 'static' / 'word-images' / f"{entry['id']}.svg"
        assert validate_svg(image) == []
        assert '<image' not in image.read_text(encoding='utf-8')


def test_vector_set_is_clean_and_light():
    directory = ROOT / 'site' / 'static' / 'word-images'
    svgs = list(directory.glob('*.svg'))
    assert sum(image.stat().st_size for image in svgs) <= 450_000
    assert not list(directory.glob('*.png'))
    for image in svgs:
        text = image.read_text(encoding='utf-8')
        assert 'stroke-width="4"' in text or 'stroke-width="6"' in text
        assert 'stroke-linecap="round"' in text
        assert '<filter' not in text
        assert '<image' not in text


def test_practice_data_builder_exposes_images():
    source = (ROOT / 'site' / 'build.py').read_text(encoding='utf-8')
    assert "'image': f\"/static/word-images/{w['id']}.svg\"" in source


def test_picture_mode_is_persistent_and_translation_free():
    source = (ROOT / 'site' / 'static' / 'practice.js').read_text(encoding='utf-8')
    assert "const PICTURE_KEY = 'practice_pictures'" in source
    assert "localStorage.setItem(PICTURE_KEY" in source
    assert "visual ? '' : `<p class=\"practice-meaning\">" in source


def test_vocabulary_mode_is_persistent():
    source = (ROOT / 'site' / 'static' / 'app.js').read_text(encoding='utf-8')
    assert "localStorage.getItem('vocab_display')" in source
    assert "localStorage.setItem('vocab_display', mode)" in source
