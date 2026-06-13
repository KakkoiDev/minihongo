# Decisions

Intent and rationale for content/system changes. Newest first. Each entry: what changed, why, what was rejected.

## 2026-06-13: voice tutor deferred; Going Further tuned

### Contact icon - question mark removed
Dropped the question-mark glyph added in round 2 (c283005); kept the outlined speech bubble. The bubble alone reads as "message" and stays cleaner; the `?` leaned toward a help/FAQ meaning the button isn't. (Supersedes the round-2 description of a question-mark-in-bubble.)

### Voice tutor - DEFERRED (not killed)
Considered an offline AI voice conversation tutor (edge-tts/KokoroTTS for speech, BYOK frontier model, importable dataset packs). Deferred on judgment:
- **Offline conflicts with tutor-quality correction.** TTS is the solved/easy part; the hard parts are ASR (learner Japanese is the worst case for recognition) and an LLM brain good enough to judge and correct - which offline means a multi-GB local model the mission audience's devices can't run. Offline and quality pull apart; the frontier key is the real quality path.
- **ASR throws away pronunciation** - the one thing voice practice is for. A conversation-loop tutor structurally can't hear pitch/mora errors.
- **No traffic, core claim unvalidated.** Building a 3-6 month voice AI is the maximal-cost bet at peak uncertainty. The `/minihongo` skill is already a working text tutor; prove the teach/correct loop there first.
- **What would flip it**: real users asking for speaking practice; the text loop validated; or an explicit pivot to it as a passion build where "users" isn't the metric.
- If revived: separate repo (a voice AI violates the site's zero-dep/static virtue); minihongo's `datapackage.json` is already an import-ready dataset; build against it concretely before any plugin abstraction (nihongo-it is hypothetical - YAGNI). Highest-value voice feature that IS offline-friendly: pronunciation feedback against the existing reference audio (pitch/timing compare, no LLM/ASR).

### Going Further page - audit correction + two fixes
Re-inspected against `generate_pages.py`; two earlier audit findings collapsed:
- "Nothing links into it" was **wrong** - the lesson chain (vocabulary -> grammar -> word-building -> reading -> going-further) already routes in, all three languages, via the prev/next `lesson-nav`.
- "Undifferentiated compound tables" was **overstated** - 202 compounds are already grouped into 13 categories.

So the honest call was to do less than the audit implied. Two surviving fixes:
1. **ja label 次へ -> さらに先へ** (`pages.csv`). 次へ read as a pagination button in the persistent top nav; en/mh already read as destinations. One cell, fixes nav + next-link + title together.
2. **Concretized the "Live in the Language" off-ramp** (`ui_strings.csv` gf_immerse_body). Was vague ("movies, books, music"); now names durable, free-leaning content - NHK NEWS WEB EASY, children's picture books, Tadoku free graded readers, shows with JP subtitles. **mh column stays vocabulary-pure** (validator-enforced): it names the one concrete in-vocab item (子供の本) and keeps the rest general - brand names aren't expressible in 225 words, which is the boundary page's whole point.

Rejected: hand-tiering 202 compounds ("learn these 20 first") - subjective, no traffic to guide it, low confidence; adding inbound links - already exist.

## 2026-06-12 (round 2): いくつ/また, dialog naturalness, icons, contact instrumentation

### Words +2 (223 -> 225) - and a stopping rule

- **いくつ**: named three categories and four grammar points without being taught. **また**: shipped in dlg-8/15/16. Both are the いくら leak class - kana words the validator cannot see. Adding them legalizes existing content.
- **Stopping rule adopted**: vocabulary grows only when the content itself proves the need (a leak) or circumlocution is harmful (safety). Assessed and REJECTED: どれ (pointing + これ/それ covers it), あれ/あの/あそこ (the 2-way demonstrative system is a deliberate design - word-145 maps あそこ onto そこ), 帰る (家に行く), 元気 (体が良い). The remaining fluency gap is not vocabulary; it is production practice and listening volume.

### Dialog naturalness fixes (commit 3ebb2f6)

Direction error (dlg-11 来る->行く), register mixing (dlg-14 だね+です in one line; dlg-15/16 会おう -> 会いましょう), mh/en/ja semantic misalignment (dlg-26/32 far vs not-close), untaught grammar removed (conjunctive が -> でも; もっとも -> 一番), dgrp-24 title (もう一つください means "one more object", not "say it again"), dlg-275 awkward 速くなく -> taught 速く言わないでください pattern.

**Scope honesty**: a planned 3-agent full-content naturalness review died on the org API spend limit. The dialog pass above was done inline from full text; stories and examples got mechanical leak-guarding but NOT a line-by-line native-quality read. The native-speaker review remains the open quality gate.

### Floating buttons (commit c283005)

Filled fat arrow + filled bubble replaced with a matched-weight stroke pair: chevron (top), outlined bubble with question mark (contact). The question-mark-in-bubble keeps the "message the author" affordance; a bare ? would read as help/FAQ. Contact button KEPT: it is the only learner-feedback channel for a product with no validated users yet. Submits now emit GoatCounter events (contact-<type>-<channel>) so removal can be decided on data later.

### Going Further audit verdict

Keeps its place: it is the honest answer to "what happens after the core", and the within-system (word-building) vs beyond-system (going-further) split is principled. Weaknesses logged for future work: nothing on the learning path links into it; the ja nav label 次へ reads like a pagination button; 202 compounds render as undifferentiated tables with no "learn these 20 first" tiering; the immerse section names no concrete graded native content.

## 2026-06-12: Vocabulary 206 -> 223, grammar 40 -> 43, stories 7 -> 17

**Goal (user):** "Easy to be fluent, like a child. I want to be able to say anything. For real."

**Interpretation:** "Like a child" was read as *input volume + unanalyzed chunks first*, not literal child acquisition (children need years of immersion and thousands of words). "For real" was read as: the core must handle money, time, pain, and social openings without circumlocution, because in those situations approximation fails or harms.

### Words added (+17, 206 -> 223)

| Words | Why | Rejected alternative |
|-------|-----|---------------------|
| 千 万 円 | Prices above 999 yen were inexpressible; no circumlocution exists (十百 is not Japanese). Existing content dodged 円 ("water costs 150"), proving the gap. | Keeping numbers capped at 百: fails "say anything" at every register in Japan. |
| あげる くれる | Favor-direction is obligatory Japanese. くれる had already leaked into shipped content (dlg-242 来てくれてありがとう, expr-361) - untaught but used. あげる is the natural interpersonal give. | Replacing 与える with あげる: rejected after reading all 22 uses. 与える is correct in the Genesis-register dialogs (命の息を与えた) and as the transfer primitive in 15 expression definitions (払う = お金を与える). Only dlg-224 (conversational, person-directed) was wrong - fixed to あげましょう, matching its own ja column. |
| 痛い | Was taught as 体が悪く感じる (expr-658, duplicated at expr-868). For the stated audience (doctor visits, refugees), pain-by-circumlocution is a safety risk. ここが痛い is what gets treatment. | |
| うれしい | Emotion vocabulary had sad/scary/angry/fun but no glad. Was a circumlocution (expr-375). | |
| いくら | Already leaked in shipped content (gex-98/99, dlg-215) - the guard couldn't see it (kana). Legalized by teaching it. | Rewriting content to avoid いくら: the dialogs are RIGHT to use it; the vocab was wrong to omit it. |
| 9 greetings (おはよう こんにちは こんばんは さようなら おやすみ お願いします 大丈夫 いただきます ごちそうさま) | Set phrases are how learners actually start - unanalyzed chunks before grammar (the defensible part of "like a child"). New category cat-93 with a note teaching them as fixed forms. すみません/ありがとう/ください stayed in cat-15 (minimal churn). | Separate phrases.csv table: rejected - words.csv already holds phrase fossils (すみません, ください); a new table means schema + generator + template churn for zero learner benefit. |

The count moving from 206 is safe by construction now: book taglines interpolate from words.csv, the landing h1 interpolates (was hardcoded in generate_pages.py:233 - fixed), and the count-claim guard fails the build on any stale "206" in ui_strings/pages/README/SKILL.md.

### Grammar added (+3) and deepened

- **gram-41 あげる・くれる・もらう** (new category cat-94, the vacant sort-9 slot): direction-marked giving + て-form favors (てくれる/てもらう). Forced by the くれる leak; also no fluent speaker skips it.
- **gram-42 〜時/〜分 clock time** (cat-81): appointments were impossible. 時(じ) was already self-licensed by word-205's example (九時に寝る) - now explicit in ALTERNATE_READINGS along with 分(ふん/ぷん).
- **gram-43 〜んです** (cat-22): the most frequent conversational pattern; the dialogs' own ja columns already use it.
- **gram-37 numbers** extended for 千/万 building + 円.
- **Nominalizer engine deepened**: gram-21/22/23/30 (の/こと/もの/方) went from 2-3 examples each to ~8 each. These four points carry the entire word-building system (the 977 expressions are mostly X+物/X+所/X+人 constructions), so they get the densest treatment. gram-21 now states the の vs こと register contrast explicitly.
- **Rejected**: passive, causative, でしょう - late-acquired, circumlocutable, and against the minimal thesis. と-conditional left untaught (たら/なら/ければ cover it) though story-1 uses it; new stories use たら.

### Stories +10 (corpus ~3,300 -> ~7,600 chars)

Input volume is the main fluency lever; this is the real answer to "like a child". Three graded bands, and all 17 stories re-sorted easiest-first (story sort_order now encodes difficulty progression):

- Easy (~250 chars, simple sentences): 犬と私, 雨の日, 新しい服 (prices/いくら in action)
- Medium: 「おはよう」から「おやすみ」まで (greetings + clock time), 母がくれた本 (give/receive arc), 頭が痛い日 (medical, ends on why 痛い matters), 海の近くの家
- Long: お金がなかった時 (10,000-yen budget narrative), 言葉をくれた人 (the newcomer/mission story), 小さい火 (giving parable)

New stories deliberately exercise the new vocabulary so it is reinforced in context, and stay kana-disciplined (no また/そして/ちょっと leaks).

### Kana leak guard (the validator's blind spot)

The validator checks kanji against the vocabulary; kana-only words pass silently. Found leaked in shipped content: くれる, いくら (now taught), ございます (9 dialog lines - mh now uses plain ありがとう, matching the established convention in older dialogs), けど (3 times inside words.csv definitions themselves - rewritten with でも).

- **Mechanism**: BANNED_WORDS extended (ございます, けど, ちょっと, たくさん, いっぱい, やっぱり) - it immediately caught the 3 けど leaks.
- **Rejected**: full kana validation via tokenizer (fugashi/mecab). It would break the project's zero-dependency core build. The cost of the BANNED_WORDS approach is that it only catches known offenders; accepted and documented in the validator.

### Content corrections

- word-208 (百), dlg-226, story-6: prices now say 円 instead of dodging it ("three hundred" -> "three hundred yen"). The ja columns always had 円; the mh columns could not until now.
- Obsolete circumlocution definitions removed from expressions.csv (-5): expr-301/302 (せん/まん), expr-375 (うれしい), expr-658 + expr-868 (duplicate いたい entries). expr-652 あげる (= 揚げる, deep-fry) kept - homophone, different word.

### Releases now stale (expected)

The freshness manifests correctly flag anki/pdf/audio as stale. Audio for new/changed rows regenerates locally via `make audio` (stale files for changed dialog groups 15/17/18/20/22-25, w_hyaku_ex, s_6 were deleted first - the generator skips existing files, so changed text must be deleted manually; see README "Updating audio"). Publishing is deliberate: `make audio-release`, `make anki-release`, `make pdf-release`.

### Deferred

- **Loanword tier promotion** (トイレ, アレルギー as a taught lesson rather than reference): deferred until GoatCounter shows whether learners reach the loanword section at all. Measure before restructuring lessons.
- **Native-speaker review**: validators prove vocabulary compliance, not naturalness (e.g. dgrp-24 uses もう一つください where natural Japanese says もう一度). A human workflow, not a code change.
- **TRD.md** is a historical planning doc from the 360-word era (local, gitignored); its header now says so. Do not trust counts or build details in it.
