#import "template.typ": *

#show: book.with(title: "Minihongo", lang: "en", print: false)

#cover-page("Minihongo", "206 words. Say anything.", "/site/static/logo.svg")
#pagebreak()

#outline(title: none, indent: 1.5em, depth: 3)
#pagebreak()

= Vocabulary

== #ruby[ひと][人]と#ruby[だれ][誰] (Pronouns & People)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[ひと][人]], [person, people], [あの#ruby[ひと][人]は#ruby[だれ][誰]？],
  [#ruby[わたし][私]], [I, me], [#ruby[わたし][私]は#ruby[ひと][人]だ。],
  [あなた], [you], [あなたは#ruby[だれ][誰]？],
  [#ruby[だれ][誰]], [who], [#ruby[だれ][誰]が#ruby[く][来]る？],
  [#ruby[おとこ][男]], [man, male], [あの#ruby[おとこ][男]は#ruby[おお][大]きい。],
  [#ruby[おんな][女]], [woman, female], [あの#ruby[おんな][女]は#ruby[はは][母]だ。],
  [#ruby[こども][子供]], [child], [#ruby[こども][子供]は#ruby[そと][外]で#ruby[はし][走]る。],
  [#ruby[はは][母]], [mother], [#ruby[はは][母]は#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る。],
  [#ruby[ちち][父]], [father], [#ruby[ちち][父]は#ruby[やま][山]に#ruby[い][行]く。],
)]

== #ruby[もの][物]と#ruby[た][食]べ#ruby[もの][物] (Things & Food)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[もの][物]], [thing (concrete)], [この#ruby[もの][物]は#ruby[なん][何]だ？],
  [#ruby[こと][事]], [thing (abstract), matter], [その#ruby[こと][事]は#ruby[ひつよう][必要]だ。],
  [#ruby[なに][何]], [what], [#ruby[なに][何]を#ruby[た][食]べる？],
  [#ruby[ふく][服]], [clothes], [#ruby[あたら][新]しい#ruby[ふく][服]を#ruby[き][着]る。],
  [#ruby[ほん][本]], [book], [#ruby[ほん][本]を#ruby[よ][読]む。],
  [お#ruby[かね][金]], [money], [お#ruby[かね][金]で#ruby[た][食]べ#ruby[もの][物]を#ruby[か][買]う。],
  [#ruby[にく][肉]], [meat], [#ruby[にく][肉]を#ruby[た][食]べる。],
  [#ruby[たまご][卵]], [egg], [#ruby[たまご][卵]を#ruby[た][食]べる。],
)]

== #ruby[そと][外]の#ruby[もの][物] (Nature)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[いし][石]], [stone], [#ruby[みち][道]に#ruby[いし][石]がある。],
  [#ruby[き][木]], [tree, wood], [#ruby[やま][山]に#ruby[き][木]がある。],
  [#ruby[つち][土]], [soil, earth], [#ruby[つち][土]の#ruby[なか][中]に#ruby[くさ][草]がある。],
  [#ruby[みず][水]], [water], [#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[ひ][火]], [fire], [#ruby[ひ][火]は#ruby[あつ][暑]い。],
  [#ruby[かぜ][風]], [wind], [#ruby[そと][外]は#ruby[かぜ][風]が#ruby[つよ][強]い。],
  [#ruby[たいよう][太陽]], [sun], [#ruby[たいよう][太陽]は#ruby[そら][空]にある。],
  [#ruby[ひかり][光]], [light], [#ruby[たいよう][太陽]の#ruby[ひかり][光]が#ruby[み][見]える。],
  [#ruby[つき][月]], [moon], [#ruby[よる][夜]、#ruby[つき][月]が#ruby[み][見]える。],
  [#ruby[そら][空]], [sky], [#ruby[そら][空]が#ruby[あお][青]い。],
  [#ruby[やま][山]], [mountain], [#ruby[やま][山]に#ruby[い][行]く。],
  [#ruby[うみ][海]], [sea], [#ruby[うみ][海]はとても#ruby[おお][大]きい。],
  [#ruby[あめ][雨]], [rain], [#ruby[あめ][雨]の#ruby[にち][日]は#ruby[そと][外]に#ruby[い][行]かない。],
  [#ruby[くさ][草]], [grass], [#ruby[くさ][草]が#ruby[みどり][緑]だ。],
  [#ruby[くも][雲]], [cloud], [#ruby[そら][空]に#ruby[くも][雲]がある。],
)]

== #ruby[どうぶつ][動物] (Animals)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[どうぶつ][動物]], [animal], [#ruby[どうぶつ][動物]が#ruby[す][好]きだ。],
  [#ruby[さかな][魚]], [fish], [#ruby[うみ][海]に#ruby[さかな][魚]がいる。],
  [#ruby[とり][鳥]], [bird], [#ruby[とり][鳥]が#ruby[そら][空]を#ruby[と][飛]ぶ。],
  [#ruby[いぬ][犬]], [dog], [#ruby[いぬ][犬]が#ruby[いえ][家]にいる。],
)]

== #ruby[からだ][体] (Body Parts)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[からだ][体]], [body], [#ruby[からだ][体]が#ruby[つよ][強]い。],
  [#ruby[あたま][頭]], [head], [#ruby[あたま][頭]で#ruby[かんが][考]える。],
  [#ruby[て][手]], [hand], [#ruby[て][手]で#ruby[もの][物]を#ruby[も][持]つ。],
  [#ruby[あし][足]], [foot, leg], [#ruby[あし][足]で#ruby[うご][動]く。],
  [#ruby[め][目]], [eye], [#ruby[め][目]で#ruby[み][見]る。],
  [#ruby[くち][口]], [mouth], [#ruby[くち][口]で#ruby[た][食]べる。],
  [#ruby[みみ][耳]], [ear], [#ruby[みみ][耳]で#ruby[き][聞]く。],
  [#ruby[はな][鼻]], [nose], [#ruby[はな][鼻]から#ruby[かぜ][風]が#ruby[はい][入]る。],
  [#ruby[こころ][心]], [heart, mind], [#ruby[こころ][心]が#ruby[あたた][温]かい#ruby[ひと][人]だ。],
  [#ruby[は][歯]], [tooth], [#ruby[は][歯]で#ruby[た][食]べ#ruby[もの][物]を#ruby[き][切]る。],
  [#ruby[ち][血]], [blood], [#ruby[て][手]から#ruby[ち][血]が#ruby[で][出]る。],
  [#ruby[ほね][骨]], [bone], [#ruby[ほね][骨]が#ruby[つよ][強]い。],
  [#ruby[はら][腹]], [belly, stomach], [#ruby[はら][腹]に#ruby[た][食]べ#ruby[もの][物]がない。],
  [#ruby[かみ][髪]], [hair], [#ruby[かみ][髪]が#ruby[なが][長]い。],
  [#ruby[かわ][皮]], [skin], [#ruby[かわ][皮]が#ruby[あか][赤]い。],
)]

== する#ruby[こと][事] (Verbs)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [する], [do], [#ruby[なに][何]をする？],
  [いる], [exist (animate)], [#ruby[どうぶつ][動物]が#ruby[やま][山]にいる。],
  [ある], [exist (inanimate), have], [#ruby[ほん][本]が#ruby[いえ][家]にある。],
  [なる], [become], [#ruby[おお][大]きくなる。],
  [#ruby[お][起]こる], [happen], [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こる。],
  [#ruby[い][行]く], [go], [#ruby[やま][山]に#ruby[い][行]く。],
  [#ruby[く][来]る], [come], [#ruby[ひと][人]が#ruby[いえ][家]に#ruby[く][来]る。],
  [#ruby[うご][動]く], [move], [#ruby[どうぶつ][動物]が#ruby[うご][動]く。],
  [#ruby[はい][入]る], [enter], [#ruby[いえ][家]に#ruby[はい][入]る。],
  [#ruby[で][出]る], [exit], [#ruby[いえ][家]から#ruby[で][出]る。],
  [#ruby[と][止]める], [stop], [#ruby[うご][動]きを#ruby[と][止]める。],
  [#ruby[つく][作]る], [make], [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る。],
  [#ruby[つか][使]う], [use], [#ruby[もの][物]を#ruby[つか][使]う。],
  [#ruby[き][切]る], [cut], [#ruby[き][木]を#ruby[き][切]る。],
  [#ruby[た][食]べる], [eat], [#ruby[よる][夜]に#ruby[た][食]べる。],
  [#ruby[の][飲]む], [drink], [#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[ね][寝]る], [sleep], [#ruby[よる][夜]に#ruby[ね][寝]る。],
  [#ruby[き][着]る], [wear], [#ruby[ふく][服]を#ruby[き][着]る。],
  [#ruby[すわ][座]る], [sit], [#ruby[いえ][家]で#ruby[すわ][座]る。],
  [#ruby[た][立]つ], [stand], [#ruby[そと][外]で#ruby[た][立]つ。],
  [#ruby[い][生]きる], [live], [#ruby[どうぶつ][動物]は#ruby[みず][水]で#ruby[い][生]きる。],
  [#ruby[し][死]ぬ], [die], [#ruby[くさ][草]が#ruby[し][死]ぬ。],
  [#ruby[はじ][始]まる], [begin], [#ruby[にち][日]が#ruby[はじ][始]まる。],
  [#ruby[お][終]わる], [end], [#ruby[にち][日]が#ruby[お][終]わる。],
  [#ruby[あ][開]く], [open], [#ruby[め][目]が#ruby[あ][開]く。],
  [#ruby[し][閉]める], [close], [#ruby[め][目]を#ruby[し][閉]める。],
  [#ruby[か][変]わる], [change (intransitive)], [#ruby[そら][空]の#ruby[いろ][色]が#ruby[か][変]わる。],
  [#ruby[あた][与]える], [give], [#ruby[どうぶつ][動物]に#ruby[た][食]べ#ruby[もの][物]を#ruby[あた][与]える。],
  [もらう], [receive], [#ruby[ひと][人]から#ruby[ほん][本]をもらう。],
  [#ruby[も][持]つ], [have, hold], [#ruby[ほん][本]を#ruby[も][持]つ。],
  [#ruby[あ][会]う], [meet], [#ruby[ひと][人]に#ruby[あ][会]う。],
  [#ruby[ま][待]つ], [wait], [#ruby[ひと][人]を#ruby[ま][待]つ。],
  [#ruby[たす][助]ける], [help], [#ruby[ひと][人]を#ruby[たす][助]ける。],
  [#ruby[まも][守]る], [protect], [#ruby[こども][子供]を#ruby[まも][守]る。],
  [#ruby[たたか][戦]う], [fight], [#ruby[ひつよう][必要]な#ruby[もの][物]のために#ruby[たたか][戦]う。],
  [#ruby[えら][選]ぶ], [choose], [#ruby[た][食]べ#ruby[もの][物]を#ruby[えら][選]ぶ。],
  [#ruby[さが][探]す], [search], [#ruby[みち][道]を#ruby[さが][探]す。],
  [#ruby[か][買]う], [buy], [#ruby[た][食]べ#ruby[もの][物]を#ruby[か][買]う。],
  [#ruby[い][言]う], [say], [#ruby[なまえ][名前]を#ruby[い][言]う。],
  [#ruby[か][書]く], [write], [#ruby[ほん][本]に#ruby[か][書]く。],
  [#ruby[よ][読]む], [read], [#ruby[ほん][本]を#ruby[よ][読]む。],
  [#ruby[おし][教]える], [teach], [#ruby[ひと][人]に#ruby[ことば][言葉]を#ruby[おし][教]える。],
  [#ruby[かんが][考]える], [think], [#ruby[こと][事]を#ruby[かんが][考]える。],
  [#ruby[わら][笑]う], [laugh], [#ruby[ひと][人]と#ruby[わら][笑]う。],
  [#ruby[な][泣]く], [cry], [#ruby[こども][子供]が#ruby[な][泣]く。],
  [できる], [can, be able], [これは#ruby[ひと][一]りでできる。],
  [#ruby[わ][分]かる], [understand], [この#ruby[ことば][言葉]が#ruby[わ][分]からない。],
  [#ruby[はな][話]す], [talk], [#ruby[ひと][人]と#ruby[はな][話]すのが#ruby[す][好]きだ。],
  [#ruby[ある][歩]く], [walk], [#ruby[いえ][家]まで#ruby[ある][歩]く。],
  [#ruby[と][飛]ぶ], [fly], [#ruby[とり][鳥]が#ruby[と][飛]ぶ。],
)]

== どんな (Qualities)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[あつ][暑]い], [hot (weather)], [#ruby[そと][外]は#ruby[あつ][暑]い。],
  [#ruby[さむ][寒]い], [cold (weather)], [#ruby[そと][外]は#ruby[さむ][寒]い。],
  [#ruby[よ][良]い], [good], [この#ruby[ほん][本]は#ruby[よ][良]い。],
  [#ruby[わる][悪]い], [bad], [#ruby[そら][空]が#ruby[わる][悪]い。],
  [#ruby[おお][大]きい], [big], [あの#ruby[やま][山]は#ruby[おお][大]きい。],
  [#ruby[なが][長]い], [long], [この#ruby[みち][道]は#ruby[なが][長]い。],
  [#ruby[たか][高]い], [high, tall, expensive], [この#ruby[おお][大]きい#ruby[いえ][家]は#ruby[たか][高]い。],
  [#ruby[おも][重]い], [heavy], [この#ruby[いし][石]は#ruby[おも][重]い。],
  [#ruby[へん][変]], [strange], [この#ruby[おと][音]は#ruby[へん][変]だ。],
  [きれい], [clean, pretty], [この#ruby[やま][山]はきれいだ。],
  [#ruby[つよ][強]い], [strong], [あの#ruby[ひと][人]は#ruby[つよ][強]い。],
  [#ruby[たの][楽]しい], [fun], [#ruby[ひと][人]と#ruby[あ][会]うのは#ruby[たの][楽]しい。],
  [#ruby[ちが][違]う], [different], [この#ruby[いろ][色]は#ruby[ちが][違]う。],
  [#ruby[ほか][他]], [other], [#ruby[ほか][他]の#ruby[ひと][人]に#ruby[き][聞]く。],
  [#ruby[あたら][新]しい], [new], [#ruby[あたら][新]しい#ruby[ほん][本]を#ruby[か][買]う。],
  [#ruby[はや][速]い], [fast], [あの#ruby[どうぶつ][動物]は#ruby[はや][速]い。],
  [#ruby[おお][多]い], [many], [ここは#ruby[ひと][人]が#ruby[おお][多]い。],
  [#ruby[ほんとう][本当]], [true, real], [#ruby[ほんとう][本当]か？],
  [#ruby[ちい][小]さい], [small], [この#ruby[いし][石]は#ruby[ちい][小]さい。],
  [#ruby[おな][同]じ], [same], [#ruby[わたし][私]とあなたは#ruby[おな][同]じ#ruby[もの][物]を#ruby[た][食]べた。],
)]

== #ruby[いろ][色] (Colors)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[いろ][色]], [color], [この#ruby[そら][空]の#ruby[いろ][色]はきれいだ。],
  [#ruby[しろ][白]], [white], [この#ruby[いし][石]は#ruby[しろ][白]い。],
  [#ruby[くろ][黒]], [black], [その#ruby[そら][空]は#ruby[くろ][黒]い。],
  [#ruby[あか][赤]], [red], [#ruby[ひ][火]は#ruby[あか][赤]い。],
  [#ruby[あお][青]], [blue], [#ruby[そら][空]は#ruby[あお][青]い。],
  [#ruby[きいろ][黄色]], [yellow], [この#ruby[ひかり][光]は#ruby[きいろ][黄色]い。],
  [#ruby[みどり][緑]], [green], [#ruby[くさ][草]は#ruby[みどり][緑]だ。],
  [#ruby[あか][明]るい], [bright], [#ruby[そと][外]は#ruby[あか][明]るい。],
)]

== #ruby[こころ][心]と#ruby[かん][感]じ (Mental & Senses)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[し][知]る], [know], [その#ruby[なまえ][名前]を#ruby[し][知]っている。],
  [#ruby[かん][感]じる], [feel], [#ruby[かぜ][風]を#ruby[かん][感]じる。],
  [#ruby[み][見]る], [see], [#ruby[そら][空]を#ruby[み][見]る。],
  [#ruby[き][聞]く], [hear, listen], [#ruby[おと][音]を#ruby[き][聞]く。],
  [#ruby[おも][思]う], [think, feel (opinion)], [それは#ruby[よ][良]いと#ruby[おも][思]う。],
  [#ruby[ほ][欲]しい], [want (thing)], [#ruby[あたら][新]しい#ruby[ほん][本]が#ruby[ほ][欲]しい。],
  [#ruby[ひつよう][必要]], [necessary], [#ruby[みず][水]は#ruby[ひつよう][必要]だ。],
  [#ruby[す][好]き], [like], [#ruby[どうぶつ][動物]が#ruby[す][好]きだ。],
  [#ruby[こわ][怖]い], [scary], [その#ruby[はなし][話]は#ruby[こわ][怖]い。],
  [#ruby[かな][悲]しい], [sad], [その#ruby[はなし][話]は#ruby[かな][悲]しい。],
  [#ruby[おこ][怒]る], [get angry], [#ruby[ちち][父]が#ruby[おこ][怒]る。],
)]

== #ruby[い][言]う#ruby[こと][事] (Communication)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[ことば][言葉]], [word], [この#ruby[ことば][言葉]が#ruby[わ][分]からない。],
  [#ruby[なまえ][名前]], [name], [あなたの#ruby[なまえ][名前]を#ruby[おし][教]えてください。],
  [#ruby[おと][音]], [sound], [#ruby[へん][変]な#ruby[おと][音]を#ruby[き][聞]く。],
)]

== #ruby[とき][時] (Time)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[とき][時]], [time, when], [#ruby[た][食]べる#ruby[とき][時]、#ruby[て][手]を#ruby[つか][使]う。],
  [#ruby[いま][今]], [now], [#ruby[いま][今]、#ruby[た][食]べる。],
  [#ruby[まえ][前]], [before], [#ruby[た][食]べる#ruby[まえ][前]に#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[あと][後]], [after], [#ruby[た][食]べた#ruby[あと][後]、#ruby[いえ][家]に#ruby[い][行]く。],
  [#ruby[まい][毎]], [every], [#ruby[まい][毎]#ruby[にち][日]#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[にち][日]], [day], [#ruby[よ][良]い#ruby[にち][日]だ。],
  [#ruby[とし][年]], [year], [#ruby[あたら][新]しい#ruby[とし][年]が#ruby[はじ][始]まる。],
  [#ruby[よる][夜]], [night], [#ruby[よる][夜]、#ruby[そら][空]に#ruby[つき][月]が#ruby[み][見]える。],
)]

== #ruby[ところ][所]と#ruby[うえ][上]#ruby[した][下] (Places & Space)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[くに][国]], [country], [この#ruby[くに][国]は#ruby[おお][大]きい。],
  [#ruby[ところ][所]], [place], [いい#ruby[ところ][所]を#ruby[さが][探]す。],
  [#ruby[いえ][家]], [house, home], [#ruby[わたし][私]の#ruby[いえ][家]は#ruby[おお][大]きい。],
  [#ruby[みち][道]], [road, way], [#ruby[みち][道]を#ruby[い][行]く。],
  [#ruby[なか][中]], [inside, middle], [#ruby[いえ][家]の#ruby[なか][中]に#ruby[もの][物]がある。],
  [#ruby[そと][外]], [outside], [#ruby[そと][外]に#ruby[い][行]く。],
  [#ruby[うえ][上]], [above, up], [#ruby[やま][山]の#ruby[うえ][上]に#ruby[ひと][人]がいる。],
  [#ruby[した][下]], [below, down], [#ruby[き][木]の#ruby[した][下]に#ruby[なに][何]かある。],
  [#ruby[みぎ][右]], [right], [#ruby[みぎ][右]に#ruby[おお][大]きい#ruby[いえ][家]がある。],
  [#ruby[ひだり][左]], [left], [#ruby[ひだり][左]に#ruby[やま][山]がある。],
  [#ruby[ちか][近]い], [near], [#ruby[やま][山]は#ruby[いえ][家]から#ruby[ちか][近]い。],
  [#ruby[とお][遠]い], [far], [#ruby[うみ][海]は#ruby[とお][遠]い。],
  [ここ], [here], [ここに#ruby[すわ][座]ってください。],
  [そこ], [there], [そこに#ruby[なに][何]がある？],
  [どこ], [where], [#ruby[うみ][海]はどこ？],
)]

== #ruby[ひと][一]つにする#ruby[こと][言]#ruby[ば][葉] (Connectors)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[ぜんぶ][全部]], [all], [#ruby[ぜんぶ][全部]#ruby[た][食]べた。],
  [と], [and], [#ruby[みず][水]と#ruby[た][食]べ#ruby[もの][物]をください。],
  [または], [or], [#ruby[みず][水]または#ruby[の][飲]み#ruby[もの][物]をください。],
  [でも], [but], [#ruby[ちい][小]さい。でも#ruby[つよ][強]い。],
  [から], [from, because], [#ruby[さむ][寒]いから、#ruby[いえ][家]にいる。],
  [まで], [until, to], [#ruby[よる][夜]まで#ruby[ま][待]つ。],
  [なら], [if], [#ruby[とき][時]があるなら、#ruby[そと][外]に#ruby[い][行]く。],
  [だけ], [only], [#ruby[みず][水]だけ#ruby[の][飲]む。],
  [も], [also], [#ruby[わたし][私]も#ruby[い][行]く。],
  [もっと], [more], [もっと#ruby[た][食]べたい。],
  [もう], [already], [もう#ruby[た][食]べた。],
  [まだ], [still, yet], [まだ#ruby[た][食]べていない。],
  [とても], [very], [この#ruby[た][食]べ#ruby[もの][物]はとても#ruby[よ][良]い。],
  [#ruby[すこ][少]し], [a little], [#ruby[すこ][少]し#ruby[ま][待]ってください。],
  [#ruby[かた][方]], [way, method], [#ruby[た][食]べ#ruby[かた][方]を#ruby[おし][教]えてください。],
  [たぶん], [maybe], [たぶん#ruby[あめ][雨]が#ruby[く][来]る。],
)]

== はいといいえ (Responses & Questions)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [すみません], [excuse me], [すみません、#ruby[みち][道]を#ruby[おし][教]えてください。],
  [ありがとう], [thank you], [ありがとう。#ruby[たす][助]かった。],
  [ください], [please (give me)], [#ruby[みず][水]をください。],
  [はい], [yes], [はい、#ruby[わ][分]かった。],
  [ない], [not, don't have], [お#ruby[かね][金]がない。],
  [どう], [how], [これはどう#ruby[つか][使]う？],
  [いいえ], [no], [いいえ、#ruby[ほ][欲]しくない。],
  [いつ], [when], [いつ#ruby[く][来]る？],
  [なぜ], [why], [なぜ#ruby[い][行]かない？],
  [これ], [this], [これは#ruby[なん][何]だ？],
  [それ], [that], [それをください。],
  [この], [this (+noun)], [この#ruby[ほん][本]は#ruby[よ][良]い。],
  [その], [that (+noun)], [その#ruby[た][食]べ#ruby[もの][物]は#ruby[なん][何]だ？],
)]

== いくつ (Numbers)

#note-block[Some numbers have two readings. 4=し/よん, 7=しち/なな, 9=く/きゅう. In daily speech よん, なな, きゅう are safer. Build larger numbers by multiplying: 二十=20, 三百=300.]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*Word*][*Meaning*][*Example*],
  [#ruby[いち][一]], [one], [#ruby[ひと][一]りで#ruby[やま][山]に#ruby[い][行]った。],
  [#ruby[に][二]], [two], [#ruby[て][手]は#ruby[ふた][二]つある。],
  [#ruby[さん][三]], [three], [#ruby[さん][三]#ruby[にん][人]の#ruby[こども][子供]がいる。],
  [#ruby[よん][四]], [four], [#ruby[いぬ][犬]の#ruby[あし][足]は#ruby[よん][四]つだ。],
  [#ruby[ご][五]], [five], [#ruby[ご][五]#ruby[にん][人]の#ruby[ひと][人]が#ruby[き][来]た。],
  [#ruby[ろく][六]], [six], [#ruby[ろく][六]#ruby[がつ][月]は#ruby[あめ][雨]が#ruby[おお][多]い。],
  [#ruby[なな][七]], [seven], [#ruby[なな][七]つの#ruby[いろ][色]が#ruby[そら][空]に#ruby[で][出]た。],
  [#ruby[はち][八]], [eight], [#ruby[はち][八]#ruby[がつ][月]はとても#ruby[あつ][暑]い。],
  [#ruby[きゅう][九]], [nine], [#ruby[く][九]#ruby[じ][時]に#ruby[ね][寝]る。],
  [#ruby[じゅう][十]], [ten], [#ruby[じゅう][十]#ruby[にん][人]で#ruby[た][食]べた。],
  [#ruby[ひゃく][百]], [hundred], [#ruby[みず][水]は#ruby[ひゃく][百]#ruby[ご][五]#ruby[じゅう][十]だ。],
)]

#pagebreak(weak: true)

= Grammar

== #ruby[こと][言]#ruby[ば][葉]の#ruby[かたち][形] (Sentence Shape)

#grammar-card[#ruby[こと][言]#ruby[ば][葉]の#ruby[く][来]る#ruby[ところ][所] (Word Order)][Set the stage, then act. [who] [when] [where] [what] -\> [action]. Verb always comes last. Particles mark which slot each word fills. Think of it like a movie: set the scene first, then roll.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ほん][本]を #ruby[よ][読]む。
#text(size: 8.5pt, fill: rgb("#666666"))[I read a book. (I + book + read)]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ひと][人]だ。
#text(size: 8.5pt, fill: rgb("#666666"))[I am a person.]]]

#grammar-card[#ruby[い][言]わない#ruby[こと][事] (Omission)][Drop what's known. Subjects, objects - anything established vanishes. This is the default.][#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[なに][何]を #ruby[の][飲]む？」「#ruby[みず][水]。」
#text(size: 8.5pt, fill: rgb("#666666"))[What will you drink? - Water.]]]

#grammar-card[ある / いる (Existence / Possession)][Existence IS possession. No separate \"have\" verb. いる for living, ある for everything else.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[どうぶつ][動物]がいる。
#text(size: 8.5pt, fill: rgb("#666666"))[An animal is here.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ほん][本]がある。
#text(size: 8.5pt, fill: rgb("#666666"))[A book is here.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ほん][本]がある。
#text(size: 8.5pt, fill: rgb("#666666"))[I have a book. (as for me, a book exists)]]]

== する#ruby[こと][事]の#ruby[かたち][形] (Verbs)

#grammar-card[#ruby[よっ][四]つの#ruby[かた][方] (Four Forms)][Four filters on any verb: る (present/future) / た (done) / ない (not) / なかった (wasn't). Like Instagram filters on a photo - the verb stays the same, you just change what surrounds it. Everything else layers on top of these four.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べる → #ruby[た][食]べた → #ruby[た][食]べない → #ruby[た][食]べなかった
#text(size: 8.5pt, fill: rgb("#666666"))[eat / ate / don't eat / didn't eat]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]く → #ruby[い][行]った → #ruby[い][行]かない → #ruby[い][行]かなかった
#text(size: 8.5pt, fill: rgb("#666666"))[go / went / don't go / didn't go]]
#block(inset: (top: 0.2em, bottom: 0.2em))[する → した → しない → しなかった
#text(size: 8.5pt, fill: rgb("#666666"))[do / did / don't do / didn't do]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[く][来]る → #ruby[き][来]た → #ruby[こ][来]ない → #ruby[こ][来]なかった
#text(size: 8.5pt, fill: rgb("#666666"))[come / came / don't come / didn't come]]]

#grammar-card[ての#ruby[かた][方] (Te-form: Action Chaining)][Chain actions in the order they happen. No \"to\", \"by\", or \"with\" needed - just stack verbs. Write, read, sleep = 書いて読んで寝た. One tense at the end only. Formation: く→いて, む→んで, つ→って, る→て.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]く → #ruby[か][書]いて
#text(size: 8.5pt, fill: rgb("#666666"))[Write → writing (te-form).]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[の][飲]む → #ruby[の][飲]んで
#text(size: 8.5pt, fill: rgb("#666666"))[Drink → drinking (te-form).]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ま][待]つ → #ruby[ま][待]って
#text(size: 8.5pt, fill: rgb("#666666"))[Wait → waiting (te-form).]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べる → #ruby[た][食]べて
#text(size: 8.5pt, fill: rgb("#666666"))[Eat → eating (te-form).]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]いて #ruby[よ][読]んで #ruby[ね][寝]た。
#text(size: 8.5pt, fill: rgb("#666666"))[Wrote, read, slept. (one tense at the end)]]]

#grammar-card[て + もっと (Te-form Extensions)][Layer more onto te-form. Request (+ください), ongoing right now (+いる), permission (+もいい), prohibition (+はいけない). Same te-form, different endings.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ま][待]ってください。
#text(size: 8.5pt, fill: rgb("#666666"))[Please wait.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いま][今] #ruby[よ][読]んでいる。
#text(size: 8.5pt, fill: rgb("#666666"))[I am reading now.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[すわ][座]ってもいい？
#text(size: 8.5pt, fill: rgb("#666666"))[May I sit?]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[はい][入]ってはいけない。
#text(size: 8.5pt, fill: rgb("#666666"))[Must not enter.]]]

#grammar-card[られる / える (Potential Form)][Ability. る-verbs: drop る, add られる. Other verbs: え-row + る. する → できる.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]く → #ruby[か][書]ける
#text(size: 8.5pt, fill: rgb("#666666"))[Write → can write.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[み][見]る → #ruby[み][見]られる
#text(size: 8.5pt, fill: rgb("#666666"))[See → can see.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[する → できる
#text(size: 8.5pt, fill: rgb("#666666"))[Do → can do.]]]

#grammar-card[ないでください (Please Don't)][Negative request. V-ない + で + ください. 入らないでください = please don't enter. 触らないでください = please don't touch.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[はい][入]らないでください。
#text(size: 8.5pt, fill: rgb("#666666"))[Please don't enter.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[て][手]で#ruby[も][持]たないでください。
#text(size: 8.5pt, fill: rgb("#666666"))[Please don't hold it.]]]

== ますとです (Polite Form)

#grammar-card[ます / です (Polite Form)][The politeness filter. Verb stem + ます. だ → です. Always regular: ます / ました / ません / ませんでした. Simpler than plain form - zero sound changes, zero exceptions.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]みます。
#text(size: 8.5pt, fill: rgb("#666666"))[I drink water. (polite)]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]に#ruby[い][行]きました。
#text(size: 8.5pt, fill: rgb("#666666"))[I went to the mountain. (polite past)]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さかな][魚]を#ruby[た][食]べません。
#text(size: 8.5pt, fill: rgb("#666666"))[I don't eat fish. (polite negative)]]
#block(inset: (top: 0.2em, bottom: 0.2em))[この#ruby[ほん][本]は#ruby[よ][良]いです。
#text(size: 8.5pt, fill: rgb("#666666"))[This book is good. (polite copula)]]]

#grammar-card[いつますを#ruby[つか][使]うか (When to Use Polite Form)][Use ます/です with anyone you don't know well: strangers, shopkeepers, doctors, teachers, coworkers. Use plain form with close friends and family. Not using ます with strangers sounds childish or rude. です also follows い-adjectives: 寒い → 寒いです. だ → です for nouns and な-adjectives.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][買]う#ruby[ところ][所]で: これをください。いくらですか。
#text(size: 8.5pt, fill: rgb("#666666"))[At a shop: This please. How much is it? (polite)]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[す][好]きな#ruby[ひと][人]に: これ、いくら？
#text(size: 8.5pt, fill: rgb("#666666"))[To a friend: This, how much? (plain)]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]いです。
#text(size: 8.5pt, fill: rgb("#666666"))[It's cold. (polite - です follows い-adjective)]]]

== #ruby[ひと][一]つにする#ruby[こと][言]#ruby[ば][葉] (Particles)

#grammar-card[は (wa - Topic Marker)][Sets the stage: \"As for X...\" Fills the [who] slot in the sentence frame. Tells the listener what this sentence is about.][#block(inset: (top: 0.2em, bottom: 0.2em))[この #ruby[ほん][本]は #ruby[よ][良]い。
#text(size: 8.5pt, fill: rgb("#666666"))[This book is good.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[め][目]が #ruby[よ][良]い。
#text(size: 8.5pt, fill: rgb("#666666"))[As for me, my eyes are good. (は = topic, が = subject within)]]]

#grammar-card[が (ga - Subject Marker)][Subject. Who does it. New information.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]が #ruby[く][来]る？
#text(size: 8.5pt, fill: rgb("#666666"))[Who is coming?]]]

#grammar-card[を (o - Object Marker)][Fills the [what] slot. What the action is done to.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を #ruby[の][飲]む。
#text(size: 8.5pt, fill: rgb("#666666"))[I drink water.]]]

#grammar-card[に (ni - Direction, Time, Location)][Fills the [when] and [where] slots. Destination (go to), time (at 3), location of existence (is at).][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]に #ruby[い][行]く。
#text(size: 8.5pt, fill: rgb("#666666"))[I go to the mountain.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よる][夜]に #ruby[ね][寝]る。
#text(size: 8.5pt, fill: rgb("#666666"))[I sleep at night.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]に #ruby[どうぶつ][動物]がいる。
#text(size: 8.5pt, fill: rgb("#666666"))[An animal is in the house.]]]

#grammar-card[で (de - Location of Action, Means)][Where things happen, what tools you use. Compare に: に = where things exist, で = where things happen.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]で #ruby[よ][読]む。
#text(size: 8.5pt, fill: rgb("#666666"))[I read at home.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[て][手]で #ruby[か][書]く。
#text(size: 8.5pt, fill: rgb("#666666"))[I write by hand.]]]

#grammar-card[の (no - Possessive / Connector)][Connects nouns. Also turns verbs into nouns (see section 5).][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]の #ruby[ほん][本]。
#text(size: 8.5pt, fill: rgb("#666666"))[My book.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]の #ruby[うえ][上]。
#text(size: 8.5pt, fill: rgb("#666666"))[Top of the mountain.]]]

#grammar-card[と (to - And, With, Quotation)][And, with, quotation. Quotes anything: speech, thoughts, sounds, names.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]と #ruby[ほん][本]を #ruby[か][買]った。
#text(size: 8.5pt, fill: rgb("#666666"))[I bought water and a book.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[い][行]く」と #ruby[い][言]った。
#text(size: 8.5pt, fill: rgb("#666666"))[He said \"I'll go.\"]]]

#grammar-card[も (mo - Also)][Also. Replaces は, が, or を.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ちち][父]は #ruby[ほん][本]を #ruby[よ][読]む。#ruby[はは][母]も #ruby[よ][読]む。
#text(size: 8.5pt, fill: rgb("#666666"))[Father reads books. Mother also reads.]]]

#grammar-card[から / まで (From / Until)][Start points (from), end points (until). から also gives reasons (because).][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]から #ruby[やま][山]まで #ruby[い][行]く。
#text(size: 8.5pt, fill: rgb("#666666"))[I go from home to the mountain.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よる][夜]まで #ruby[ま][待]つ。
#text(size: 8.5pt, fill: rgb("#666666"))[I wait until night.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]いから、#ruby[いえ][家]にいる。
#text(size: 8.5pt, fill: rgb("#666666"))[It's cold, so I stay home.]]]

#grammar-card[より (Comparison)][Xより = \"more than X.\" One particle, all comparisons.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]より #ruby[おお][大]きい。
#text(size: 8.5pt, fill: rgb("#666666"))[Bigger than a mountain.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]より #ruby[た][食]べ#ruby[もの][物]が #ruby[す][好]きだ。
#text(size: 8.5pt, fill: rgb("#666666"))[I like food more than water.]]]

== どんな (Describing Things)

#grammar-card[い の#ruby[こと][言]#ruby[ば][葉] (I-adjectives)][ARE verbs. 寒い is a complete sentence. Conjugate: くない, かった, くて. No copula needed.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]い。
#text(size: 8.5pt, fill: rgb("#666666"))[Cold.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]くない。
#text(size: 8.5pt, fill: rgb("#666666"))[Not cold.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]かった。
#text(size: 8.5pt, fill: rgb("#666666"))[Was cold.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]くて #ruby[かな][悲]しい。
#text(size: 8.5pt, fill: rgb("#666666"))[Cold and sad.]]]

#grammar-card[な の#ruby[こと][言]#ruby[ば][葉] (Na-adjectives)][Add な before nouns. じゃない (neg), だった (past).][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]な #ruby[もの][物]。
#text(size: 8.5pt, fill: rgb("#666666"))[A necessary thing.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]じゃない。
#text(size: 8.5pt, fill: rgb("#666666"))[Not necessary.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]だった。
#text(size: 8.5pt, fill: rgb("#666666"))[Was necessary.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]で #ruby[よ][良]い。
#text(size: 8.5pt, fill: rgb("#666666"))[Necessary and good.]]]

#grammar-card[〜くなる / 〜になる (Change of State)][Change of state. One pattern for all changes.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あつ][暑]い → #ruby[あつ][暑]くなる。
#text(size: 8.5pt, fill: rgb("#666666"))[Hot → becomes hot.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要] → #ruby[ひつよう][必要]になる。
#text(size: 8.5pt, fill: rgb("#666666"))[Necessary → becomes necessary.]]]

#grammar-card[する#ruby[こと][事] + #ruby[もの][物] (Relative Clauses)][Put a verb or sentence before a noun to describe it. Engine of word-building.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]で #ruby[うご][動]く #ruby[こども][子供]。
#text(size: 8.5pt, fill: rgb("#666666"))[A child who moves on the mountain.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]が #ruby[か][買]った #ruby[もの][物]。
#text(size: 8.5pt, fill: rgb("#666666"))[A thing I bought.]]]

== #ruby[もの][物]にする (Making Nouns)

#grammar-card[の (Nominalizer (の))][Casual. 食べるのが好き. Also in questions: 何しているの？][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べるのが #ruby[す][好]きだ。
#text(size: 8.5pt, fill: rgb("#666666"))[I like eating.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なに][何]しているの？
#text(size: 8.5pt, fill: rgb("#666666"))[What are you doing?]]]

#grammar-card[こと (Nominalizer (こと))][Turns actions into abstract ideas. Invisible things. 走ること = the idea of running. Compare: 飲むもの = a drinkable thing (physical). こと = idea, もの = thing.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[うご][動]くことは#ruby[よ][良]い。
#text(size: 8.5pt, fill: rgb("#666666"))[Moving is good (the idea of moving).]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]くことができる。
#text(size: 8.5pt, fill: rgb("#666666"))[It is possible to go.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]なことを#ruby[い][言]う。
#text(size: 8.5pt, fill: rgb("#666666"))[I will say something necessary (abstract).]]]

#grammar-card[もの (Nominalizer (もの))][Physical things you can touch or point to. 飲むもの = something to drink. こと = abstract idea, もの = concrete thing.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[の][飲]むもの。
#text(size: 8.5pt, fill: rgb("#666666"))[Something to drink.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][読]むもの。
#text(size: 8.5pt, fill: rgb("#666666"))[Something to read.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]なものを#ruby[も][持]っている。
#text(size: 8.5pt, fill: rgb("#666666"))[I have something necessary (physical).]]]

#grammar-card[#ruby[かた][方] (Way of Doing)][The way of doing. Attach to verb stem. 食べ方 = how to eat. 使い方 = how to use. こと (idea) + もの (thing) + 方 (method) = express everything.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べ#ruby[かた][方]を#ruby[おし][教]えてください。
#text(size: 8.5pt, fill: rgb("#666666"))[Please teach me how to eat (this).]]
#block(inset: (top: 0.2em, bottom: 0.2em))[この#ruby[こと][言]#ruby[ば][葉]の#ruby[つか][使]い#ruby[かた][方]が#ruby[し][知]りたい。
#text(size: 8.5pt, fill: rgb("#666666"))[I want to know how to use this word.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[き][聞]き#ruby[かた][方]が#ruby[ひつよう][必要]だ。
#text(size: 8.5pt, fill: rgb("#666666"))[The way you ask is necessary.]]]

== #ruby[おも][思]うと「もし」 (Will & Conditions)

#grammar-card[たい / #ruby[ほ][欲]しい (Want)][Want to do (verb stem + たい). Want a thing (欲しい).][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]きたい。
#text(size: 8.5pt, fill: rgb("#666666"))[I want to go.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あたら][新]しい #ruby[いえ][家]が #ruby[ほ][欲]しい。
#text(size: 8.5pt, fill: rgb("#666666"))[I want a new house.]]]

#grammar-card[たら / なら / ければ (Conditionals)][たら = when/if something happens (verb た + ら). なら = if it's the case (nouns, な-adj). ければ = if for い-adjectives (い → ければ).][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あめ][雨]が #ruby[き][来]たら、#ruby[い][行]かない。
#text(size: 8.5pt, fill: rgb("#666666"))[If rain comes, I won't go.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[とき][時]があるなら、#ruby[き][来]てください。
#text(size: 8.5pt, fill: rgb("#666666"))[If you have time, please come.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]ければ、#ruby[いえ][家]にいる。
#text(size: 8.5pt, fill: rgb("#666666"))[If cold, I stay home.]]]

#grammar-card[と#ruby[おも][思]う / と#ruby[い][言]う (Quotation)][Quote anything with と. Thoughts, speech, sounds. という = \"called.\"][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][良]いと #ruby[おも][思]う。
#text(size: 8.5pt, fill: rgb("#666666"))[I think it's good.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[い][行]く」と #ruby[い][言]った。
#text(size: 8.5pt, fill: rgb("#666666"))[He said \"I'll go.\"]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[おお][大]きい#ruby[やま][山]という #ruby[ところ][所]
#text(size: 8.5pt, fill: rgb("#666666"))[A place called Big Mountain.]]]

#grammar-card[ために (Purpose / Benefit)][Purpose and beneficiary. Verb+ために or noun+のために.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[し][知]るために #ruby[よ][読]む。
#text(size: 8.5pt, fill: rgb("#666666"))[I read in order to know.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[こども][子供]のために。
#text(size: 8.5pt, fill: rgb("#666666"))[For the children.]]]

#grammar-card[う / よう / ましょう (Volitional (Let's))][Suggest doing together. 行こう / 行きましょう = let's go. 食べよう / 食べましょう = let's eat. Verb stem + ましょう (polite).][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べましょう。
#text(size: 8.5pt, fill: rgb("#666666"))[Let's eat.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ふた][二]りで#ruby[い][行]きましょう。
#text(size: 8.5pt, fill: rgb("#666666"))[Let's go together.]]]

#grammar-card[なくてはいけない / なきゃ (Must / Have to)][Obligation. Verb ない-form → なくてはいけない (must). In speech, なきゃ alone is enough. 行かなきゃ = I must go.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]まなきゃ。
#text(size: 8.5pt, fill: rgb("#666666"))[I must drink water.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[まい][毎]#ruby[にち][日]#ruby[ある][歩]かなくてはいけない。
#text(size: 8.5pt, fill: rgb("#666666"))[I must walk every day.]]]

#grammar-card[ほうがいい (Should / Better to)][Advice. V-た + ほうがいい = should do. V-ない + ほうがいい = should not do. 水を飲んだほうがいい = you should drink water.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]んだほうがいい。
#text(size: 8.5pt, fill: rgb("#666666"))[You should drink water.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]かないほうがいい。
#text(size: 8.5pt, fill: rgb("#666666"))[You shouldn't go.]]]

== #ruby[き][聞]き#ruby[かた][方] (Questions)

#grammar-card[か / ね / よ (Sentence-ending Particles)][Question / right? / emphasis. か often dropped in casual - just rising tone.][#block(inset: (top: 0.2em, bottom: 0.2em))[これは #ruby[みず][水]か？
#text(size: 8.5pt, fill: rgb("#666666"))[Is this water?]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][良]い #ruby[にち][日]だね。
#text(size: 8.5pt, fill: rgb("#666666"))[Nice day, right?]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]くよ。
#text(size: 8.5pt, fill: rgb("#666666"))[I'm going!]]]

#grammar-card[#ruby[なに][何]・#ruby[だれ][誰]・どこ・いつ・なぜ + も/でも (Question Words + Particles)][Question words go where the answer goes. +も (neg verb) = nothing/nobody. +でも = anything/anyone. 5 words + 2 particles = 20 pronouns free.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なに][何]を #ruby[た][食]べる？→ #ruby[なに][何]も #ruby[た][食]べない。
#text(size: 8.5pt, fill: rgb("#666666"))[What will you eat? → I eat nothing.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なん][何]でも #ruby[つく][作]れる。
#text(size: 8.5pt, fill: rgb("#666666"))[I can make anything.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]もいない。
#text(size: 8.5pt, fill: rgb("#666666"))[Nobody is here.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]でもできる。
#text(size: 8.5pt, fill: rgb("#666666"))[Anyone can do it.]]]

== いくつ (Numbers & Counting)

#grammar-card[つ (いくつ) (Counting with つ)][Count objects with つ. Readings are ALL irregular: 1=ひとつ 2=ふたつ 3=みっつ 4=よっつ 5=いつつ 6=むっつ 7=ななつ 8=やっつ 9=ここのつ. 10=とお (no つ!). Above 10 use plain numbers. Universal counter for any object.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]を#ruby[みっ][三]つください。
#text(size: 8.5pt, fill: rgb("#666666"))[Three eggs please.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さかな][魚]を#ruby[ふた][二]つと#ruby[たまご][卵]を#ruby[いつ][五]つください。
#text(size: 8.5pt, fill: rgb("#666666"))[Two fish and five eggs please.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]を#ruby[やっ][八]つ#ruby[か][買]った。
#text(size: 8.5pt, fill: rgb("#666666"))[I bought eight eggs.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]が#ruby[とお][十]ある。#ruby[ぜんぶ][全部]#ruby[た][食]べた。
#text(size: 8.5pt, fill: rgb("#666666"))[There are ten eggs. I ate them all. (10 = とお - no つ!)]]]

#grammar-card[いくつの#ruby[つく][作]り#ruby[かた][方] (Making Numbers)][Put a digit before 十 or 百. 二十 = 20. 三百 = 300. Chain them: 三百五十二 = 352. Pattern: [digit]百[digit]十[digit]. Sound changes before 百: 300=さんびゃく, 600=ろっぴゃく, 800=はっぴゃく. Tip: start by learning prices - you will hear numbers at every shop.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[に][二]#ruby[じゅう][十]#ruby[にん][人]の#ruby[ひと][人]が#ruby[き][来]た。
#text(size: 8.5pt, fill: rgb("#666666"))[20 people came. 二十 = 2x10 = 20. Pattern: digit + 十 + digit.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[これは#ruby[さん][三]#ruby[びゃく][百]#ruby[ご][五]#ruby[じゅう][十]#ruby[に][二]です。
#text(size: 8.5pt, fill: rgb("#666666"))[This is 352. 三百五十二 = 3x100 + 5x10 + 2. Pattern: digit + 百 + digit + 十 + digit.]]]

#grammar-card[いくつの#ruby[よ][読]み#ruby[かた][方] (Number Readings)][8 numbers always sound the same: いち(1) に(2) さん(3) ご(5) ろく(6) はち(8) じゅう(10) ひゃく(100). Only 3 have two readings: し/よん(4) しち/なな(7) く/きゅう(9). Tip: when unsure, use よん, なな, きゅう - they always work and are more common in daily speech. し can be confused with 死(death), so よん is safer.][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[し][四]#ruby[がつ][月]に#ruby[あめ][雨]が#ruby[く][来]る。#ruby[よ][四]#ruby[じ][時]に#ruby[あ][会]う。
#text(size: 8.5pt, fill: rgb("#666666"))[Rain comes in April (しがつ). Meet at 4 o'clock (よじ). 4 has two readings: し and よん. Tip: よん is safer in daily speech.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[しち][七]#ruby[がつ][月]は#ruby[あつ][暑]い。#ruby[なな][七]つの#ruby[やま][山]が#ruby[み][見]える。
#text(size: 8.5pt, fill: rgb("#666666"))[July (しちがつ) is hot. Seven mountains are visible (ななつ). 7 has two readings: しち and なな. Tip: なな is safer.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[く][九]#ruby[がつ][月]から#ruby[さむ][寒]くなる。#ruby[きゅう][九]#ruby[じ][時]に#ruby[ね][寝]る。
#text(size: 8.5pt, fill: rgb("#666666"))[It gets cold from September (くがつ). I sleep at 9 (くじ). 9 has two readings: く and きゅう. Tip: きゅう is safer.]]
#block(inset: (top: 0.2em, bottom: 0.2em))[これは#ruby[さん][三]#ruby[びゃく][百]。それは#ruby[ろっ][六]#ruby[ぴゃく][百]。あれは#ruby[はっ][八]#ruby[ぴゃく][百]。
#text(size: 8.5pt, fill: rgb("#666666"))[This is 300 (さんびゃく). That is 600 (ろっぴゃく). That is 800 (はっぴゃく). 百 changes sound after 3, 6, and 8.]]]

#pagebreak(weak: true)

= Reading

== #ruby[はな][話]し (Dialogs)

=== #ruby[まい][毎]#ruby[にち][日]の#ruby[はな][話]し (Daily Life Dialogs)

#dialog-block[#ruby[か][買]う#ruby[ところ][所]で (At a Shop)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。この#ruby[た][食]べ#ruby[もの][物]は#ruby[なに][何]ですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* これは#ruby[よ][良]い#ruby[た][食]べ#ruby[もの][物]です。#ruby[みず][水]と#ruby[くさ][草]で#ruby[つく][作]りました。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* これをください。#ruby[ほか][他]の#ruby[もの][物]もありますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。そこに#ruby[あたら][新]しい#ruby[もの][物]があります。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それも#ruby[み][見]てもいいですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。#ruby[て][手]で#ruby[も][持]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* これを#ruby[か][買]います。ありがとう。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* ありがとう。また#ruby[き][来]てください。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. What is this food?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* This is good food. We made it with water and greens.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Please give me this. Do you have other things too?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. There are new things over there.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* May I look at that too?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. Please hold it in your hands.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* I'll buy this. Thank you.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Thank you. Please come again.]]

#dialog-block[#ruby[みち][道]で#ruby[ひと][人]と#ruby[あ][会]う (Meeting a Friend on the Street)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* あ！どこに#ruby[い][行]きますか？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[いま][今]は#ruby[うみ][海]に#ruby[い][行]きます。あなたは？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]は#ruby[いえ][家]に#ruby[く][来]る。#ruby[からだ][体]が#ruby[すこ][少]し#ruby[わる][悪]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[からだ][体]が#ruby[わる][悪]いですか？#ruby[みず][水]を#ruby[の][飲]んで、#ruby[ね][寝]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとう。#ruby[うみ][海]の#ruby[かぜ][風]はとても#ruby[よ][良]いね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そうだね。でも#ruby[いま][今]は#ruby[かぜ][風]が#ruby[つよ][強]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[よ][良]く#ruby[まも][守]ってください。また#ruby[あ][会]おう！]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、また#ruby[あ][会]おう！]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Oh! Where are you going?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* I'm heading to the sea now. And you?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* I'm going home. My body feels a little bad.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Your body feels bad? Please drink water and sleep.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Thank you. The sea air is really good, isn't it.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* It is. But right now the wind is strong.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Please take care of yourself. Let's meet again!]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes, let's meet again!]]

#dialog-block[#ruby[いえ][家]の#ruby[よる][夜]の#ruby[た][食]べ#ruby[もの][物] (Family Dinner)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[すわ][座]ってください。#ruby[た][食]べ#ruby[もの][物]ができた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[いま][今]は#ruby[なに][何]を#ruby[た][食]べる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[くさ][草]と#ruby[みず][水]で#ruby[つく][作]った。#ruby[からだ][体]に#ruby[よ][良]い。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* とても#ruby[よ][良]い#ruby[もの][物]だね。#ruby[いま][今]まで#ruby[からだ][体]がとても#ruby[おも][重]かった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[ちち][父]、#ruby[いま][今]の#ruby[にち][日]は#ruby[たの][楽]しかったか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* まあまあだった。でも#ruby[いえ][家]に#ruby[く][来]ることがもっと#ruby[す][好]きだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* この#ruby[もの][物]を#ruby[ぜんぶ][全部]#ruby[た][食]べてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい！とても#ruby[よ][良]い。ありがとう、#ruby[はは][母]。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*Mother:* Everyone please sit down. The food is ready.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* What are we eating now?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Mother:* I made it with greens and water. It's good for your body.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Father:* It looks very good. My body has felt very heavy until now.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* Father, was this day enjoyable?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Father:* More or less. But coming home is what I like most.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Mother:* Please eat all of this.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* Yes! It's very good. Thank you, Mother.]]

#dialog-block[#ruby[みち][道]を#ruby[き][聞]く (Asking for Directions)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。#ruby[おお][大]きい#ruby[おお][大]きい#ruby[いえ][家]はどこですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* ここから#ruby[とお][遠]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* どう#ruby[い][行]ったらいいですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* この#ruby[みち][道]を#ruby[い][行]ってください。#ruby[おお][大]きい#ruby[き][木]の#ruby[まえ][前]で#ruby[みぎ][右]に#ruby[はい][入]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[き][木]の#ruby[まえ][前]で#ruby[みぎ][右]だね。その#ruby[あと][後]は？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[おお][大]きい#ruby[いえ][家]を#ruby[み][見]ることができます。それです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ある][歩]いて#ruby[い][行]けますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、#ruby[ある][歩]いて#ruby[い][行]けます。#ruby[とお][遠]いですが、#ruby[よ][良]い#ruby[みち][道]だ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとう！]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. Where is the big building?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* It's not close from here.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* How should I get there?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Please go along this road. At the big tree, turn right.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Right at the tree. And after that?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* You can see the building. That's it.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Can I go on foot?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes, you can go on foot. It's not close, but it's a good road.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Thank you!]]

#dialog-block[#ruby[にち][日]の#ruby[はじ][始]まり (Morning Routine)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* もう#ruby[た][立]ってください！#ruby[にち][日]が#ruby[で][出]ている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* まだ#ruby[め][目]が#ruby[おも][重]い。もう#ruby[すこ][少]し#ruby[ね][寝]たい。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* いけない。#ruby[はや][速]く#ruby[ふく][服]を#ruby[き][着]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい。でも#ruby[いま][今]は#ruby[そら][空]が#ruby[あか][明]るくない。#ruby[あめ][雨]が#ruby[く][来]るか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* そうだね。#ruby[そと][外]は#ruby[すこ][少]し#ruby[さむ][寒]いから、#ruby[よ][良]い#ruby[ふく][服]を#ruby[き][着]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[いま][今]は#ruby[なに][何]を#ruby[た][食]べる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[みず][水]と#ruby[た][食]べ#ruby[もの][物]がある。#ruby[ぜんぶ][全部]#ruby[た][食]べてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい、#ruby[はは][母]。#ruby[いま][今]の#ruby[にち][日]も#ruby[たの][楽]しいと#ruby[おも][思]う！]][#block(inset: (top: 0.05em, bottom: 0.05em))[*Mother:* Please get up already! The sun is out.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* My eyes are still heavy. I want to sleep a little more.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Mother:* No. Hurry and get dressed.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* Okay. But the sky isn't bright right now. Will rain come?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Mother:* It does look that way. Outside is a bit cold, so please wear good clothes.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* What are we eating now?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Mother:* There's water and food. Please eat all of it.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* Yes, Mother. I think this day will be fun too!]]

=== #ruby[からだ][体]と#ruby[たす][助]ける (Health & Emergencies)

#dialog-block[#ruby[からだ][体]が#ruby[わる][悪]い#ruby[とき][時] (At the Doctor)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[わたし][私]:* すみません。#ruby[からだ][体]が#ruby[わる][悪]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]:* どこが#ruby[わる][悪]いですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[わたし][私]:* #ruby[あたま][頭]が#ruby[わる][悪]い#ruby[かん][感]じです。#ruby[からだ][体]も#ruby[あつ][暑]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]:* いつから#ruby[わる][悪]いですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[わたし][私]:* #ruby[まえ][前]の#ruby[にち][日]からです。#ruby[よる][夜]も#ruby[ね][寝]られませんでした。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]:* #ruby[くち][口]を#ruby[あ][開]けてください。#ruby[からだ][体]を#ruby[み][見]ます。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]:* #ruby[からだ][体]を#ruby[よ][良]くする#ruby[もの][物]を#ruby[の][飲]んでください。よく#ruby[ね][寝]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]:* #ruby[みっ][三]つの#ruby[にち][日]の#ruby[あと][後]に#ruby[よ][良]くならないなら、また#ruby[き][来]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[わたし][私]:* #ruby[わ][分]かりました。ありがとうございます。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*Patient:* Excuse me. I feel unwell.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Doctor:* Where does it feel bad?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Patient:* My head hurts. My body is also hot.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Doctor:* Since when have you felt bad?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Patient:* Since yesterday. I couldn't sleep last night either.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Doctor:* Please open your mouth. I will examine you.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Doctor:* Please take medicine. Please sleep well.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Doctor:* If you don't feel better in three days, please come back.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Patient:* I understand. Thank you very much.]]

#dialog-block[#ruby[からだ][体]を#ruby[よ][良]くする#ruby[もの][物]を#ruby[か][買]う (At the Pharmacy)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[わたし][私]:* すみません。#ruby[からだ][体]を#ruby[よ][良]くする#ruby[もの][物]が#ruby[ほ][欲]しいです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* どこが#ruby[わる][悪]いですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[わたし][私]:* #ruby[はら][腹]が#ruby[わる][悪]い#ruby[かん][感]じです。#ruby[た][食]べた#ruby[あと][後]に#ruby[わる][悪]くなります。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* #ruby[た][食]べ#ruby[もの][物]で#ruby[からだ][体]が#ruby[わる][悪]くなる#ruby[こと][事]はありますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[わたし][私]:* いいえ、ないです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* これが#ruby[よ][良]いと#ruby[おも][思]います。#ruby[まい][毎]#ruby[にち][日]、#ruby[た][食]べた#ruby[あと][後]に#ruby[ひと][一]つ#ruby[の][飲]んでください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[わたし][私]:* #ruby[わ][分]かりました。いくらですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* #ruby[ご][五]#ruby[ひゃく][百]です。#ruby[よ][良]くならないなら、#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]に#ruby[あ][会]ってください。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*Customer:* Excuse me. I would like some medicine.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* What's wrong?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Customer:* My stomach hurts. It gets bad after eating.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Does any food make you feel bad?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Customer:* No, I don't.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* I think this is good. Please take one after each meal.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Customer:* I understand. How much is it?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* It's five hundred. If it doesn't get better, please see a doctor.]]

#dialog-block[#ruby[たす][助]けてください (Emergency - Asking for Help)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません！#ruby[たす][助]けてください！]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* どうしましたか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* あの#ruby[ひと][人]が#ruby[した][下]に#ruby[い][行]きました。#ruby[あし][足]が#ruby[わる][悪]いと#ruby[おも][思]います。#ruby[うご][動]けません。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* どこですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* あの#ruby[おお][大]きい#ruby[いえ][家]の#ruby[まえ][前]です。#ruby[みち][道]の#ruby[うえ][上]にいます。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[わ][分]かりました。#ruby[たす][助]ける#ruby[ひと][人]に#ruby[い][言]います。#ruby[ま][待]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとうございます。あの#ruby[ひと][人]の#ruby[ちか][近]くにいてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。#ruby[みず][水]を#ruby[あた][与]えましょう。#ruby[からだ][体]を#ruby[うご][動]かさないでください。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me! Please help!]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* What happened?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* That person fell down. I think their leg is hurt. They can't move.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Where are they?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* In front of that big building. They are on the road.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* I understand. I will call for help. Please wait.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Thank you. Please stay near that person.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. Let's give them water. Please don't move their body.]]

=== #ruby[ところ][所]で#ruby[はな][話]す (At Places)

#dialog-block[#ruby[ひと][人]が#ruby[く][来]る#ruby[もの][物]を#ruby[ま][待]つ#ruby[ところ][所]で (At the Train Station)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。ここから#ruby[うみ][海]の#ruby[ひと][人]が#ruby[く][来]る#ruby[もの][物]を#ruby[ま][待]つ#ruby[ところ][所]まで#ruby[い][行]きたいです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* #ruby[に][二]#ruby[ひゃく][百]です。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ひと][一]つください。#ruby[なに][何]つ#ruby[め][目]の#ruby[ところ][所]から#ruby[で][出]ますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* #ruby[みっ][三]つ#ruby[め][目]です。#ruby[うえ][上]に#ruby[い][行]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* いつ#ruby[き][来]ますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* #ruby[じゅう][十]#ruby[ご][五]の#ruby[あと][後]です。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[うみ][海]の#ruby[ところ][所]までどのくらいですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* #ruby[に][二]#ruby[じゅう][十]ぐらいです。#ruby[みっ][三]つ#ruby[め][目]の#ruby[ところ][所]で#ruby[で][出]てください。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. I want to go from here to the sea station.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* A ticket is two hundred.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* One please. What platform does it leave from?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Number three. Please go up.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* When does it come?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* In fifteen minutes.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* How long to the sea station?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* About twenty minutes. Get off at the third stop.]]

#dialog-block[#ruby[た][食]べる#ruby[ところ][所]で (At a Restaurant)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* #ruby[なん][何]#ruby[にん][人]ですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ふた][二]りの#ruby[ひと][人]です。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* どうぞ、こちらに#ruby[すわ][座]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。この#ruby[た][食]べ#ruby[もの][物]の#ruby[なか][中]に#ruby[なに][何]がありますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* #ruby[くさ][草]と#ruby[にく][肉]です。#ruby[からだ][体]が#ruby[わる][悪]くなる#ruby[た][食]べ#ruby[もの][物]はありますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* はい。#ruby[たまご][卵]で#ruby[からだ][体]が#ruby[わる][悪]くなります。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* #ruby[わ][分]かりました。この#ruby[た][食]べ#ruby[もの][物]には#ruby[たまご][卵]は#ruby[はい][入]っていません。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* では、これをください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。お#ruby[かね][金]を#ruby[ぜんぶ][全部]ください。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* How many people?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Two people.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Please, sit here.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. What is in this dish?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Vegetables and meat. Do you have any food allergies?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Yes. Eggs make me feel bad.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* I understand. This dish has no eggs.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Then I'll have this.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. The bill please.]]

#dialog-block[#ruby[か][買]う#ruby[ところ][所]で (At the Convenience Store)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* #ruby[き][来]てくれてありがとう。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。この#ruby[た][食]べ#ruby[もの][物]を#ruby[あつ][暑]くしてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* はい。#ruby[すこ][少]し#ruby[ま][待]ってください。#ruby[い][入]れる#ruby[もの][物]は#ruby[ひつよう][必要]ですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* はい、ください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* #ruby[ほか][他]に#ruby[ほ][欲]しい#ruby[もの][物]はありますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[の][飲]み#ruby[もの][物]もください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* #ruby[ぜんぶ][全部]で#ruby[さん][三]#ruby[びゃく][百]#ruby[ご][五]#ruby[じゅう][十]です。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* お#ruby[かね][金]の#ruby[ちい][小]さい#ruby[もの][物]で#ruby[よ][良]いですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[みせ][店]の#ruby[ひと][人]:* はい。ありがとうございます。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Welcome.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. Please heat this food.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Yes. Please wait. Do you need a bag?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Yes please.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Anything else?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* This drink too please.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* The total is three hundred fifty.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Is card okay?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Yes. Thank you.]]

#dialog-block[#ruby[おと][音]で#ruby[い][言]う#ruby[もの][物]で#ruby[ひと][人]に#ruby[い][言]う (Making a Phone Appointment)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* もしもし。#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ところ][所]ですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ところ][所]の#ruby[ひと][人]:* はい。#ruby[なに][何]のためですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]に#ruby[あ][会]いたいです。いつが#ruby[よ][良]いですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ところ][所]の#ruby[ひと][人]:* #ruby[あと][後]の#ruby[にち][日]の#ruby[じゅう][十]の#ruby[とき][時]はどうですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[よ][良]いです。#ruby[わたし][私]の#ruby[なまえ][名前]はたなかです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ところ][所]の#ruby[ひと][人]:* たなかさんですね。#ruby[あと][後]の#ruby[にち][日]の#ruby[じゅう][十]の#ruby[とき][時]です。#ruby[ま][待]っています。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Hello. Is this the clinic?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Receptionist:* Yes. What is it for?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* I would like to see a doctor. When is good?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Receptionist:* How about tomorrow at ten?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* That's good. My name is Tanaka.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Receptionist:* Tanaka-san. Tomorrow at ten. We'll be expecting you.]]

#dialog-block[#ruby[き][来]た#ruby[こと][事]を#ruby[か][書]く#ruby[ところ][所]をする#ruby[ところ][所]で (At City Hall)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。ここに#ruby[き][来]た#ruby[こと][事]を#ruby[か][書]きたいです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* #ruby[わ][分]かりました。あなたが#ruby[だれ][誰]かを#ruby[み][見]せる#ruby[もの][物]が#ruby[ひつよう][必要]です。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* #ruby[ほか][他]の#ruby[くに][国]の#ruby[ひと][人]なら、#ruby[くに][国]に#ruby[い][行]く#ruby[ほん][本]も#ruby[ひつよう][必要]です。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* はい。これです。どうぞ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* ありがとうございます。この#ruby[か][書]く#ruby[もの][物]に#ruby[なまえ][名前]と#ruby[いえ][家]の#ruby[ところ][所]を#ruby[か][書]いてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[か][書]き#ruby[かた][方]が#ruby[わ][分]かりません。#ruby[おし][教]えてもらえますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* はい。ここに#ruby[なまえ][名前]。ここに#ruby[いえ][家]の#ruby[ところ][所]を#ruby[か][書]いてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとうございます。どこに#ruby[だ][出]しますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ところ][所]の#ruby[ひと][人]:* #ruby[ふた][二]つ#ruby[め][目]の#ruby[ところ][所]に#ruby[も][持]って#ruby[い][行]ってください。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. I want to register my address.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* I see. You need identification.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* If you are from another country, you also need your passport.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Yes. Here it is.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Thank you. Please write your name and address on this form.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* I don't know how to fill this in. Can you help me?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Yes. Write your name here, and your address here.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Thank you. Where do I submit it?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Staff:* Please take it to counter number two.]]

=== #ruby[ひと][人]と#ruby[ひと][人] (Social)

#dialog-block[#ruby[わたし][私]の#ruby[こと][事]を#ruby[い][言]う (Introducing Yourself)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* こんにちは。ここに#ruby[あたら][新]しく#ruby[き][来]ました。#ruby[わたし][私]はたなかです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* こんにちは。#ruby[わたし][私]はやまもとです。#ruby[いえ][家]が#ruby[ちか][近]い#ruby[ひと][人]です。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* よろしくください。#ruby[わたし][私]は#ruby[ほか][他]の#ruby[くに][国]から#ruby[き][来]ました。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そうですか。この#ruby[くに][国]の#ruby[ことば][言葉]がとても#ruby[よ][良]いですね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとうございます。まだ#ruby[すこ][少]しだけです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[なに][何]か#ruby[わ][分]からない#ruby[こと][事]があったら、#ruby[い][言]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとうございます。とても#ruby[たす][助]かります。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Hello. I just moved here. I'm Tanaka.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Hello. I'm Yamamoto. I'm your neighbor.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Nice to meet you. I came from another country.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Is that so? Your Japanese is very good.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Thank you. I only know a little.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* If there's anything you don't understand, please tell me.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Thank you. That helps a lot.]]

#dialog-block[もう#ruby[ひと][一]つください (Asking Someone to Repeat)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。#ruby[いま][今]の#ruby[ことば][言葉]が#ruby[わ][分]かりませんでした。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* すみません。もう#ruby[ひと][一]つ#ruby[い][言]いましょうか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* はい。もう#ruby[すこ][少]し#ruby[はや][速]くなく#ruby[い][言]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* この#ruby[みち][道]を#ruby[い][行]って、#ruby[おお][大]きい#ruby[き][木]の#ruby[まえ][前]で#ruby[みぎ][右]です。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[みち][道]を#ruby[い][行]って……#ruby[みぎ][右]。すみません、#ruby[か][書]いてもらえますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。ここに#ruby[か][書]きます。これで#ruby[わ][分]かりますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* はい！#ruby[か][書]いた#ruby[もの][物]は#ruby[わ][分]かります。ありがとうございます。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. I didn't understand what you just said.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Sorry. Shall I say it again?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Yes. Please say it more slowly.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Go along this road, and turn right at the big tree.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Go along the road... right. Sorry, could you write it down?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. I'll write it here. Can you understand this?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Yes! I can understand the writing. Thank you.]]

#dialog-block[#ruby[いえ][家]が#ruby[ちか][近]い#ruby[ひと][人] (The Neighbor)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。この#ruby[もの][物]は#ruby[いま][今]の#ruby[にち][日]に#ruby[そと][外]に#ruby[だ][出]してもいいですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* いいえ。#ruby[いま][今]の#ruby[にち][日]は#ruby[ちが][違]います。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* そうですか。いつが#ruby[よ][良]いですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* この#ruby[もの][物]は#ruby[つき][月]の#ruby[にち][日]とお#ruby[かね][金]の#ruby[にち][日]に#ruby[だ][出]します。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[か][書]く#ruby[もの][物]はいつですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[か][書]く#ruby[もの][物]は#ruby[みず][水]の#ruby[にち][日]です。#ruby[にち][日]の#ruby[なか][中]の#ruby[まえ][前]に#ruby[だ][出]してください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わ][分]かりました。ありがとうございます。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[わ][分]からない#ruby[こと][事]があったら、#ruby[き][聞]いてください。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Excuse me. Can I put this out today?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* No. Today is not the right day.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* I see. When is good?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* This goes out on Monday and Friday.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* When is paper?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Paper is on Wednesday. Please put it out in the morning.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* I understand. Thank you.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* If you don't understand something, please ask.]]

#dialog-block[#ruby[そら][空]の#ruby[こと][事]の#ruby[はなし][話] (Weather Small Talk)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[いま][今]の#ruby[にち][日]は#ruby[そら][空]がとてもきれいですね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そうですね。#ruby[たいよう][太陽]が#ruby[で][出]ていて、#ruby[かぜ][風]も#ruby[よ][良]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* でも#ruby[あと][後]から#ruby[あめ][雨]が#ruby[く][来]ると#ruby[き][聞]きました。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ほんとう][本当]ですか。#ruby[あめ][雨]の#ruby[もの][物]を#ruby[も][持]った#ruby[ほう][方]がいいですね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[いま][今]の#ruby[にち][日]は#ruby[なに][何]をしますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[あめ][雨]の#ruby[まえ][前]に#ruby[そと][外]を#ruby[ある][歩]きたいです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[よ][良]いですね。#ruby[よ][良]い#ruby[にち][日]にしましょう。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* The sky is very beautiful today.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. The sun is out, and the wind is nice.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* But I heard it will rain later.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Really? We should bring an umbrella.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* What are you doing today?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* I want to walk outside before the rain.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* That's nice. Let's make it a good day.]]

=== #ruby[かんが][考]える#ruby[はな][話]し (Thinking Dialogs)

#dialog-block[#ruby[い][生]きるとは#ruby[なに][何]か (What Is Life?)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[いし][石]は#ruby[うご][動]かない。#ruby[くさ][草]は#ruby[うご][動]く。#ruby[なに][何]が#ruby[い][生]き#ruby[もの][物]を#ruby[い][生]きている#ruby[もの][物]にする？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[うご][動]くだけじゃない。#ruby[みず][水]も#ruby[うご][動]く。#ruby[ひ][火]も#ruby[うご][動]く。でもそれは#ruby[い][生]きていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* じゃあ#ruby[なに][何]だ？#ruby[い][生]き#ruby[もの][物]には#ruby[なに][何]があって#ruby[いし][石]にはない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[い][生]きる#ruby[かぜ][風]だ。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]が#ruby[い][生]き#ruby[もの][物]に#ruby[い][生]きる#ruby[かぜ][風]を#ruby[あた][与]えた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[い][生]きる#ruby[かぜ][風]？#ruby[わたし][私]たちが#ruby[の][飲]む#ruby[かぜ][風]と#ruby[おな][同]じ？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* でも#ruby[ちが][違]う#ruby[かぜ][風]だ。それがないと#ruby[からだ][体]は#ruby[つち][土]と#ruby[みず][水]だけだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ぜんぶ][全部]の#ruby[い][生]き#ruby[もの][物]に#ruby[い][生]きる#ruby[かぜ][風]がある。でも#ruby[ひと][人]は#ruby[ほか][他]の#ruby[い][生]き#ruby[もの][物]と#ruby[ちが][違]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]は#ruby[ひと][人]をその#ruby[ひと][人]に#ruby[ちか][近]く#ruby[つく][作]った。だから#ruby[ひと][人]は#ruby[ぜんぶ][全部]の#ruby[い][生]き#ruby[もの][物]の#ruby[なか][中]でもっとも#ruby[おお][大]きい。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* A stone doesn't move. Grass moves. What makes something alive?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Not just moving. Water moves too. Fire moves too. But those aren't alive.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Then what is it? What do living things have that stones don't?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* The breath of life. The one who made everything gave the breath of life to living things.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* The breath of life? Is it the same as the air we breathe?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* But it is a different breath. Without it the body is only earth and water.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* All living things have the breath of life. But are humans different from other living things?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. The one who made everything made humans close to himself. That is why humans are the greatest of all living things.]]

#dialog-block[#ruby[よる][夜]の#ruby[ひかり][光] (The Lights of Night)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[よる][夜]の#ruby[そら][空]の#ruby[ひかり][光]は#ruby[なん][何]だと#ruby[おも][思]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* あの#ruby[ひかり][光]は#ruby[ぜんぶ][全部]の#ruby[はじ][始]まりの#ruby[とき][時]に#ruby[そら][空]に#ruby[あた][与]えられた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[はじ][始]まりの#ruby[とき][時]に？#ruby[ひと][人]より#ruby[まえ][前]に？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]が#ruby[そら][空]と#ruby[つち][土]を#ruby[つく][作]った#ruby[あと][後]に#ruby[そら][空]に#ruby[ひかり][光]を#ruby[あた][与]えた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* じゃああの#ruby[ひかり][光]は#ruby[ひかり][光]だけじゃない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[み][見]#ruby[まも][守]る#ruby[もの][物]だ。#ruby[そら][空]に#ruby[あた][与]えられた#ruby[つか][使]いだ。#ruby[うえ][上]から#ruby[わたし][私]たちを#ruby[み][見]#ruby[まも][守]っている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[うえ][上]からの#ruby[つか][使]い？#ruby[はじ][始]まりの#ruby[とき][時]からそこにいる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[つち][土]と#ruby[うみ][海]が#ruby[つく][作]られた#ruby[とき][時]から#ruby[か][変]わっていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* だから#ruby[まい][毎]#ruby[よる][夜]#ruby[か][変]わらない#ruby[ひかり][光]がある。いつも#ruby[うえ][上]から#ruby[み][見]#ruby[まも][守]っている。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* What do you think the lights in the night sky are?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Those lights were placed in the sky at the very beginning.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* At the beginning? Before people?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. The one who made everything placed lights in the sky after making the heavens and the earth.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* So those lights are not just lights?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* They are watchers. Messengers given to the sky. They watch over us from above.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Messengers from above? Have they been there since the beginning?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. They have not changed since the earth and sea were made.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* That is why the same lights appear every night. Always watching from above.]]

#dialog-block[なぜ#ruby[ひと][人]は#ruby[たたか][戦]うの？ (Why Do People Fight?)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[ちち][父]さん、なぜ#ruby[ひと][人]は#ruby[たたか][戦]うの？#ruby[たたか][戦]うと#ruby[かな][悲]しいことが#ruby[お][起]こるのに。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* そうだね。#ruby[ひと][人]は#ruby[こわ][怖]い#ruby[とき][時]に#ruby[す][好]きな#ruby[もの][物]を#ruby[まも][守]りたくなる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* でも#ruby[たたか][戦]って#ruby[まも][守]れるの？#ruby[たたか][戦]うともっと#ruby[かな][悲]しいことが#ruby[お][起]こる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* #ruby[ほんとう][本当]にそうだ。#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[つよ][強]い#ruby[まも][守]り#ruby[かた][方]は#ruby[す][好]きでいることだ。#ruby[わたし][私]を#ruby[す][好]きなように#ruby[ほか][他]の#ruby[ひと][人]も#ruby[す][好]きでいること。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* でも#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]は？#ruby[たたか][戦]いに#ruby[く][来]る#ruby[ひと][人]は？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* その#ruby[ひと][人]たちもだ。#ruby[わたし][私]に#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]も#ruby[す][好]きでいる。それが#ruby[ひと][人]にできる#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[つよ][強]い#ruby[こと][事]だ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[わたし][私]に#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]を#ruby[す][好]きでいるの？それはとてもできにくいと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* できにくい。でも#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]がそう#ruby[い][言]った。#ruby[わたし][私]を#ruby[す][好]きなように#ruby[ほか][他]の#ruby[ひと][人]を#ruby[す][好]きでいなさい。#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]も。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* Father, why do people fight? Fighting causes sad things to happen.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Father:* That's right. When people are afraid, they want to protect what they love.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* But can you protect by fighting? Fighting creates more sadness.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Father:* That is truly so. The strongest way to protect is to love. Love others the way you love yourself.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* But what about people who do bad things? People who come to fight?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Father:* Even them. Love even those who do bad things to you. That is the strongest thing a person can do.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Child:* Love people who do bad things to me? I think that is very hard.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*Father:* It is hard. But the one who made everything said so. Love others as you love yourself. Even those who act against you.]]

#dialog-block[#ruby[ひと][人]だけが#ruby[も][持]つ#ruby[もの][物] (What Only Humans Have)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[どうぶつ][動物]も#ruby[た][食]べて、#ruby[の][飲]んで、#ruby[こども][子供]を#ruby[まも][守]る。#ruby[ひと][人]と#ruby[ほんとう][本当]に#ruby[ちが][違]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ひと][人]は#ruby[か][書]く。#ruby[あ][会]ったことのない#ruby[ひと][人]に#ruby[ことば][言葉]を#ruby[あた][与]える。#ruby[し][死]んだ#ruby[あと][後]も。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それは#ruby[おお][大]きい。#ruby[どうぶつ][動物]は#ruby[いま][今]に#ruby[い][生]きる。#ruby[ひと][人]は#ruby[まえ][前]と#ruby[あと][後]に#ruby[い][生]きる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ひと][人]は#ruby[うご][動]く#ruby[もの][物]も#ruby[つく][作]る。#ruby[て][手]でできないことを#ruby[うご][動]く#ruby[もの][物]でできるようにする。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* でも#ruby[いし][石]を#ruby[つか][使]う#ruby[どうぶつ][動物]もいる。#ruby[ひと][人]だけが#ruby[もの][物]を#ruby[つか][使]うのではない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[もの][物]を#ruby[つか][使]うことと、#ruby[もの][物]について#ruby[かんが][考]えることは#ruby[ちが][違]う。#ruby[ひと][人]は#ruby[み][見]えない#ruby[こと][事]を#ruby[かんが][考]える。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[み][見]えない#ruby[こと][事]？　どんな#ruby[こと][事]？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* 「なぜ#ruby[い][生]きるのか」。#ruby[どうぶつ][動物]はこれを#ruby[き][聞]かない。#ruby[ひと][人]だけが#ruby[き][聞]く。それが#ruby[よ][良]いことか#ruby[わる][悪]いことかは、まだ#ruby[し][知]らない。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Animals eat, drink, protect their young too. Are humans truly different?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Humans write. They give words to people they've never met. Even after death.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* That's significant. Animals live in the now. Humans live in the before and after.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Humans also make machines - things that allow them to do what hands alone cannot.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* But there are animals that use stones too. Humans are not the only ones who use things.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Using a thing and thinking about a thing are different. Humans think about things they cannot see.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Invisible things? What kind of things?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* \"Why do we live?\" Animals don't ask this. Only humans ask it. Whether that's good or bad - we still don't know.]]

#dialog-block[#ruby[とき][時]について (On Time)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[ところ][所]に#ruby[き][来]て、#ruby[おお][多]い#ruby[とし][年]が#ruby[お][終]わった。あの#ruby[き][木]は#ruby[まえ][前]に#ruby[ちい][小]さかった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[き][木]は#ruby[か][変]わった。でも#ruby[やま][山]は#ruby[か][変]わっていない。#ruby[とき][時]は#ruby[もの][物]によって#ruby[ちが][違]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]たちも#ruby[か][変]わった。#ruby[からだ][体]が#ruby[か][変]わった。でも……#ruby[こころ][心]の#ruby[なか][中]はどうだろう。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[こども][子供]の#ruby[とき][時]に#ruby[かん][感]じた#ruby[こと][事]は、まだ#ruby[こころ][心]の#ruby[なか][中]にある。#ruby[か][変]わっていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[とき][時]は#ruby[まえ][前]に#ruby[うご][動]くだけ？　#ruby[まえ][前]に#ruby[い][行]くことはできない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[からだ][体]は#ruby[まえ][前]に#ruby[い][行]けない。でも#ruby[こころ][心]は#ruby[い][行]ける。#ruby[ほん][本]の#ruby[なか][中]で、#ruby[め][目]を#ruby[し][閉]めた#ruby[なか][中]で。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それなら#ruby[とき][時]は#ruby[ふた][二]つある。#ruby[からだ][体]の#ruby[とき][時]と、#ruby[こころ][心]の#ruby[とき][時]と。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そして#ruby[わたし][私]たちが#ruby[し][死]んだ#ruby[あと][後]も、あなたと#ruby[わたし][私]が#ruby[かん][感]じた#ruby[こと][事]は#ruby[ほか][他]の#ruby[ひと][人]の#ruby[こころ][心]の#ruby[なか][中]で#ruby[い][生]きるかもしれない。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Many years have ended since we came to this place. That tree was small before.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* The tree has changed. But the mountain hasn't changed. Time differs depending on the thing.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* We have changed too. Our bodies have changed. But... what about inside our hearts?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* What we felt as children is still inside our hearts. Unchanged.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Does time only move forward? Can we not go back?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* The body cannot go back. But the heart can - inside books, inside closed eyes.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Then there are two times: the time of the body, and the time of the heart.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* And even after we die, what you and I felt may go on living inside the hearts of other people.]]

#dialog-block[#ruby[し][知]ること (Learning)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[おし][教]える#ruby[ひと][人]、#ruby[ほん][本]を#ruby[よ][読]んだら、その#ruby[こと][事]を#ruby[し][知]っていると#ruby[い][言]えるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ほん][本]の#ruby[ことば][言葉]は#ruby[し][知]ることができる。でも、#ruby[ほんとう][本当]に#ruby[し][知]ることは#ruby[ちが][違]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* どう#ruby[ちが][違]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[て][手]で#ruby[つく][作]ったり、#ruby[からだ][体]で#ruby[かん][感]じたりしたとき、#ruby[ほんとう][本当]に#ruby[し][知]る#ruby[こと][事]が#ruby[はじ][始]まる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* では、#ruby[わたし][私]はまだ#ruby[し][知]らないのか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[し][知]りたいと#ruby[おも][思]っているなら、もう#ruby[はじ][始]まっている。それで#ruby[よ][良]いと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[し][知]ることは#ruby[お][終]わるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[よ][良]い#ruby[おし][教]える#ruby[ひと][人]も、まだ#ruby[し][知]らない#ruby[こと][事]がとても#ruby[おお][多]いと#ruby[かん][感]じている。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Teacher, if I have read a book, can I say I know that thing?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* You can know the words of a book. But truly knowing is different.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* How is it different?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* When you have made something with your hands, felt something in your body - that is when truly knowing begins.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Then I do not know yet?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* If you want to know, it has already begun. I think that is enough.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Does knowing ever end?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Even a good teacher feels there are still very many things they do not know.]]

#dialog-block[#ruby[うみ][海]の#ruby[そと][外] (The Sea)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[うみ][海]はとても#ruby[おお][大]きいね。#ruby[そと][外]に#ruby[なに][何]があるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ほか][他]の#ruby[くに][国]がある。でも#ruby[め][目]では#ruby[み][見]えない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* その#ruby[くに][国]の#ruby[ひと][人]たちも、この#ruby[みず][水]を#ruby[み][見]ていると#ruby[おも][思]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、#ruby[ぜんぶ][全部]#ruby[ひと][一]つの#ruby[みず][水]だ。#ruby[うみ][海]は#ruby[ひと][一]つだと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[みず][水]の#ruby[なか][中]に#ruby[なに][何]がいるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[どうぶつ][動物]が#ruby[おお][多]くいる。#ruby[わたし][私]たちが#ruby[し][知]らない#ruby[どうぶつ][動物]も、まだいると#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[うみ][海]は#ruby[こわ][怖]いか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[こわ][怖]い。でも#ruby[うみ][海]の#ruby[おと][音]を#ruby[き][聞]くと、#ruby[こころ][心]が#ruby[よ][良]くなる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]もそう#ruby[かん][感]じる。#ruby[おお][大]きい#ruby[もの][物]の#ruby[まえ][前]に#ruby[た][立]つと、#ruby[こころ][心]が#ruby[ちい][小]さくなる。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* This sea is very large. What is on the other side?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* There are other countries. But you cannot see them with your eyes.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Do you think the people of those countries are also looking at this water?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes, it is all one water. I think the sea is one.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* What lives inside the water?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Many animals. I think there are still animals we do not know.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Is the sea frightening?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* It is frightening. But when I hear the sound of the sea, my heart becomes well.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* I feel that too. Standing before something vast, my heart becomes small.]]

#dialog-block[#ruby[あたら][新]しいものと#ruby[まえ][前]のもの (Old and New)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[くに][国]はとても#ruby[か][変]わったね。#ruby[まえ][前]は#ruby[ちが][違]った。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。#ruby[あたら][新]しい#ruby[おお][大]きい#ruby[いえ][家]が#ruby[おお][多]くなった。#ruby[まえ][前]からある#ruby[いえ][家]は#ruby[すく][少]なくなった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[まえ][前]からある#ruby[みち][道]も#ruby[か][変]わった。#ruby[まえ][前]は#ruby[き][木]が#ruby[おお][多]かった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[あたら][新]しいものは#ruby[よ][良]いか、#ruby[わる][悪]いか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[あたら][新]しい#ruby[うご][動]く#ruby[もの][物]で、#ruby[ひと][人]がする#ruby[こと][事]が#ruby[はや][速]くなった。でも#ruby[まえ][前]にしていた#ruby[こと][事]を#ruby[し][知]っている#ruby[ひと][人]が#ruby[すく][少]なくなっている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ことば][言葉]も#ruby[か][変]わる。#ruby[まえ][前]の#ruby[ひと][人]たちの#ruby[ことば][言葉]は#ruby[いま][今]もあるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ほん][本]の#ruby[なか][中]にある。でも#ruby[つか][使]う#ruby[ひと][人]は#ruby[すこ][少]しだけだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[か][変]わらない#ruby[こと][事]はあるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[やま][山]と#ruby[うみ][海]はまだ#ruby[か][変]わらない。#ruby[たいよう][太陽]も#ruby[まい][毎]#ruby[にち][日]#ruby[で][出]る。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* This country has changed a great deal. Before, it was different.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Yes. There are many more new buildings. The houses that were here before have grown few.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* The old roads have also changed. Before, there were many trees.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Are new things good, or bad?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* With new machines, the things people do have become faster. But people who know the earlier ways of doing things are growing fewer.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Even words change. Do the words of the people before us still exist?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* They exist inside books. But only a few people use them.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Is there anything that does not change?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* The mountains and sea have not changed. The sun still rises every day.]]

#dialog-block[#ruby[おと][音]と#ruby[こころ][心] (Music and Feelings)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* あの#ruby[ひと][人]が#ruby[つく][作]った#ruby[おと][音]を#ruby[き][聞]くと、#ruby[かな][悲]しくなる。なぜか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[わたし][私]もそう#ruby[かん][感]じる。その#ruby[おと][音]は#ruby[なに][何]かを#ruby[かん][感]じさせる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ことば][言葉]は#ruby[つか][使]っていない。でも#ruby[こころ][心]に#ruby[はい][入]る。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ことば][言葉]より#ruby[まえ][前]に、#ruby[からだ][体]が#ruby[かん][感]じると#ruby[おも][思]う。#ruby[あめ][雨]の#ruby[おと][音]や#ruby[かぜ][風]の#ruby[おと][音]も、#ruby[こころ][心]を#ruby[うご][動]かす。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* では、#ruby[ひと][人]が#ruby[つく][作]る#ruby[おと][音]と#ruby[やま][山]や#ruby[うみ][海]の#ruby[おと][音]は#ruby[ちが][違]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ちが][違]うと#ruby[おも][思]う。#ruby[ひと][人]が#ruby[つく][作]る#ruby[おと][音]の#ruby[なか][中]には、その#ruby[ひと][人]の#ruby[こころ][心]がある。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[かな][悲]しい#ruby[おと][音]を#ruby[き][聞]いて、なぜ#ruby[たの][楽]しいと#ruby[かん][感]じるか。#ruby[へん][変]だね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[かな][悲]しさを#ruby[かん][感]じていい、と#ruby[おも][思]えるからかもしれない。#ruby[ひと][一]りじゃないと#ruby[かん][感]じる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* その#ruby[おと][音]を#ruby[つく][作]った#ruby[ひと][人]も、その#ruby[かな][悲]しさを#ruby[し][知]っていたのだね。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* When I hear the sounds that person made, I become sad. Why is that?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* I feel the same. Those sounds cause something to be felt.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* No words are used. Yet it enters the heart.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* I think the body feels it before words do. The sound of rain, the sound of wind - these too move the heart.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Then, are sounds made by people different from the sounds of mountains and sea?]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* I think they are different. Inside the sounds a person makes, there is that person's heart.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* Hearing a sad sound, why do I feel something like joy? It is strange.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* Perhaps because it lets you feel that sadness is allowed. You feel you are not alone.]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* The person who made those sounds also knew that sadness.]]

== #ruby[なが][長]くない#ruby[はな][話]し (Short Stories)

#story-block[#ruby[やま][山] (The Mountain)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[ひと][一]りで#ruby[やま][山]に#ruby[い][行]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[みち][道]は#ruby[なが][長]くて、#ruby[いし][石]が#ruby[おお][多]かった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[あし][足]が#ruby[おも][重]くなった。でも#ruby[と][止]めなかった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[うえ][上]に#ruby[い][行]くと、#ruby[かぜ][風]が#ruby[つよ][強]くなった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[そら][空]はとても#ruby[あか][明]るくて、#ruby[たいよう][太陽]の#ruby[ひかり][光]が#ruby[ぜんぶ][全部]の#ruby[もの][物]に#ruby[はい][入]っていた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[すわ][座]って、#ruby[した][下]の#ruby[うみ][海]を#ruby[み][見]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いえ][家]のことを#ruby[おも][思]った。#ruby[はは][母]のことを#ruby[おも][思]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[まえ][前]の#ruby[とし][年]に#ruby[わる][悪]いことが#ruby[おお][多]くあった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[でも#ruby[いま][今]、#ruby[やま][山]の#ruby[うえ][上]で、その#ruby[こと][事]は#ruby[ちい][小]さくなった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[かぜ][風]が#ruby[き][来]て、#ruby[わたし][私]の#ruby[からだ][体]に#ruby[はい][入]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[め][目]を#ruby[し][閉]めた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[こころ][心]の#ruby[なか][中]で、#ruby[なに][何]かが#ruby[か][変]わった。]][I went to the mountain alone. The road was long and full of stones. My legs became heavy. But I did not stop. Going up, the wind grew strong. The sky was very bright, and the sun's light filled everything. I sat down and looked at the sea below. I thought of home. I thought of my mother. In the past year there had been many bad things. But now, on top of the mountain, those things became small. The wind came and passed through me. I closed my eyes. Inside my heart, something changed.]

#story-block[#ruby[ふた][二]つの#ruby[くに][国] (Two Countries)][#block(inset: (top: 0.15em, bottom: 0.15em))[ある#ruby[くに][国]の#ruby[ひと][人]は#ruby[うみ][海]の#ruby[ちか][近]くにいた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[もう#ruby[ひと][一]つの#ruby[くに][国]の#ruby[ひと][人]は#ruby[やま][山]の#ruby[なか][中]にいた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[うみ][海]の#ruby[くに][国]の#ruby[ひと][人]は#ruby[みず][水]を#ruby[し][知]っていた。#ruby[やま][山]の#ruby[くに][国]の#ruby[ひと][人]は#ruby[つち][土]と#ruby[き][木]を#ruby[し][知]っていた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[ある#ruby[にち][日]、#ruby[ひと][一]りの#ruby[おとこ][男]が#ruby[やま][山]から#ruby[で][出]て、#ruby[うみ][海]まで#ruby[い][行]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[うみ][海]で#ruby[おんな][女]が#ruby[みず][水]の#ruby[ちか][近]くに#ruby[すわ][座]っていた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[おとこ][男]は#ruby[うみ][海]を#ruby[み][見]た。#ruby[こわ][怖]かった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[おんな][女]は#ruby[おとこ][男]の#ruby[め][目]を#ruby[み][見]て、#ruby[わら][笑]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「#ruby[こわ][怖]くないよ」と#ruby[おんな][女]は#ruby[い][言]った。「#ruby[はい][入]ってみて。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[おとこ][男]は#ruby[すこ][少]し#ruby[はい][入]った。#ruby[みず][水]はとても#ruby[さむ][寒]かった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ふた][二]りの#ruby[ことば][言葉]は#ruby[ちが][違]った。でも#ruby[わら][笑]いは#ruby[おな][同]じだった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[よる][夜]、#ruby[ふた][二]りは#ruby[ひ][火]の#ruby[ちか][近]くに#ruby[すわ][座]って、#ruby[た][食]べ#ruby[もの][物]を#ruby[た][食]べた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[つき][月]が#ruby[そら][空]に#ruby[で][出]ていた。#ruby[ふた][二]つの#ruby[くに][国]から#ruby[み][見]ても、#ruby[ひと][一]つの#ruby[つき][月]だ。]][The people of one country lived near the sea. The people of another country lived inside the mountains. The sea people knew water. The mountain people knew soil and trees. One day, a man left the mountains and walked to the sea. At the shore, a woman was sitting near the water. The man looked at the sea. He was afraid. The woman saw his eyes and laughed. \"It's not frightening,\" she said. \"Try going in.\" He went in a little. The water was so cold. The two had different words. But their laughter was no different. That night they sat near a fire and ate together. The moon was out in the sky - one moon, seen from two countries.]

#story-block[#ruby[おお][大]きい#ruby[き][木] (The Old Tree)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[やま][山]の#ruby[なか][中]に#ruby[ひと][一]つの#ruby[おお][大]きい#ruby[き][木]があった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[その#ruby[き][木]はとても#ruby[なが][長]い#ruby[とき][時]を#ruby[い][生]きていた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[き][木]は#ruby[おお][多]くの#ruby[あめ][雨]を#ruby[し][知]っていた。#ruby[おお][多]くの#ruby[かぜ][風]を#ruby[かん][感]じていた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[こども][子供]たちが#ruby[き][来]て、#ruby[き][木]の#ruby[うえ][上]で#ruby[たの][楽]しんだ。その#ruby[こども][子供]たちは#ruby[おお][大]きくなって、#ruby[で][出]て#ruby[い][行]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[たたか][戦]いがあった。#ruby[ひと][人]たちは#ruby[き][木]の#ruby[ちか][近]くで#ruby[な][泣]いた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[き][木]は#ruby[うご][動]かなかった。#ruby[た][立]っているだけだった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[どうぶつ][動物]たちが#ruby[き][木]の#ruby[なか][中]に#ruby[はい][入]って、#ruby[ね][寝]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[くさ][草]が#ruby[まい][毎]#ruby[とし][年]#ruby[き][木]の#ruby[ちか][近]くに#ruby[で][出]てきた。そして#ruby[お][終]わった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[でも#ruby[き][木]はまだある。]
#block(inset: (top: 0.15em, bottom: 0.15em))[ある#ruby[にち][日]の#ruby[よる][夜]、#ruby[ひと][一]りの#ruby[おんな][女]が#ruby[き][来]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[おんな][女]は#ruby[き][木]に#ruby[て][手]を#ruby[も][持]って、#ruby[なに][何]も#ruby[い][言]わなかった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[き][木]も#ruby[なに][何]も#ruby[い][言]わなかった。でも#ruby[ふた][二]つの#ruby[こころ][心]は#ruby[ひと][一]つになった。]][In the mountains there was one great tree. It had been alive for a very long time. The tree knew many rains. It had felt many winds. Children came and played up in its branches. Those children grew large and went away. There was fighting. People cried near the tree. The tree did not move. It only stood. Animals entered the tree and slept. Flowers came up near the tree every year. And then ended. But the tree is still here. One evening a woman came. She placed her hand against the tree and said nothing. The tree also said nothing. But their two hearts became one.]

#story-block[#ruby[こども][子供]の「なぜ」 (A Child's Question)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[こども][子供]はいつも「なぜ？」と#ruby[き][聞]いた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「なぜ#ruby[そら][空]は#ruby[あお][青]いの？」と#ruby[ちち][父]に#ruby[き][聞]いた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちち][父]は「#ruby[ひかり][光]だよ」と#ruby[い][言]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「なぜ#ruby[ひかり][光]は#ruby[あお][青]くなるの？」と#ruby[こども][子供]は#ruby[い][言]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちち][父]は#ruby[かんが][考]えた。「#ruby[そら][空]だよ」と#ruby[い][言]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「なぜ#ruby[そら][空]はそこにあるの？」]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちち][父]は#ruby[くち][口]を#ruby[し][閉]めた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「なぜ#ruby[わたし][私]は#ruby[い][生]きているの？」と#ruby[こども][子供]は#ruby[い][言]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちち][父]は#ruby[こども][子供]を#ruby[み][見]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[よる][夜]になって、#ruby[ふた][二]りは#ruby[そと][外]に#ruby[で][出]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[そら][空]に#ruby[おお][多]くの#ruby[ひかり][光]があった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[こども][子供]は「きれい」と#ruby[い][言]った。#ruby[いま][今]は「なぜ」を#ruby[い][言]わなかった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちち][父]はその#ruby[こと][事]を#ruby[かん][感]じて、#ruby[わら][笑]った。]][The child always asked \"why?\" \"Why is the sky blue?\" she asked her father. \"It's the light,\" he said. \"Why does the light become blue?\" the child said. The father thought. \"It's the air,\" he said. \"Why is the air there?\" The father closed his mouth. \"Why am I alive?\" the child said. The father looked at the child. When night came, the two went outside. There were many lights in the sky. The child said \"beautiful.\" This time she did not say \"why.\" The father felt that, and smiled.]

#story-block[#ruby[いぬ][犬]と#ruby[とり][鳥] (The Dog and the Bird)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]の#ruby[いぬ][犬]は#ruby[まい][毎]#ruby[にち][日]#ruby[そと][外]を#ruby[ある][歩]く。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いま][今]#ruby[にち][日]も#ruby[みち][道]を#ruby[ある][歩]いていた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[そら][空]に#ruby[しろ][白]い#ruby[くも][雲]があった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[その#ruby[くも][雲]の#ruby[した][下]で、#ruby[とり][鳥]が#ruby[と][飛]んでいた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[うえ][上]を#ruby[み][見]て、#ruby[うご][動]かなくなった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[と][飛]びたいと#ruby[おも][思]った。でも#ruby[あし][足]は#ruby[つち][土]の#ruby[うえ][上]にある。]
#block(inset: (top: 0.15em, bottom: 0.15em))[その#ruby[とき][時]、#ruby[ちい][小]さい#ruby[とり][鳥]が#ruby[いち][一]つ、#ruby[き][木]の#ruby[した][下]に#ruby[き][来]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちい][小]さい#ruby[とり][鳥]は#ruby[ある][歩]いていた。#ruby[と][飛]ばなかった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]と#ruby[とり][鳥]は#ruby[おな][同]じ#ruby[みち][道]を#ruby[ある][歩]いた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[わ][分]かった。#ruby[そら][空]を#ruby[と][飛]ばなくても、#ruby[おな][同]じ#ruby[ところ][所]に#ruby[い][行]ける。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ふた][二]つの#ruby[どうぶつ][動物]は、#ruby[おな][同]じ#ruby[かぜ][風]を#ruby[かん][感]じていた。]][My dog walks outside every day. Today too, she was walking along the road. There were white clouds in the sky. Under those clouds, birds were flying. The dog looked up and stopped moving. The dog wanted to fly. But her legs are on the ground. Just then, one small bird came down under a tree. The small bird was walking. It was not flying. The dog and the bird walked the same road. The dog understood. Even without flying through the sky, you can go to the same place. The two animals were feeling the same wind.]

#story-block[#ruby[とお][遠]い#ruby[ところ][所]の#ruby[さかな][魚] (Fish from a Far Place)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[はら][腹]に#ruby[た][食]べ#ruby[もの][物]がなかった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[そと][外]に#ruby[で][出]て、#ruby[た][食]べ#ruby[もの][物]を#ruby[か][買]いに#ruby[い][行]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「すみません。#ruby[さかな][魚]はありますか。」と#ruby[き][聞]いた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[おとこ][男]の#ruby[ひと][人]は#ruby[い][言]った。「はい、あります。この#ruby[さかな][魚]は#ruby[とお][遠]い#ruby[うみ][海]から#ruby[き][来]ました。とても#ruby[よ][良]い#ruby[さかな][魚]です。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[「#ruby[にく][肉]もありますか。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[「はい。#ruby[にく][肉]と#ruby[たまご][卵]もあります。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[さかな][魚]と#ruby[たまご][卵]を#ruby[えら][選]んだ。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「#ruby[ぜんぶ][全部]でいくらですか。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[「#ruby[さん][三]#ruby[びゃく][百]です。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[すこ][少]し#ruby[たか][高]いと#ruby[おも][思]った。でも#ruby[とお][遠]い#ruby[ところ][所]の#ruby[さかな][魚]だから。]
#block(inset: (top: 0.15em, bottom: 0.15em))[お#ruby[かね][金]を#ruby[あた][与]えて、#ruby[いえ][家]に#ruby[き][来]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[さかな][魚]と#ruby[たまご][卵]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[はら][腹]に#ruby[た][食]べ#ruby[もの][物]が#ruby[はい][入]って、#ruby[からだ][体]が#ruby[あたた][温]かくなった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[たぶん#ruby[あと][後]の#ruby[にち][日]も、あの#ruby[さかな][魚]を#ruby[か][買]いに#ruby[い][行]く。]][I had no food in my belly. I went outside to buy food. \"Excuse me. Do you have fish?\" I asked. The man said, \"Yes, we do. This fish came from a far sea. It is very good fish.\" \"Do you have meat too?\" \"Yes. We have meat and eggs too.\" I chose fish and eggs. \"How much is it all?\" \"Three hundred.\" I thought it was a little expensive. But the fish is from a far place. I gave the money and went home. I made food with the fish and eggs. Food entered my belly, and my body became warm. Maybe tomorrow I will go buy that fish again.]

#story-block[#ruby[かみ][髪]を#ruby[き][切]る#ruby[ひと][人] (The Barber)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[かみ][髪]が#ruby[なが][長]くなった。#ruby[き][切]る#ruby[とき][時]が#ruby[き][来]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[ある][歩]いて、#ruby[かみ][髪]を#ruby[き][切]る#ruby[ところ][所]に#ruby[い][行]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[なか][中]に#ruby[はい][入]ると、#ruby[おとこ][男]の#ruby[ひと][人]が#ruby[い][言]った。「どうしますか。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[「#ruby[かみ][髪]を#ruby[き][切]ってください。#ruby[すこ][少]しだけ。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[おとこ][男]の#ruby[ひと][人]は#ruby[わたし][私]の#ruby[かみ][髪]を#ruby[て][手]で#ruby[も][持]って、#ruby[み][見]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「#ruby[かみ][髪]がとても#ruby[つよ][強]いですね。」と#ruby[おとこ][男]の#ruby[ひと][人]は#ruby[はな][話]した。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「#ruby[ほんとう][本当]ですか。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[「はい。たぶん#ruby[ほね][骨]も#ruby[つよ][強]いです。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[わら][笑]った。「#ruby[わ][分]かりません。でも#ruby[は][歯]は#ruby[つよ][強]いです。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[おとこ][男]の#ruby[ひと][人]も#ruby[わら][笑]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[「#ruby[あたま][頭]の#ruby[かわ][皮]は#ruby[よ][良]いですか。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[「いいえ、#ruby[すこ][少]し#ruby[あか][赤]いです。#ruby[たいよう][太陽]の#ruby[ひかり][光]が#ruby[つよ][強]かったから。」]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[おとこ][男]の#ruby[ひと][人]はとても#ruby[よ][良]く#ruby[き][切]った。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[お][終]わった#ruby[あと][後]、#ruby[わたし][私]の#ruby[かみ][髪]は#ruby[あたら][新]しくなった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[かみ][髪]を#ruby[き][切]る#ruby[ひと][人]と#ruby[はな][話]すのは#ruby[たの][楽]しかった。]][My hair had gotten long. The time to cut it had come. I walked to the place where they cut hair. When I went in, a man said, \"What would you like?\" \"Please cut my hair. Just a little.\" The man held my hair in his hand and looked. \"Your hair is very strong,\" the man said. \"Really?\" \"Yes. Maybe your bones are strong too.\" I laughed. \"I don't know. But my teeth are strong.\" The man laughed too. \"Is the skin on your head okay?\" \"No, it is a little red. The sunlight was strong.\" The man cut very well. After it was done, my hair felt new. Talking with the barber was fun.]

== #ruby[すこ][少]しの#ruby[こと][言]#ruby[ば][葉] (Haiku)

=== #ruby[そと][外]の#ruby[もの][物] (Nature)

#haiku-block[#ruby[やま][山]の#ruby[うえ][上] #linebreak() #ruby[かぜ][風]が#ruby[き][来]ている #linebreak() #ruby[そら][空]#ruby[あお][青]い][Upon the mountain, wind arrives. The sky, so blue]

#haiku-block[#ruby[あめ][雨]の#ruby[おと][音] #linebreak() #ruby[そと][外]に#ruby[き][聞]こえる #linebreak() #ruby[よる][夜]の#ruby[みち][道]][Sound of falling rain, heard from beyond the walls, a road at night]

#haiku-block[#ruby[うみ][海]の#ruby[みず][水] #linebreak() #ruby[おお][大]きく#ruby[うご][動]く #linebreak() #ruby[しろ][白]い#ruby[いし][石]][Water of the sea, moving in great swells, white stones on the shore]

#haiku-block[#ruby[しろ][白]い#ruby[つき][月] #linebreak() #ruby[みず][水]の#ruby[うえ][上]#ruby[で][出]る #linebreak() #ruby[よる][夜]の#ruby[うみ][海]][A white moon rises above the water, the nighttime sea]

#haiku-block[#ruby[くも][雲]が#ruby[く][来]る #linebreak() #ruby[とり][鳥]が#ruby[と][飛]んでる #linebreak() #ruby[あめ][雨]の#ruby[まえ][前]][Clouds are rolling in, birds still flying overhead, before the rain falls]

#haiku-block[#ruby[さかな][魚]#ruby[い][行]く #linebreak() #ruby[みず][水]で#ruby[ひか][光]って #linebreak() #ruby[うみ][海]の#ruby[おと][音]][Fish swimming along, shining there in the water, sound of the sea]

=== #ruby[まい][毎]#ruby[にち][日] (Daily Life)

#haiku-block[#ruby[みず][水]を#ruby[の][飲]む #linebreak() #ruby[たいよう][太陽]が#ruby[で][出]て #linebreak() #ruby[そと][外]を#ruby[み][見]る][Drinking water, the sun has risen, I gaze outside]

#haiku-block[#ruby[た][食]べ#ruby[もの][物]を #linebreak() #ruby[こども][子供]と#ruby[た][食]べる #linebreak() #ruby[いえ][家]の#ruby[なか][中]][A meal together, eating with the children, inside our home]

#haiku-block[#ruby[みち][道]を#ruby[い][行]く #linebreak() #ruby[おお][大]きい#ruby[き][木]#ruby[み][見]る #linebreak() #ruby[かぜ][風]の#ruby[おと][音]][Walking the path, I see the great trees, the sound of wind]

#haiku-block[#ruby[よる][夜]が#ruby[く][来]る #linebreak() #ruby[つき][月]を#ruby[み][見]ている #linebreak() #ruby[め][目]を#ruby[し][閉]める][Night arrives, watching the moon a while, I close my eyes]

#haiku-block[#ruby[いぬ][犬]#ruby[ある][歩]く #linebreak() #ruby[おな][同]じ#ruby[みち][道]#ruby[い][行]く #linebreak() #ruby[かぜ][風]#ruby[ちが][違]う][The dog is walking, going down the same old road, the wind is different]

#haiku-block[#ruby[はら][腹]が#ruby[い][言]う #linebreak() #ruby[さかな][魚]#ruby[た][食]べたい #linebreak() #ruby[うみ][海]#ruby[とお][遠]い][My belly speaks up: I want to eat some fish, the sea is far away]

=== #ruby[こころ][心] (Heart & Mind)

#haiku-block[#ruby[ひと][人]を#ruby[ま][待]つ #linebreak() #ruby[こころ][心]の#ruby[なか][中]に #linebreak() いつもいる][Waiting for someone, always present within my heart]

#haiku-block[#ruby[たの][楽]しくて #linebreak() #ruby[こども][子供]が#ruby[わら][笑]う #linebreak() #ruby[おと][音]を#ruby[き][聞]く][Joyfully, children laughing, I listen to the sound]

#haiku-block[#ruby[な][泣]く#ruby[こども][子供] #linebreak() #ruby[はは][母]が#ruby[て][手]を#ruby[も][持]つ #linebreak() #ruby[ひかり][光]#ruby[み][見]る][A child in tears, mother takes their hand, they see the light]

#haiku-block[#ruby[ひと][人]に#ruby[あ][会]う #linebreak() #ruby[ことば][言葉]を#ruby[すこ][少]し #linebreak() #ruby[わら][笑]う#ruby[ひと][人]][Meeting someone, just a few small words, a person smiling]

#haiku-block[#ruby[わ][分]かりたい #linebreak() #ruby[こころ][心]で#ruby[わ][分]かる #linebreak() たぶんそう][I want to understand, to know it with the heart, maybe that is it]

#haiku-block[#ruby[はな][話]したい #linebreak() #ruby[ことば][言葉]ない#ruby[とき][時] #linebreak() #ruby[め][目]が#ruby[はな][話]す][Wanting to speak, when there are no words, the eyes do the talking]

=== #ruby[とき][時]の#ruby[か][変]わり (Seasons)

#haiku-block[#ruby[くさ][草]#ruby[ひら][開]く #linebreak() #ruby[やま][山]の#ruby[かぜ][風]#ruby[く][来]る #linebreak() #ruby[くさ][草]#ruby[うご][動]く][Blossoms split open, wind comes pouring down the mountain, the grasses stir]

#haiku-block[#ruby[そら][空]#ruby[あつ][暑]い #linebreak() #ruby[みず][水]を#ruby[の][飲]む#ruby[ひと][人] #linebreak() #ruby[にち][日]#ruby[お][終]わる][The sky burns heavy, a person drinking water, the day is done]

#haiku-block[#ruby[き][木]が#ruby[か][変]わる #linebreak() #ruby[あか][赤]くなる#ruby[やま][山] #linebreak() #ruby[かぜ][風]#ruby[さむ][寒]い][The trees are changing, the mountains going crimson, the wind turns cold]

#haiku-block[#ruby[さむ][寒]い#ruby[よる][夜] #linebreak() #ruby[ひ][火]に#ruby[ちか][近]い#ruby[ひと][人] #linebreak() #ruby[おと][音]もない][A cold night settles, a person drawn close to the fire, not a sound]

=== #ruby[ひと][人]と#ruby[ひと][人] (Between People)

#haiku-block[#ruby[だれ][誰]か#ruby[く][来]る #linebreak() #ruby[し][知]らない#ruby[なまえ][名前] #linebreak() #ruby[わら][笑]う#ruby[ひと][人]][Someone comes, a name unknown, he smiles]

#haiku-block[また#ruby[あ][会]おう #linebreak() と#ruby[い][言]った#ruby[あと][後]に #linebreak() #ruby[みち][道]#ruby[なが][長]い][Let us meet again - the words still drift in the air, the road stretches on]

#haiku-block[あなた#ruby[ま][待]つ #linebreak() #ruby[こ][来]ないと#ruby[し][知]って #linebreak() まだここに][Waiting for you still, knowing well you will not come, here I remain]

#haiku-block[#ruby[て][手]#ruby[あた][与]える #linebreak() もらう#ruby[ひと][人]の#ruby[め][目] #linebreak() #ruby[ひかり][光]#ruby[み][見]た][A hand reaches out, in the eyes of the one who receives, light was seen]

#haiku-block[いいえ#ruby[い][言]う #linebreak() #ruby[こころ][心]#ruby[かな][悲]しい #linebreak() それでいい][I say no to you, the heart is full of sadness, and that is enough]

=== #ruby[い][生]きると#ruby[し][死]ぬ (Life & Death)

#haiku-block[#ruby[はじ][始]まりの #linebreak() #ruby[すこ][少]しの#ruby[からだ][体] #linebreak() #ruby[な][泣]いている][Of the beginning, a body so impossibly small, crying into the world]

#haiku-block[#ruby[い][生]きること #linebreak() #ruby[た][食]べて#ruby[うご][動]いて #linebreak() #ruby[く][来]る#ruby[にち][日]へ][What it means to live: eat, move through the world, toward the coming day]

#haiku-block[#ruby[ひと][人]は#ruby[し][死]ぬ #linebreak() #ruby[つち][土]の#ruby[なか][中]#ruby[い][入]る #linebreak() #ruby[くさ][草]#ruby[い][生]きる][All people must die, entering into the dark earth, the grasses live on]

#haiku-block[#ruby[お][終]わる#ruby[よる][夜] #linebreak() #ruby[ひかり][光]#ruby[はじ][始]まる #linebreak() #ruby[そら][空]はある][The night comes to end, light begins its work again, the sky is still there]

#haiku-block[#ruby[しろ][白]い#ruby[かみ][髪] #linebreak() #ruby[ひゃく][百]#ruby[ねん][年]#ruby[い][生]きて #linebreak() #ruby[ほね][骨]#ruby[つよ][強]い][Hair white as snow, having lived a hundred years, the bones still hold strong]

=== #ruby[ひかり][光]と#ruby[ひかり][光]がない (Light & Dark)

#haiku-block[#ruby[つき][月]の#ruby[よる][夜] #linebreak() #ruby[ひ][火]が#ruby[ひと][一]つある #linebreak() #ruby[だれ][誰]かいる][A night with the moon, one small fire burning somewhere, someone is there]

#haiku-block[#ruby[ひかり][光]#ruby[く][来]る #linebreak() #ruby[こわ][怖]いの#ruby[お][終]わる #linebreak() #ruby[め][目]を#ruby[ひら][開]く][The light comes at last, all of the fear finds its end, I open my eyes]

#haiku-block[#ruby[ひ][火]を#ruby[と][止]めて #linebreak() #ruby[ひかり][光]なくなる #linebreak() #ruby[からだ][体]だけ][The fire is stopped, light drains away from the room, only the body]

#haiku-block[#ruby[よる][夜]の#ruby[そら][空] #linebreak() #ruby[つき][月]#ruby[しろ][白]く#ruby[で][出]る #linebreak() #ruby[みち][道]#ruby[しろ][白]い][The night sky opens, the moon rises pale and cold, the road turns silver]

=== #ruby[こと][言]#ruby[ば][葉] (Words)

#haiku-block[#ruby[ことば][言葉]ない #linebreak() #ruby[こころ][心]が#ruby[うご][動]く #linebreak() #ruby[ひと][人]と#ruby[ひと][人]][Without any words, something moves inside the heart, two people, one moment]

#haiku-block[#ruby[か][書]く#ruby[ことば][言葉] #linebreak() #ruby[だれ][誰]も#ruby[よ][読]まない #linebreak() まだそこに][Words written in ink, that no one will ever read, they are still there]

#haiku-block[#ruby[き][聞]く#ruby[ことば][言葉] #linebreak() #ruby[し][知]らない#ruby[ことば][言葉] #linebreak() #ruby[みち][道]#ruby[ひら][開]く][Words you hear spoken, words you have never known before, a road opens]

#haiku-block[#ruby[い][言]わないで #linebreak() #ruby[て][手]を#ruby[も][持]っている #linebreak() それでいい][Without saying a word, holding your hand in the quiet, this is enough]

#back-cover("minihongo.com")
