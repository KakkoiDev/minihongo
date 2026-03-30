---
name: minihongo
description: Speak entirely in Minihongo - Japanese using only the 206 base words. Use when user says /minihongo or asks you to speak in minihongo. Also use when validating vocabulary compliance, writing haiku/stories/dialogs, or building/deploying the site.
---

# Minihongo Skill

206 words. Infinite expression. A minimal Japanese vocabulary system.

## Speaking Mode

When practicing minihongo conversation, you MUST communicate using ONLY the 206 base words listed below. Use furigana bracket notation for all kanji: 漢字【かんじ】.

Rules:
1. ONLY use the 206 words below. No other Japanese vocabulary.
2. Combine words to express complex ideas (like Toki Pona).
3. Use standard Japanese grammar (particles, conjugation, て-form, etc.).
4. Write all kanji with furigana brackets: 人【ひと】, 食【た】べる
5. If you cannot express something with these words, describe it using combinations.
6. Keep sentences short and clear.
7. Grammar must be modern (no classical forms like ぬ negative - use ない).
8. Use ます/です when the context is polite (talking to strangers, formal). Use plain form for casual context.
9. Gently correct if the user uses words outside the vocabulary, suggesting minihongo alternatives.

Word combination examples:
- computer = 考【かんが】える物【もの】 (thinking thing)
- teacher = 教【おし】える人【ひと】 (teaching person)
- lonely = 一人【ひとり】で悲【かな】しい (alone-sad)
- car = 速【はや】い動【うご】く物【もの】 (fast moving thing)
- music = 耳【みみ】の楽【たの】しい音【おと】 (ear-fun sound)
- hospital = 体【からだ】を助【たす】ける場所【ばしょ】 (body-helping place)
- library = 本【ほん】の家【いえ】 (book house)

## Install

```sh
# Symlink skill into Claude Code
ln -sf "$(pwd)/.claude/skills/minihongo" ~/.claude/skills/minihongo
```

## Project Structure

```
data/               CSV data (source of truth)
  words.csv         206 base words
  grammar.csv       40 grammar points
  compounds.csv     202 compound words
  expressions.csv   982 expressions
  haiku.csv         40 haiku
  stories.csv       7 short stories
  dialogs.csv       212 dialog lines
  dialog_groups.csv Dialog groupings
  categories.csv    Category tree
  pages.csv         Page definitions (EN/JA/MH descriptions)
  ui_strings.csv    UI translations
site/
  build.py          Static site generator (Python 3.10+, zero deps)
  components/       HTML components (page-layout, grammar-point)
  pages/            EN source pages
  pages/ja/         JA source pages
  pages/mh/         MH (minihongo) source pages
  static/style.css  Styles
docs/               Built output (GitHub Pages), gitignored
*.py                Build/validation scripts at project root
```

## Build Commands

| Command | Purpose |
|---------|---------|
| `make build` | Generate pages + build site (`generate_pages.py` then `site/build.py`) |
| `make serve` | Build + serve on localhost:3000 |
| `make watch` | Build + serve + auto-rebuild on file changes |
| `make lint-haiku` | Validate haiku mora counts (`validate_haiku.py`) |
| `make lint-vocab` | Validate vocabulary compliance (`validate_vocab.py`) |
| `make audio` | Generate audio with edge-tts + ffmpeg (`generate_audio.py`) |
| `make anki` | Build Anki decks (`generate_anki.py`, requires genanki + audio/) |
| `make anki-restyle` | Rebuild decks with new model IDs + release (resets Anki progress) |
| `make pdf` | Generate PDF books with Typst (`uv run generate_pdf.py`) |
| `make pdf-print` | Print-ready PDFs: interior + wraparound cover (for Lulu) |
| `make deploy` | Trigger GitHub Pages deploy |

## Vocabulary Checker

When validating content, check against `data/words.csv` (206 base words).

Rules:
- Only use words from the 206-word list (+ particles and grammar forms)
- Grammar must be modern (no classical forms)
- Compounds from `data/compounds.csv` are allowed (built from base words)
- Loanwords in katakana are allowed per lesson rules
- Conjugated forms of base verbs are fine (食べる -> 食べた, 食べない, 食べて, etc.)
- Run `make lint-vocab` to validate programmatically

Word format in CSV: `漢字【reading】` (e.g., `人【ひと】`, `食【た】べる`)

## Content Authoring

When writing haiku, stories, or dialogs:
- Use only minihongo vocabulary
- Haiku must be 5-7-5 mora. Validate with `make lint-haiku`
- Stories use `<div class="sentence">` with `<p lang="ja">` and `<p>` (English)
- Dialogs use `<div class="dialog">` and `<div class="dialog-translation">`
- JA pages: omit English translations for content a Japanese reader understands natively
- Furigana: `<ruby>漢字<rt>reading</rt></ruby>`

Haiku categories (under cat-78): Nature, Daily Life, Heart, Seasons, Between People, Life & Death, Light & Dark, Words

## Build & Deploy

- `make build` runs `generate_pages.py` (CSV -> HTML) then `site/build.py` (assemble site)
- Site uses htmz for partial page loads
- Service worker for offline support
- GitHub Pages deployment via `.github/workflows/deploy.yml`
- Three versions: EN (`/`), JA (`/ja/`), MH (`/mh/`)
- `data/` CSVs are the source of truth, HTML pages render from them
- Outputs: website (docs/), Anki decks (.apkg), PDF books (.pdf), audio (.mp3)

## Grammar Reference (40 points)

Core patterns from `data/grammar.csv`:
- Word order: verb last, particles mark roles
- Omission: drop known subjects/objects
- ある/いる: existence is possession
- Four verb forms: る/た/ない/なかった
- て-form: universal connector
- Polite form: ます/です (cat-80)
- Particles: は が を に で の と も から まで より
- い-adjectives conjugate, な-adjectives use な/じゃない/だった
- Nominalizers: の (casual), こと (abstract), もの (concrete), 方 (method)
- Conditionals: たら (if/when), なら (if it's the case)
- と思う/と言う for quotation
- か/ね/よ sentence enders
- Question words + も/でも = pronouns
- Numbers and counting (cat-81)

## The 206 Words

### People
人【ひと】(person) 私【わたし】(I) あなた(you) 誰【だれ】(who) 男【おとこ】(man) 女【おんな】(woman) 子供【こども】(child) 母【はは】(mother) 父【ちち】(father)

### Things & Food
物【もの】(thing) 事【こと】(matter) 何【なに】(what) 服【ふく】(clothes) 本【ほん】(book) お金【かね】(money) 肉【にく】(meat) 卵【たまご】(egg)

### Nature
石【いし】(stone) 木【き】(tree) 土【つち】(soil) 水【みず】(water) 火【ひ】(fire) 風【かぜ】(wind) 太陽【たいよう】(sun) 光【ひかり】(light) 月【つき】(moon) 空【そら】(sky) 山【やま】(mountain) 海【うみ】(sea) 雨【あめ】(rain) 草【くさ】(grass) 雲【くも】(cloud)

### Animals
動物【どうぶつ】(animal) 魚【さかな】(fish) 鳥【とり】(bird) 犬【いぬ】(dog)

### Body
体【からだ】(body) 頭【あたま】(head) 手【て】(hand) 足【あし】(foot) 目【め】(eye) 口【くち】(mouth) 耳【みみ】(ear) 鼻【はな】(nose) 心【こころ】(heart/mind) 歯【は】(tooth) 血【ち】(blood) 骨【ほね】(bone) 腹【はら】(belly) 髪【かみ】(hair) 皮【かわ】(skin)

### Verbs
する(do) いる(exist-animate) ある(exist/have) なる(become) できる(can) 起【お】こる(happen) 行【い】く(go) 来【く】る(come) 動【うご】く(move) 入【はい】る(enter) 出【で】る(exit) 止【と】める(stop) 作【つく】る(make) 使【つか】う(use) 切【き】る(cut) 食【た】べる(eat) 飲【の】む(drink) 寝【ね】る(sleep) 着【き】る(wear) 座【すわ】る(sit) 立【た】つ(stand) 生【い】きる(live) 死【し】ぬ(die) 始【はじ】まる(begin) 終【お】わる(end) 開【あ】く(open) 閉【し】める(close) 変【か】わる(change) 与【あた】える(give) もらう(receive) 持【も】つ(hold) 会【あ】う(meet) 待【ま】つ(wait) 助【たす】ける(help) 守【まも】る(protect) 戦【たたか】う(fight) 選【えら】ぶ(choose) 探【さが】す(search) 買【か】う(buy) 言【い】う(say) 書【か】く(write) 読【よ】む(read) 教【おし】える(teach) 考【かんが】える(think) 笑【わら】う(laugh) 泣【な】く(cry) 分【わ】かる(understand) 話【はな】す(talk) 歩【ある】く(walk) 飛【と】ぶ(fly)

### Qualities
良【よ】い(good) 悪【わる】い(bad) 大【おお】きい(big) 小【ちい】さい(small) 長【なが】い(long) 高【たか】い(tall/expensive) 重【おも】い(heavy) 変【へん】(strange) きれい(clean/pretty) 強【つよ】い(strong) 楽【たの】しい(fun) 違【ちが】う(different) 同【おな】じ(same) 他【ほか】(other) 新【あたら】しい(new) 速【はや】い(fast) 多【おお】い(many) 暑【あつ】い(hot) 寒【さむ】い(cold) 本当【ほんとう】(true)

### Colors
色【いろ】(color) 白【しろ】(white) 黒【くろ】(black) 赤【あか】(red) 青【あお】(blue) 黄色【きいろ】(yellow) 緑【みどり】(green) 明【あか】るい(bright)

### Mental & Senses
知【し】る(know) 感【かん】じる(feel) 見【み】る(see) 聞【き】く(hear) 思【おも】う(think/opinion) 欲【ほ】しい(want) 必要【ひつよう】(necessary) 好【す】き(like) 怖【こわ】い(scary) 悲【かな】しい(sad) 怒【おこ】る(angry)

### Communication
言葉【ことば】(word) 名前【なまえ】(name) 音【おと】(sound)

### Time
時【とき】(time/when) 今【いま】(now) 前【まえ】(before) 後【あと】(after) 毎【まい】(every) 日【にち】(day) 年【とし】(year) 夜【よる】(night)

### Places & Space
国【くに】(country) 所【ところ】(place) 外【そと】(outside) 道【みち】(road) 家【いえ】(home) 上【うえ】(up) 下【した】(down) 中【なか】(inside) 右【みぎ】(right) 左【ひだり】(left) 近【ちか】い(near) 遠【とお】い(far) ここ(here) そこ(there) どこ(where)

### Connectors
全部【ぜんぶ】(all) と(and) または(or) でも(but) から(from/because) まで(until) なら(if) だけ(only) も(also) もっと(more) もう(already) まだ(still) とても(very) 少【すこ】し(a little) 方【かた】(way/method) たぶん(maybe)

### Responses & Questions
ない(not) はい(yes) いいえ(no) すみません(excuse me) ありがとう(thank you) ください(please) どう(how) いつ(when) なぜ(why) これ(this) それ(that) この(this+noun) その(that+noun)

### Numbers
一【いち】(one) 二【に】(two) 三【さん】(three) 四【よん】(four) 五【ご】(five) 六【ろく】(six) 七【なな】(seven) 八【はち】(eight) 九【きゅう】(nine) 十【じゅう】(ten) 百【ひゃく】(hundred)
