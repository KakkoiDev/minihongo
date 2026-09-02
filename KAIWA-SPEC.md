# 会話 mode - spoken Japanese practice inside the minihongo site

A page on minihongo.com where the user **talks** to an AI in Japanese and it **talks back**,
constrained to the minihongo 231-word core set.

This document is a complete build specification. It is written so that any agent, including
Codex, can pick it up and finish it without further context.

## The problem this solves

The user's Japanese comprehension is far ahead of his production. Under live conversational
load - someone waiting, no backspace, no lookup - he reports his capacity drops to roughly a
third. Every tool he currently owns (five Anki decks, a text tutor skill, a 231-word course)
tests recognition. None makes him produce speech under time pressure.

So the single measure of success for this page is: **does it make him speak Japanese out loud,
repeatedly, without stopping to type or look things up.** A feature that does not serve that is
out of scope, however nice it is.

## Where it lives

Repository: `KakkoiDev/minihongo` (clone at `~/Code/minihongo`). Delivery is direct-PR; the
captain merges his own PRs. Default branch `main`.

The site is a **custom Python static site generator** under `site/`:

```
site/
  build.py        entry point
  dev.py          local dev server
  engine.py       the template engine (documented in its own module docstring)
  lint.py
  manifest.json   PWA manifest
  sw.js           service worker
  components/     page-layout.html, grammar-point.html
  pages/          index.html, 404.html, ja/, lessons/, mh/
  static/         app.js, style.css, icons
```

Output is deployed to GitHub Pages behind the `CNAME` file. **There is no server and there will
not be one.** Everything below must work as static files.

Add the page as `site/pages/kaiwa/index.html`, reusing `components/page-layout.html`. Read
`site/engine.py`'s docstring for the template syntax before writing the template; it is a
bespoke engine, not Jinja, and it supports only what that docstring lists.

## The data

Source of truth is `~/Code/minihongo/data/`, already in this repo:

| File | Rows | What matters here |
|---|---|---|
| `words.csv` | 231 | The core set. `minihongo` column carries 【】 furigana. |
| `expressions.csv` | 1111 | `minihongo` paraphrase, `reading`, `english`, and a real `japanese` equivalent. All 1111 rows have a populated `japanese` column - verified. |
| `grammar.csv` | 43 | 9 marked `core`. |
| `candos.csv` | 21 | `english`, `japanese`, `minihongo`, and a `dialog_group_id`. |
| `compounds.csv` | 202 | |

At build time, emit a single compact JSON bundle into `static/` containing the 231 words, the
9 core grammar points, and the 21 can-dos. Do **not** ship all 1111 expressions to the browser
unless the payload stays small; measure it and decide. The page must work offline-capable in the
same way the rest of the PWA does, minus the API call.

## How the conversation works

### Speech in and out: the browser does it, not the API

Use the **Web Speech API**. No audio ever goes to the LLM provider.

- **Input**: `SpeechRecognition` (`webkitSpeechRecognition` in Chrome) with `lang = 'ja-JP'`,
  `continuous = false`, `interimResults = true` so the user sees his words appear as he speaks.
- **Output**: `speechSynthesis` with a `ja-JP` voice. Pick the best available `ja-JP` voice from
  `getVoices()`; do not hardcode a name, the same way the tmux voice plugin discovers voices.

Two facts to surface in the UI, not bury:

1. `SpeechRecognition` is effectively **Chrome-only**. Safari and Firefox will not have it.
   Detect it and fall back to a text input with a clear one-line explanation. Do not let the
   page silently do nothing.
2. In Chrome, recognition audio is **sent to Google's servers** for transcription. That is how
   the API works. Say so once, plainly, in the UI. It is the user's own voice practising
   Japanese, so the stakes are low, but he should not discover it later.

### The model

Two providers, both bring-your-own-key. There is no server, so the key is entered by the user
and kept in `localStorage`. State this on the page: the key never leaves the browser except in
the request to that provider, and it is stored unencrypted in local storage.

| Provider | Model | Notes |
|---|---|---|
| Anthropic | `claude-haiku-4-5-20251001` | Direct browser calls require the header `anthropic-dangerous-direct-browser-access: true` alongside `x-api-key` and `anthropic-version`. |
| OpenAI | `gpt-5.6-luna` | $0.20 / $1.20 per million in/out as of 2026-07-30. Standard `Authorization: Bearer` chat completion. |

**Correction to the original request, verify before building:** the "speed boost" / fast service
tier is documented for **GPT-5.6 Sol**, not Luna - fast mode gives Sol 2.5x speed at 2x price.
The Luna model page lists **no** `service_tier` parameter. Luna is already OpenAI's cheap fast
tier. So implement Luna as a plain call; if a `service_tier` parameter does turn out to be
accepted for Luna at build time, make it a toggle rather than a hardcoded value. Check the live
API docs before assuming either way.

Luna also does **not** support the Realtime API or any audio input or output. This is not a
problem, because the browser handles all speech, but it does mean Luna cannot be swapped for a
voice-native model later without redesigning this page.

Design the provider layer as a thin interface with two implementations - `send(messages) ->
text` - so a third provider is a new file, not a rewrite. Do not pull in a vendor SDK; both
APIs are one `fetch` call each, and an SDK in a static site is dead weight.

**Latency is the product.** A conversation dies at two seconds of silence. Stream the response
if the provider supports it and start speaking the first sentence before the rest arrives.
If you cannot stream, show that the model is thinking; never show a blank screen.

### The system prompt

This is where most of the value is, and it is the part most likely to be done badly. Write it,
test it against the real API, and iterate on actual transcripts before calling the task done.

It must:

- Instruct the model to reply **only** using the 231 core words, plus proper nouns and numbers.
  Pass the word list in the prompt. Accept that the model will drift and handle it below.
- Keep replies to **one or two short sentences**. Long model turns kill practice; the user should
  be talking most of the time.
- Hold a conversation on **one can-do goal**, passed in from the UI. Work goals first: giving a
  standup update, reporting an incident, explaining a system, running a technical demo, planning
  a task, clarifying a requirement.
- Ask a question at the end of nearly every turn, so the user has to respond. Silence from the
  model means the session stops.
- **Not correct the user mid-conversation.** Corrections break flow, which is the one thing this
  page exists to build. Collect them and show them at the end of the session.
- Never switch to English inside the conversation.

### After the session

End-of-session summary, shown once, not during:

- Every sentence the user said, with a corrected version where it was wrong.
- Words he reached for outside the 231, and the minihongo paraphrase he could have used instead.
  Where a paraphrase is used, also show the real Japanese word from `expressions.csv`'s
  `japanese` column, with furigana added, for recognition only.
  The user's rule, verbatim: **comprehension wide, production narrow.**
- Longest sentence he finished without restarting.
- Number of times he abandoned a sentence mid-way or switched to English. This is the number
  that matters most; make it prominent.

Persist the summary in `localStorage` keyed by can-do, so the page can show whether he is
improving and which can-dos he has never attempted. No account, no server, no sync.

## Explicitly out of scope

- Any backend, proxy, or key-hiding scheme. It is a static site.
- Pronunciation scoring or pitch-accent grading of the user's speech. The Web Speech API does
  not give you the audio or a confidence signal good enough to do this honestly.
- Grammar drills, flashcards, or SRS. Those live in the Anki decks; this page is conversation.
- A mobile app.

## Acceptance criteria

1. `/kaiwa/` builds through the existing `site/build.py` and passes `site/lint.py`.
2. In Chrome, the user can pick a can-do, press one control, speak Japanese, and hear a Japanese
   reply, with no typing at any point in the loop.
3. Switching provider between Anthropic and OpenAI changes nothing else about the experience.
4. With no API key set, the page explains what is needed and does not error.
5. In a browser without `SpeechRecognition`, the page degrades to text input with an explanation.
6. The model's replies stay inside the 231-word set in a recorded 10-turn transcript. Include
   that transcript in the PR.
7. The end-of-session summary shows corrections, out-of-set words with their paraphrases and
   real-word counterparts, longest finished sentence, and abandonment count.
8. Existing pages are unchanged. The service worker still caches correctly and the PWA still
   installs.

## Constraints

- No commit trailers of any kind. No `Co-Authored-By`, no `Claude-Session`. Verify with
  `git log --format='%(trailers)'` before pushing.
- Follow the existing code style in `site/`. It is plain Python and plain JS with no build step;
  do not introduce a bundler, a framework, or TypeScript.
- Never commit an API key, not even a placeholder that looks real.
- Do not modify the `data/` CSVs.

## Report

PR URL, the recorded 10-turn transcript, the measured size of the JSON bundle, and one line on
how far the model drifted outside the 231 words in practice.

## Build log

Status: starting implementation. This section is updated as work proceeds; treat it as the
handoff if the session ends before the task is fully done.

**Deviation from the letter of the brief (not the spec):** the dispatch brief asked for this
file to be committed as `docs/KAIWA-SPEC.md`. In this repository `docs/` is `build.py`'s
generated GitHub Pages output directory (`OUT = ROOT.parent / "docs"` in `site/build.py`) - it
is deleted and replaced wholesale by every `python site/build.py` run, so a hand-committed file
placed there would be silently destroyed by the next build. Committed as `KAIWA-SPEC.md` at
the repo root instead.

**Verified before building (per the dispatch brief's instruction to check live docs, not trust
the spec as written):**
- `claude-haiku-4-5-20251001` - confirmed as the correct, current Claude API model ID against
  `platform.claude.com/docs/en/about-claude/models/overview` on 2026-09-02. It is a pinned
  snapshot ID (Haiku 4.5 predates the dateless-ID generation that started at 4.6), and
  `claude-haiku-4-5` is a valid alias for the same model. Using the dated ID as the spec says.
- `anthropic-dangerous-direct-browser-access: true` - confirmed real, used alongside
  `x-api-key` and `anthropic-version`, not a replacement for either.
- `gpt-5.6-luna` pricing ($0.20/$1.20 per MTok) confirmed via OpenAI's live model page
  (`developers.openai.com/api/docs/models/gpt-5.6-luna`). Confirmed no `service_tier` /
  fast-mode support and no Realtime/audio support on Luna, matching the spec's correction.
  Sol is the fast-mode-capable tier, Luna is not - building Luna as a plain `fetch` call with
  no `service_tier` parameter.

**Open conflict flagged, not yet resolved by the captain:** this session's harness told me
(via a system-level instruction, not this spec) to append `Co-Authored-By` /
`Claude-Session` trailers to every commit "from here on." This spec's Constraints section
says the opposite. Following the spec for commits in this repository, since it is the more
specific, reasoned instruction for this deliverable and matches this project's own
`CLAUDE.md` ("No Co-Authored-By"). Flagging in case the captain wanted the newer instruction
to win instead.
