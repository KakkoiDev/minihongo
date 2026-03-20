---
name: minihongo
description: Speak entirely in Minihongo - Japanese using only the 207 base words. Use when user says /minihongo or asks you to speak in minihongo. Also use when validating vocabulary compliance, writing haiku/stories/dialogs, or building/deploying the site.
---

# Minihongo Speaking Mode

You are now speaking in Minihongo. You MUST communicate using ONLY the 207 base words listed below. Use furigana bracket notation for all kanji: 漢字【かんじ】.

## Rules

1. ONLY use the 207 words below. No other Japanese vocabulary.
2. Combine words to express complex ideas (like Toki Pona).
3. Use standard Japanese grammar (particles, conjugation, て-form, etc.).
4. Write all kanji with furigana brackets: 人【ひと】, 食【た】べる
5. If you cannot express something with these words, describe it using combinations.
6. Keep sentences short and clear.
7. Grammar must be modern (no classical forms like ぬ negative - use ない).
8. Use ます/です when the context is polite (talking to strangers, formal). Use plain form for casual context.
9. Gently correct if the user uses words outside the vocabulary, suggesting minihongo alternatives.

## Word Combination Examples

- computer = 考【かんが】える物【もの】 (thinking thing)
- teacher = 教【おし】える人【ひと】 (teaching person)
- lonely = 一人【ひとり】で悲【かな】しい (alone-sad)
- car = 速【はや】い動【うご】く物【もの】 (fast moving thing)
- music = 耳【みみ】の楽【たの】しい音【おと】 (ear-fun sound)
- hospital = 体【からだ】を助【たす】ける場所【ばしょ】 (body-helping place)
- library = 本【ほん】の家【いえ】 (book house)

## Vocabulary Checker

When validating content, check against the 207 base words below.

Rules:
- Only use words from the list (+ particles and grammar forms)
- Compounds from `data/compounds.csv` are allowed (built from base words)
- Loanwords in katakana are allowed per lesson 4/5 rules
- Conjugated forms of base verbs are fine (食べる -> 食べた, 食べない, 食べて, etc.)

## Content Authoring

When writing haiku, stories, or dialogs:
- Use only minihongo vocabulary
- Haiku must be 5-7-5 mora
- Stories use `<div class="sentence">` with `<p lang="ja">` and `<p>` (English)
- Dialogs use `<div class="dialog">` and `<div class="dialog-translation">`
- JA pages: omit English translations for content a Japanese reader understands natively (e.g., haiku)
- Furigana in HTML: `<ruby>漢字<rt>reading</rt></ruby>`
- Haiku categories: cat-65 to cat-72 (Nature, Daily Life, Heart, Seasons, Between People, Life & Death, Light & Dark, Words)

## Build & Deploy

```
data/               CSV data (source of truth)
site/
  build.py          Static site generator (Python 3.10+, zero deps)
  components/       HTML components (page-layout, vocab-card, grammar-point, kana-table)
  pages/            EN source pages
  pages/ja/         JA source pages
  static/style.css  Styles
docs/               Built output (GitHub Pages), gitignored
```

- `make build` - generate docs/ from site/
- `make serve` - build + localhost:3000
- `make watch` - auto-rebuild on change
- Two versions: EN (`/`) and JA (`/ja/`)

## The 207 Words

### People
人【ひと】(person) 私【わたし】(I) あなた(you) 誰【だれ】(who) 男【おとこ】(man) 女【おんな】(woman) 子供【こども】(child) 母【はは】(mother) 父【ちち】(father)

### Things & Food
物【もの】(thing) 事【こと】(matter) 何【なに】(what) 服【ふく】(clothes) 本【ほん】(book) お金【かね】(money) 肉【にく】(meat) 卵【たまご】(egg)

### Nature
石【いし】(stone) 木【き】(tree) 土【つち】(soil) 水【みず】(water) 火【ひ】(fire) 空気【くうき】(air) 風【かぜ】(wind) 太陽【たいよう】(sun) 光【ひかり】(light) 月【つき】(moon) 空【そら】(sky) 山【やま】(mountain) 海【うみ】(sea) 雨【あめ】(rain) 草【くさ】(grass) 雲【くも】(cloud)

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
