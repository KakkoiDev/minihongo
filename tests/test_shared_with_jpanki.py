"""Guard against mh_common drifting from jpanki.

`mh_common.strip_furigana` is deliberately *not* delegated to jpanki, even though
jpanki has the same function. `make build` runs `python3 generate_pages.py`,
which imports mh_common, and the site build's stdlib-only guarantee is what
keeps it deployable from a bare Python. Importing jpanki there would quietly end
that.

So the duplication stays, and this test makes it safe: the two implementations
must agree on every bracketed value in the corpus. If they ever diverge, this
fails rather than the difference surfacing as a rendering bug months later.

Only the artifact generators (Anki, audio, PDF) depend on jpanki. Those already
needed genanki and edge-tts, so they never had the guarantee to lose.
"""
import subprocess
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).parent.parent))

import mh_common
from jpanki import furigana

ROOT = Path(__file__).parent.parent


def bracketed_values():
    """Every distinct field value in data/ that carries furigana."""
    import csv

    found = set()
    for path in sorted((ROOT / "data").glob("*.csv")):
        with path.open(encoding="utf-8", newline="") as handle:
            for row in csv.DictReader(handle):
                for value in row.values():
                    if value and "【" in value:
                        found.add(value)
    return sorted(found)


CORPUS = bracketed_values()


def test_corpus_is_not_empty():
    assert len(CORPUS) > 100, "expected the CSVs to contain furigana"


@pytest.mark.parametrize("text", CORPUS, ids=[t[:30] for t in CORPUS])
def test_strip_furigana_agrees_with_jpanki(text):
    assert mh_common.strip_furigana(text) == furigana.strip(text)


@pytest.mark.parametrize(
    "text", ["", "人【ひと】", "人【", "人【】", "【ひと】", "これは本です。", "少々【しょうしょう】"]
)
def test_strip_furigana_agrees_on_edge_cases(text):
    assert mh_common.strip_furigana(text) == furigana.strip(text)


def test_site_build_needs_no_third_party_packages():
    """The site build must keep working on a bare Python.

    Runs generate_pages.py with an interpreter that cannot see the project
    virtualenv. If someone adds a third-party import to mh_common or
    generate_pages.py, this fails.
    """
    result = subprocess.run(
        [sys.executable, "-S", "-c",
         "import sys; sys.path.insert(0, '.'); import mh_common, generate_pages"],
        cwd=ROOT,
        capture_output=True,
        text=True,
        env={"PYTHONPATH": "", "PATH": "/usr/bin:/bin"},
    )
    assert result.returncode == 0, (
        "the site build gained a third-party dependency:\n" + result.stderr
    )
