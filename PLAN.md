# Plan: finish the fixes, then add the engineering layer

Status: approved 2026-08-25, not started. Start only on Cyril's explicit go.
Any agent may pick this up. Source of the findings: the 2026-08-2x audit report
(firstmate `data/minihongo-gaps/report.md`) and `DECISIONS.md`.

## Decisions already taken (2026-08-25)

- One branch, everything committed, pushed to `master`. No PR split.
- Regenerate all audio. Audio must match text for every row.
- Engineering layer is two-tier: circumlocutions built from the 231, plus
  katakana loanwords said as-is. Every circumlocution must sound natural and be
  understood instantly by a native speaker; if it does not, use the loanword.
- The engineering page is not linked from the navigation. That is the only
  rule. It may be in the sitemap and indexed. Anyone with the URL may read it.
- Order: fixes first (integrity, docs, canon, content), then the engineering
  layer.

## Part A: finish the fixes

State of the paused work (a worker copy exists with uncommitted changes):

- The CI freshness gate is committed (`9580c29`).
- 137 rewritten expression rows are uncommitted. Their `audio_file` values are
  stale (example: expr-2 text is 家の人たち, file is still
  `e_2_chichihahakodomo.mp3`). Do not ship text without regenerating audio.
- `validate_expressions.py` (128 lines) exists but is not in CI.

Work, in order, all on one branch:

1. Integrity: renumber duplicate `categories.csv` ids; add `frictionless` to
   `pyproject.toml` and `site/build.py --check` to CI; generate `SCHEMA.md` from
   `datapackage.json` and fail the build on drift; build the whitelist from
   headwords only; fix the README arithmetic.
2. Docs and ja leaks: kana prerequisite in README and site intro (3 languages);
   `t()` renders nothing instead of English on the ja site, or fill the 57
   cells; render or drop `expressions.reading`; translate the AI prompt to ja
   and mh. Build check: zero English strings on ja pages.
3. Canon: resolve the 8 ambiguous collisions first, then the 128 conflicts and
   the 14 stale base-word circumlocutions; put `validate_expressions.py` in CI;
   regenerate audio for every changed row with `generate_audio.py`; add an
   audio-text hash check that fails when a row's text changes without its
   audio; keep deck GUIDs unchanged for untouched rows; clean orphan MP3s last.
4. Content: emergency dialog group (call 119/110, name the emergency, give an
   address), dlg-222 learner makes the call, dlg-224 first-aid line, Tuesday to
   Saturday, cando-12, missing productive rows (garbage, paper, ambulance,
   symptoms, 何人). A first-aider reads the emergency lines before release.

Every new row passes `validate_vocab.py` (built from the 231 only). Count
claims (`COUNT_CLAIM_DOCS`) must stay true.

## Part B: the engineering layer

Goal: Cyril can talk fluently with his engineering team in Japanese using the
same less-is-more method. Katakana loanwords are allowed on this page.

Situations to cover (seed list from Cyril, extend with anything useful):

- daily meetings (standup: yesterday, today, blocked)
- incident reports (it stopped, since when, what I see, what I am doing)
- system engineering explanation (how a system works, data flow, why)
- tech demo (what you see, what happens when, before and after)
- task planning (estimate, priority, dependency, deadline, not sure)
- requirement clarification with the product owner (what do you mean, in which
  case, is this needed, what if)
- also: bug fixing and code review talk, task advancement ("done", "half",
  "waiting for"), pipeline and deploy talk (build, test, release, roll back)

Content shape:

- About 60 productive circumlocutions from the 231, in 5 categories: how it
  behaves; what we do; where (server, screen, database, network); people and
  time; talking about a problem. Naturalness gate: a native speaker must
  understand each one instantly. Otherwise use the loanword.
- About 40 loanwords said as-is (バグ, エラー, サーバー, データ, テスト,
  デプロイ, リリース, マージ, レビュー, ログ, コード, ブランチ, ...), listed with
  the real Japanese where it differs.
- 6 dialogs matching the situations above, 6 can-dos, an engineering variant of
  the Practice AI prompt (the AI plays a Japanese colleague using only the 231
  plus the loanword list). Three language versions (en, ja, mh).

Data and build:

- `pages.csv`: new row `engineering`, path `lessons/engineering.html`,
  `nav_group` value `hidden`. `hidden` pages get no nav entry. They stay in the
  sitemap and are indexable.
- `categories.csv` rows with `page_id=engineering`; rows in `expressions.csv`
  (circumlocutions) and the existing loanword tier; `dialog_groups.csv`,
  `dialogs.csv`, `candos.csv`, `ui_strings.csv`.
- Every circumlocution passes `validate_vocab.py` and the canon validator (no
  collision with an existing target).
- Audio via `generate_audio.py` (edge-tts), regenerated with the rest.
- Not added to the core decks; Cyril builds a separate Anki deck for this page.
- No "231" count claim changes.

## Definition of done

- CI green on master with the new checks in place.
- Every expression row's audio matches its text (hash check green).
- Engineering page reachable by URL, absent from the navigation, in all three
  languages.
- README and site counts still true.
