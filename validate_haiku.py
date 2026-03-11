#!/usr/bin/env python3
"""Validate haiku meter (5/7/5 morae) from furigana readings."""

import csv
import re
import sys

# Small kana that combine with previous character (not separate morae)
COMBO_KANA = set("ゃゅょャュョァィゥェォ")


def to_reading(text: str) -> str:
    """Convert furigana-annotated text to pure hiragana reading.

    山【やま】の上【うえ】 → やまのうえ
    """
    # Replace kanji【reading】 with just the reading
    result = re.sub(r"[\u4e00-\u9fff\u3005]+【(.+?)】", r"\1", text)
    # Remove anything that isn't hiragana/katakana/ー
    result = re.sub(r"[^\u3040-\u309f\u30a0-\u30ffー]", "", result)
    return result


def count_morae(reading: str) -> int:
    """Count morae in a hiragana/katakana string."""
    count = 0
    for ch in reading:
        if ch in COMBO_KANA:
            continue  # combines with previous mora
        count += 1
    return count


def validate_haiku(csv_path: str = "data/haiku.csv") -> list[dict]:
    errors = []
    with open(csv_path, newline="", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            lines = row["minihongo"].split(" / ")
            if len(lines) != 3:
                errors.append({
                    "id": row["id"],
                    "issue": f"expected 3 lines, got {len(lines)}",
                    "text": row["minihongo"],
                })
                continue

            expected = [5, 7, 5]
            readings = [to_reading(line) for line in lines]
            counts = [count_morae(r) for r in readings]

            if counts != expected:
                details = []
                for i, (exp, got, rd) in enumerate(
                    zip(expected, counts, readings), 1
                ):
                    mark = "x" if exp != got else " "
                    details.append(f"  [{mark}] L{i}: {rd} = {got} ({exp})")
                errors.append({
                    "id": row["id"],
                    "issue": f"meter {counts[0]}/{counts[1]}/{counts[2]}",
                    "text": row["minihongo"],
                    "details": "\n".join(details),
                })
    return errors


if __name__ == "__main__":
    errors = validate_haiku()
    if not errors:
        print("All 5/7/5 - OK")
        sys.exit(0)

    print(f"{len(errors)} haiku with meter issues:\n")
    for e in errors:
        print(f"{e['id']}: {e['issue']}")
        print(f"  {e['text']}")
        if "details" in e:
            print(e["details"])
        print()
    sys.exit(1)
