# Decisions

Intent and rationale for content/system changes. Newest first. Each entry: what changed, why, what was rejected.

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
