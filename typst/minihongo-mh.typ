#import "template.typ": *

#show: book.with(title: "ミニ本語", lang: "mh", print: false)

#cover-page("ミニ本語", "207の言葉。何でも言える。", "/site/static/logo.svg")
#pagebreak()

#outline(title: none, indent: 1.5em, depth: 3)
#pagebreak()

= 言葉

== #ruby[ひと][人]と#ruby[だれ][誰]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[ひと][人]], [#ruby[かんが][考]える#ruby[こと][事]ができる#ruby[い][生]き#ruby[もの][物]], [あの#ruby[ひと][人]は#ruby[だれ][誰]？],
  [#ruby[わたし][私]], [#ruby[いま][今]#ruby[い][言]っている#ruby[ひと][人]], [#ruby[わたし][私]は#ruby[ひと][人]だ。],
  [あなた], [#ruby[き][聞]いている#ruby[ひと][人]], [あなたは#ruby[だれ][誰]？],
  [#ruby[だれ][誰]], [どの#ruby[ひと][人]かを#ruby[き][聞]く#ruby[こと][言]#ruby[ば][葉]], [#ruby[だれ][誰]が#ruby[く][来]る？],
  [#ruby[おとこ][男]], [#ruby[ちち][父]になれる#ruby[ひと][人]], [あの#ruby[おとこ][男]は#ruby[おお][大]きい。],
  [#ruby[おんな][女]], [#ruby[はは][母]になれる#ruby[ひと][人]], [あの#ruby[おんな][女]は#ruby[はは][母]だ。],
  [#ruby[こども][子供]], [まだ#ruby[おお][大]きくない#ruby[ひと][人]], [#ruby[こども][子供]は#ruby[そと][外]で#ruby[はし][走]る。],
  [#ruby[はは][母]], [#ruby[こども][子供]を#ruby[つく][作]った#ruby[おんな][女]の#ruby[ひと][人]], [#ruby[はは][母]は#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る。],
  [#ruby[ちち][父]], [#ruby[こども][子供]を#ruby[つく][作]った#ruby[おとこ][男]の#ruby[ひと][人]], [#ruby[ちち][父]は#ruby[やま][山]に#ruby[い][行]く。],
)]

== #ruby[もの][物]と#ruby[た][食]べ#ruby[もの][物]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[もの][物]], [#ruby[め][目]で#ruby[み][見]える#ruby[なに][何]か], [この#ruby[もの][物]は#ruby[なん][何]だ？],
  [#ruby[こと][事]], [#ruby[め][目]で#ruby[み][見]えない#ruby[なに][何]か。する#ruby[こと][事]や#ruby[かんが][考]え。], [その#ruby[こと][事]は#ruby[ひつよう][必要]だ。],
  [#ruby[なに][何]], [#ruby[し][知]らないものを#ruby[き][聞]く#ruby[こと][言]#ruby[ば][葉]], [#ruby[なに][何]を#ruby[た][食]べる？],
  [#ruby[ふく][服]], [#ruby[からだ][体]に#ruby[き][着]る#ruby[もの][物]], [#ruby[あたら][新]しい#ruby[ふく][服]を#ruby[き][着]る。],
  [#ruby[ほん][本]], [#ruby[こと][言]#ruby[ば][葉]を#ruby[か][書]いた#ruby[もの][物]。#ruby[よ][読]む#ruby[もの][物]。], [#ruby[ほん][本]を#ruby[よ][読]む。],
  [お#ruby[かね][金]], [これで#ruby[もの][物]を#ruby[か][買]える], [お#ruby[かね][金]で#ruby[た][食]べ#ruby[もの][物]を#ruby[か][買]う。],
  [#ruby[にく][肉]], [#ruby[どうぶつ][動物]の#ruby[からだ][体]の#ruby[た][食]べるもの], [#ruby[にく][肉]を#ruby[た][食]べる。],
  [#ruby[たまご][卵]], [#ruby[とり][鳥]や#ruby[どうぶつ][動物]の#ruby[こども][子供]が#ruby[はじ][始]まる#ruby[もの][物]], [#ruby[たまご][卵]を#ruby[た][食]べる。],
)]

== #ruby[そと][外]の#ruby[もの][物]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[いし][石]], [#ruby[つち][土]から#ruby[で][出]る#ruby[おも][重]い#ruby[もの][物]], [#ruby[みち][道]に#ruby[いし][石]がある。],
  [#ruby[き][木]], [#ruby[つち][土]から#ruby[うえ][上]に#ruby[おお][大]きくなる#ruby[い][生]き#ruby[もの][物]], [#ruby[やま][山]に#ruby[き][木]がある。],
  [#ruby[つち][土]], [#ruby[そと][外]の#ruby[した][下]にあるもの。#ruby[くさ][草]と#ruby[き][木]はここから#ruby[で][出]る。], [#ruby[つち][土]の#ruby[なか][中]に#ruby[くさ][草]がある。],
  [#ruby[みず][水]], [#ruby[の][飲]むもの。#ruby[うみ][海]と#ruby[あめ][雨]はこれ。], [#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[ひ][火]], [#ruby[あつ][暑]くて#ruby[あか][明]るいもの], [#ruby[ひ][火]は#ruby[あつ][暑]い。],
  [#ruby[かぜ][風]], [#ruby[そと][外]で#ruby[うご][動]くもの。#ruby[かん][感]じるけど#ruby[み][見]えない。], [#ruby[そと][外]は#ruby[かぜ][風]が#ruby[つよ][強]い。],
  [#ruby[たいよう][太陽]], [#ruby[そら][空]にある#ruby[おお][大]きい#ruby[ひかり][光]。#ruby[にち][日]に#ruby[で][出]る。], [#ruby[たいよう][太陽]は#ruby[そら][空]にある。],
  [#ruby[ひかり][光]], [#ruby[あか][明]るくて#ruby[め][目]に#ruby[み][見]えるもの], [#ruby[たいよう][太陽]の#ruby[ひかり][光]が#ruby[み][見]える。],
  [#ruby[つき][月]], [#ruby[よる][夜]の#ruby[そら][空]にある#ruby[あか][明]るい#ruby[もの][物]], [#ruby[よる][夜]、#ruby[つき][月]が#ruby[み][見]える。],
  [#ruby[そら][空]], [#ruby[うえ][上]を#ruby[み][見]ると#ruby[み][見]えるところ], [#ruby[そら][空]が#ruby[あお][青]い。],
  [#ruby[やま][山]], [#ruby[つち][土]と#ruby[いし][石]でとても#ruby[たか][高]くなったところ], [#ruby[やま][山]に#ruby[い][行]く。],
  [#ruby[うみ][海]], [とても#ruby[おお][多]くの#ruby[みず][水]があるところ], [#ruby[うみ][海]はとても#ruby[おお][大]きい。],
  [#ruby[あめ][雨]], [#ruby[そら][空]から#ruby[した][下]に#ruby[く][来]る#ruby[みず][水]], [#ruby[あめ][雨]の#ruby[にち][日]は#ruby[そと][外]に#ruby[い][行]かない。],
  [#ruby[くさ][草]], [#ruby[つち][土]から#ruby[で][出]る#ruby[ちい][小]さい#ruby[みどり][緑]の#ruby[い][生]き#ruby[もの][物]], [#ruby[くさ][草]が#ruby[みどり][緑]だ。],
  [#ruby[くも][雲]], [#ruby[そら][空]にある#ruby[しろ][白]い#ruby[みず][水]のもの], [#ruby[そら][空]に#ruby[くも][雲]がある。],
)]

== #ruby[どうぶつ][動物]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[どうぶつ][動物]], [#ruby[うご][動]ける#ruby[い][生]き#ruby[もの][物]。#ruby[ひと][人]でないもの。], [#ruby[どうぶつ][動物]が#ruby[す][好]きだ。],
  [#ruby[さかな][魚]], [#ruby[みず][水]の#ruby[なか][中]で#ruby[い][生]きる#ruby[どうぶつ][動物]], [#ruby[うみ][海]に#ruby[さかな][魚]がいる。],
  [#ruby[とり][鳥]], [#ruby[そら][空]を#ruby[と][飛]ぶ#ruby[どうぶつ][動物]], [#ruby[とり][鳥]が#ruby[そら][空]を#ruby[と][飛]ぶ。],
  [#ruby[いぬ][犬]], [#ruby[ひと][人]と#ruby[い][生]きる#ruby[どうぶつ][動物]。#ruby[いえ][家]にいる。], [#ruby[いぬ][犬]が#ruby[いえ][家]にいる。],
)]

== #ruby[からだ][体]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[からだ][体]], [#ruby[ひと][人]や#ruby[どうぶつ][動物]の#ruby[ぜんぶ][全部]], [#ruby[からだ][体]が#ruby[つよ][強]い。],
  [#ruby[あたま][頭]], [#ruby[からだ][体]の#ruby[いち][一]#ruby[ばん][番]#ruby[うえ][上]。#ruby[かんが][考]えるところ。], [#ruby[あたま][頭]で#ruby[かんが][考]える。],
  [#ruby[て][手]], [#ruby[もの][物]を#ruby[も][持]つところ], [#ruby[て][手]で#ruby[もの][物]を#ruby[も][持]つ。],
  [#ruby[あし][足]], [#ruby[い][行]く#ruby[とき][時]に#ruby[つか][使]うところ], [#ruby[あし][足]で#ruby[うご][動]く。],
  [#ruby[め][目]], [#ruby[み][見]るところ], [#ruby[め][目]で#ruby[み][見]る。],
  [#ruby[くち][口]], [#ruby[た][食]べると#ruby[い][言]うところ], [#ruby[くち][口]で#ruby[た][食]べる。],
  [#ruby[みみ][耳]], [#ruby[き][聞]くところ], [#ruby[みみ][耳]で#ruby[き][聞]く。],
  [#ruby[はな][鼻]], [#ruby[かぜ][風]が#ruby[はい][入]るところ。#ruby[くち][口]の#ruby[うえ][上]にある。], [#ruby[はな][鼻]から#ruby[かぜ][風]が#ruby[はい][入]る。],
  [#ruby[こころ][心]], [#ruby[かん][感]じるところ。#ruby[す][好]きや#ruby[かな][悲]しいはここ。], [#ruby[こころ][心]が#ruby[あたた][温]かい#ruby[ひと][人]だ。],
  [#ruby[は][歯]], [#ruby[くち][口]の#ruby[なか][中]にある#ruby[しろ][白]いもの。#ruby[た][食]べ#ruby[もの][物]を#ruby[き][切]る。], [#ruby[は][歯]で#ruby[た][食]べ#ruby[もの][物]を#ruby[き][切]る。],
  [#ruby[ち][血]], [#ruby[からだ][体]の#ruby[なか][中]を#ruby[うご][動]く#ruby[あか][赤]い#ruby[みず][水]], [#ruby[て][手]から#ruby[ち][血]が#ruby[で][出]る。],
  [#ruby[ほね][骨]], [#ruby[からだ][体]の#ruby[なか][中]にある#ruby[つよ][強]い#ruby[もの][物]。#ruby[からだ][体]を#ruby[た][立]たせる。], [#ruby[ほね][骨]が#ruby[つよ][強]い。],
  [#ruby[はら][腹]], [#ruby[からだ][体]の#ruby[まえ][前]の#ruby[なか][中]の#ruby[ところ][所]。#ruby[た][食]べ#ruby[もの][物]が#ruby[はい][入]る。], [#ruby[はら][腹]に#ruby[た][食]べ#ruby[もの][物]がない。],
  [#ruby[かみ][髪]], [#ruby[あたま][頭]の#ruby[うえ][上]にある#ruby[なが][長]いもの], [#ruby[かみ][髪]が#ruby[なが][長]い。],
  [#ruby[かわ][皮]], [#ruby[からだ][体]の#ruby[そと][外]にあるもの。#ruby[ふく][服]の#ruby[した][下]のもの。], [#ruby[かわ][皮]が#ruby[あか][赤]い。],
)]

== する#ruby[こと][事]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [する], [#ruby[なに][何]かをする#ruby[こと][事]], [#ruby[なに][何]をする？],
  [いる], [#ruby[い][生]き#ruby[もの][物]がここにある#ruby[こと][事]], [#ruby[どうぶつ][動物]が#ruby[やま][山]にいる。],
  [ある], [#ruby[もの][物]がここにある#ruby[こと][事]], [#ruby[ほん][本]が#ruby[いえ][家]にある。],
  [なる], [#ruby[ほか][他]のものに#ruby[か][変]わる#ruby[こと][事]], [#ruby[おお][大]きくなる。],
  [#ruby[お][起]こる], [#ruby[あたら][新]しい#ruby[こと][事]が#ruby[はじ][始]まる], [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こる。],
  [#ruby[い][行]く], [ここからそこに#ruby[うご][動]く#ruby[こと][事]], [#ruby[やま][山]に#ruby[い][行]く。],
  [#ruby[く][来]る], [そこからここに#ruby[うご][動]く#ruby[こと][事]], [#ruby[ひと][人]が#ruby[いえ][家]に#ruby[く][来]る。],
  [#ruby[うご][動]く], [#ruby[ひと][一]つのところにいない#ruby[こと][事]], [#ruby[どうぶつ][動物]が#ruby[うご][動]く。],
  [#ruby[はい][入]る], [#ruby[そと][外]から#ruby[なか][中]に#ruby[い][行]く#ruby[こと][事]], [#ruby[いえ][家]に#ruby[はい][入]る。],
  [#ruby[で][出]る], [#ruby[なか][中]から#ruby[そと][外]に#ruby[い][行]く#ruby[こと][事]], [#ruby[いえ][家]から#ruby[で][出]る。],
  [#ruby[と][止]める], [#ruby[うご][動]くものを#ruby[うご][動]かなくする], [#ruby[うご][動]きを#ruby[と][止]める。],
  [#ruby[つく][作]る], [ないものを#ruby[あたら][新]しくする], [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る。],
  [#ruby[つか][使]う], [#ruby[もの][物]で#ruby[なに][何]かをする#ruby[こと][事]], [#ruby[もの][物]を#ruby[つか][使]う。],
  [#ruby[き][切]る], [#ruby[ひと][一]つのものを#ruby[ふた][二]つにする], [#ruby[き][木]を#ruby[き][切]る。],
  [#ruby[た][食]べる], [#ruby[くち][口]から#ruby[もの][物]を#ruby[からだ][体]の#ruby[なか][中]に#ruby[い][入]れる], [#ruby[よる][夜]に#ruby[た][食]べる。],
  [#ruby[の][飲]む], [#ruby[みず][水]のようなものを#ruby[くち][口]から#ruby[からだ][体]に#ruby[い][入]れる], [#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[ね][寝]る], [#ruby[め][目]を#ruby[し][閉]めて#ruby[からだ][体]を#ruby[と][止]める。#ruby[よる][夜]にする。], [#ruby[よる][夜]に#ruby[ね][寝]る。],
  [#ruby[き][着]る], [#ruby[ふく][服]を#ruby[からだ][体]に#ruby[つか][使]う], [#ruby[ふく][服]を#ruby[き][着]る。],
  [#ruby[すわ][座]る], [#ruby[た][立]たないで#ruby[からだ][体]を#ruby[した][下]にする], [#ruby[いえ][家]で#ruby[すわ][座]る。],
  [#ruby[た][立]つ], [#ruby[あし][足]で#ruby[うえ][上]にいる#ruby[こと][事]], [#ruby[そと][外]で#ruby[た][立]つ。],
  [#ruby[い][生]きる], [#ruby[し][死]んでいない#ruby[こと][事]], [#ruby[どうぶつ][動物]は#ruby[みず][水]で#ruby[い][生]きる。],
  [#ruby[し][死]ぬ], [#ruby[い][生]きるが#ruby[お][終]わる#ruby[こと][事]], [#ruby[くさ][草]が#ruby[し][死]ぬ。],
  [#ruby[はじ][始]まる], [#ruby[あたら][新]しく#ruby[で][出]る#ruby[こと][事]。#ruby[まえ][前]にはなかった。], [#ruby[にち][日]が#ruby[はじ][始]まる。],
  [#ruby[お][終]わる], [もうない#ruby[こと][事]。#ruby[はじ][始]まったものが#ruby[と][止]まる。], [#ruby[にち][日]が#ruby[お][終]わる。],
  [#ruby[あ][開]く], [#ruby[し][閉]まったものの#ruby[なか][中]が#ruby[み][見]える#ruby[こと][事]], [#ruby[め][目]が#ruby[あ][開]く。],
  [#ruby[し][閉]める], [#ruby[あ][開]いたものを#ruby[あ][開]かなくする], [#ruby[め][目]を#ruby[し][閉]める。],
  [#ruby[か][変]わる], [#ruby[まえ][前]と#ruby[ちが][違]うものになる], [#ruby[そら][空]の#ruby[いろ][色]が#ruby[か][変]わる。],
  [#ruby[あた][与]える], [#ruby[わたし][私]の#ruby[もの][物]を#ruby[ほか][他]の#ruby[ひと][人]の#ruby[もの][物]にする], [#ruby[どうぶつ][動物]に#ruby[た][食]べ#ruby[もの][物]を#ruby[あた][与]える。],
  [もらう], [#ruby[ほか][他]の#ruby[ひと][人]が#ruby[わたし][私]に#ruby[もの][物]を#ruby[あた][与]える#ruby[こと][事]], [#ruby[ひと][人]から#ruby[ほん][本]をもらう。],
  [#ruby[も][持]つ], [#ruby[て][手]に#ruby[もの][物]がある#ruby[こと][事]], [#ruby[ほん][本]を#ruby[も][持]つ。],
  [#ruby[あ][会]う], [#ruby[ほか][他]の#ruby[ひと][人]のところに#ruby[い][行]って#ruby[ひと][一]つになる], [#ruby[ひと][人]に#ruby[あ][会]う。],
  [#ruby[ま][待]つ], [#ruby[なに][何]かが#ruby[く][来]るまで#ruby[うご][動]かない#ruby[こと][事]], [#ruby[ひと][人]を#ruby[ま][待]つ。],
  [#ruby[たす][助]ける], [できない#ruby[ひと][人]のためにする#ruby[こと][事]], [#ruby[ひと][人]を#ruby[たす][助]ける。],
  [#ruby[まも][守]る], [#ruby[わる][悪]いものから#ruby[ひと][人]や#ruby[もの][物]を#ruby[たす][助]ける], [#ruby[こども][子供]を#ruby[まも][守]る。],
  [#ruby[たたか][戦]う], [#ruby[ほか][他]のものと#ruby[からだ][体]で#ruby[つよ][強]い#ruby[こと][事]をする], [#ruby[ひつよう][必要]な#ruby[もの][物]のために#ruby[たたか][戦]う。],
  [#ruby[えら][選]ぶ], [#ruby[おお][多]いものの#ruby[なか][中]から#ruby[ひと][一]つにする], [#ruby[た][食]べ#ruby[もの][物]を#ruby[えら][選]ぶ。],
  [#ruby[さが][探]す], [#ruby[ほ][欲]しいものがどこかを#ruby[み][見]る], [#ruby[みち][道]を#ruby[さが][探]す。],
  [#ruby[か][買]う], [お#ruby[かね][金]で#ruby[もの][物]をもらう], [#ruby[た][食]べ#ruby[もの][物]を#ruby[か][買]う。],
  [#ruby[い][言]う], [#ruby[くち][口]から#ruby[こと][言]#ruby[ば][葉]を#ruby[だ][出]す], [#ruby[なまえ][名前]を#ruby[い][言]う。],
  [#ruby[か][書]く], [#ruby[て][手]で#ruby[こと][言]#ruby[ば][葉]を#ruby[つく][作]る], [#ruby[ほん][本]に#ruby[か][書]く。],
  [#ruby[よ][読]む], [#ruby[か][書]いたものを#ruby[め][目]で#ruby[み][見]て#ruby[し][知]る], [#ruby[ほん][本]を#ruby[よ][読]む。],
  [#ruby[おし][教]える], [#ruby[ひと][人]が#ruby[し][知]らない#ruby[こと][事]を#ruby[い][言]う], [#ruby[ひと][人]に#ruby[ことば][言葉]を#ruby[おし][教]える。],
  [#ruby[かんが][考]える], [#ruby[あたま][頭]の#ruby[なか][中]で#ruby[こと][事]をする], [#ruby[こと][事]を#ruby[かんが][考]える。],
  [#ruby[わら][笑]う], [#ruby[たの][楽]しい#ruby[とき][時]に#ruby[くち][口]でする#ruby[こと][事]], [#ruby[ひと][人]と#ruby[わら][笑]う。],
  [#ruby[な][泣]く], [#ruby[かな][悲]しい#ruby[とき][時]に#ruby[め][目]から#ruby[みず][水]が#ruby[で][出]る#ruby[こと][事]], [#ruby[こども][子供]が#ruby[な][泣]く。],
  [できる], [する#ruby[こと][事]が#ruby[と][止]まらない], [これは#ruby[ひと][一]りでできる。],
  [#ruby[わ][分]かる], [#ruby[き][聞]いた#ruby[こと][事]や#ruby[み][見]た#ruby[こと][事]が#ruby[あたま][頭]の#ruby[なか][中]で#ruby[し][知]れる#ruby[こと][事]], [この#ruby[ことば][言葉]が#ruby[わ][分]からない。],
  [#ruby[はな][話]す], [#ruby[ひと][人]と#ruby[こと][言]#ruby[ば][葉]を#ruby[い][言]う#ruby[こと][事]。#ruby[き][聞]く#ruby[こと][事]もする。], [#ruby[ひと][人]と#ruby[はな][話]すのが#ruby[す][好]きだ。],
  [#ruby[ある][歩]く], [#ruby[あし][足]で#ruby[うご][動]く#ruby[こと][事]。#ruby[はや][速]くない。], [#ruby[いえ][家]まで#ruby[ある][歩]く。],
  [#ruby[と][飛]ぶ], [#ruby[そら][空]の#ruby[なか][中]を#ruby[うご][動]く#ruby[こと][事]], [#ruby[とり][鳥]が#ruby[と][飛]ぶ。],
)]

== どんな

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[あつ][暑]い], [#ruby[ひ][火]のような#ruby[かん][感]じ。#ruby[さむ][寒]くない。], [#ruby[そと][外]は#ruby[あつ][暑]い。],
  [#ruby[さむ][寒]い], [#ruby[あつ][暑]くない#ruby[かん][感]じ], [#ruby[そと][外]は#ruby[さむ][寒]い。],
  [#ruby[よ][良]い], [#ruby[す][好]きな#ruby[かん][感]じ。#ruby[わる][悪]くない。], [この#ruby[ほん][本]は#ruby[よ][良]い。],
  [#ruby[わる][悪]い], [#ruby[よ][良]くない。#ruby[す][好]きでない#ruby[かん][感]じ。], [#ruby[そら][空]が#ruby[わる][悪]い。],
  [#ruby[おお][大]きい], [#ruby[おお][多]くのところを#ruby[つか][使]う], [あの#ruby[やま][山]は#ruby[おお][大]きい。],
  [#ruby[なが][長]い], [#ruby[はじ][始]めから#ruby[お][終]わりまでが#ruby[おお][大]きい], [この#ruby[みち][道]は#ruby[なが][長]い。],
  [#ruby[たか][高]い], [#ruby[した][下]から#ruby[うえ][上]まで#ruby[おお][大]きい], [この#ruby[おお][大]きい#ruby[いえ][家]は#ruby[たか][高]い。],
  [#ruby[おも][重]い], [#ruby[も][持]つのに#ruby[つよ][強]くないとできない], [この#ruby[いし][石]は#ruby[おも][重]い。],
  [#ruby[へん][変]], [#ruby[ほか][他]のものと#ruby[ちが][違]う。#ruby[し][知]らない#ruby[かん][感]じ。], [この#ruby[おと][音]は#ruby[へん][変]だ。],
  [きれい], [#ruby[み][見]て#ruby[よ][良]い#ruby[かん][感]じ], [この#ruby[やま][山]はきれいだ。],
  [#ruby[つよ][強]い], [#ruby[おお][大]きなものを#ruby[うご][動]かせる], [あの#ruby[ひと][人]は#ruby[つよ][強]い。],
  [#ruby[たの][楽]しい], [#ruby[こころ][心]が#ruby[よ][良]い#ruby[かん][感]じ], [#ruby[ひと][人]と#ruby[あ][会]うのは#ruby[たの][楽]しい。],
  [#ruby[ちが][違]う], [#ruby[ふた][二]つのものが#ruby[ひと][一]つでない], [この#ruby[いろ][色]は#ruby[ちが][違]う。],
  [#ruby[ほか][他]], [これでもそれでもないもの], [#ruby[ほか][他]の#ruby[ひと][人]に#ruby[き][聞]く。],
  [#ruby[あたら][新]しい], [#ruby[まえ][前]にはなかった。#ruby[いま][今]できたもの。], [#ruby[あたら][新]しい#ruby[ほん][本]を#ruby[か][買]う。],
  [#ruby[はや][速]い], [#ruby[すこ][少]しの#ruby[とき][時]に#ruby[おお][多]く#ruby[うご][動]ける], [あの#ruby[どうぶつ][動物]は#ruby[はや][速]い。],
  [#ruby[おお][多]い], [#ruby[すこ][少]しでない], [ここは#ruby[ひと][人]が#ruby[おお][多]い。],
  [#ruby[ほんとう][本当]], [ある#ruby[こと][事]がある#ruby[こと][事]。#ruby[か][変]わらない。], [#ruby[ほんとう][本当]か？],
  [#ruby[ちい][小]さい], [#ruby[すこ][少]しの#ruby[ところ][所]だけを#ruby[つか][使]う], [この#ruby[いし][石]は#ruby[ちい][小]さい。],
  [#ruby[おな][同]じ], [#ruby[ふた][二]つのものが#ruby[ひと][一]つのようにある#ruby[こと][事]], [#ruby[わたし][私]とあなたは#ruby[おな][同]じ#ruby[もの][物]を#ruby[た][食]べた。],
)]

== #ruby[いろ][色]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[いろ][色]], [#ruby[め][目]で#ruby[み][見]える#ruby[ちが][違]い], [この#ruby[そら][空]の#ruby[いろ][色]はきれいだ。],
  [#ruby[しろ][白]], [#ruby[ひかり][光]の#ruby[いろ][色]], [この#ruby[いし][石]は#ruby[しろ][白]い。],
  [#ruby[くろ][黒]], [#ruby[ひかり][光]がない#ruby[いろ][色]], [その#ruby[そら][空]は#ruby[くろ][黒]い。],
  [#ruby[あか][赤]], [#ruby[ひ][火]の#ruby[いろ][色]], [#ruby[ひ][火]は#ruby[あか][赤]い。],
  [#ruby[あお][青]], [#ruby[そら][空]の#ruby[いろ][色]], [#ruby[そら][空]は#ruby[あお][青]い。],
  [#ruby[きいろ][黄色]], [#ruby[ひかり][光]のような#ruby[あか][明]るい#ruby[いろ][色]], [この#ruby[ひかり][光]は#ruby[きいろ][黄色]い。],
  [#ruby[みどり][緑]], [#ruby[くさ][草]の#ruby[いろ][色]], [#ruby[くさ][草]は#ruby[みどり][緑]だ。],
  [#ruby[あか][明]るい], [#ruby[ひかり][光]が#ruby[おお][多]い], [#ruby[そと][外]は#ruby[あか][明]るい。],
)]

== #ruby[こころ][心]と#ruby[かん][感]じ

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[し][知]る], [#ruby[あたま][頭]の#ruby[なか][中]にある#ruby[こと][事]], [その#ruby[なまえ][名前]を#ruby[し][知]っている。],
  [#ruby[かん][感]じる], [#ruby[からだ][体]や#ruby[こころ][心]で#ruby[なに][何]かを#ruby[し][知]る], [#ruby[かぜ][風]を#ruby[かん][感]じる。],
  [#ruby[み][見]る], [#ruby[め][目]を#ruby[つか][使]う#ruby[こと][事]], [#ruby[そら][空]を#ruby[み][見]る。],
  [#ruby[き][聞]く], [#ruby[みみ][耳]を#ruby[つか][使]う#ruby[こと][事]], [#ruby[おと][音]を#ruby[き][聞]く。],
  [#ruby[おも][思]う], [#ruby[こころ][心]の#ruby[なか][中]で#ruby[かんが][考]える], [それは#ruby[よ][良]いと#ruby[おも][思]う。],
  [#ruby[ほ][欲]しい], [それを#ruby[も][持]ちたい#ruby[かん][感]じ], [#ruby[あたら][新]しい#ruby[ほん][本]が#ruby[ほ][欲]しい。],
  [#ruby[ひつよう][必要]], [ないと#ruby[わる][悪]い#ruby[こと][事]になる], [#ruby[みず][水]は#ruby[ひつよう][必要]だ。],
  [#ruby[す][好]き], [#ruby[こころ][心]が#ruby[よ][良]くなるもの], [#ruby[どうぶつ][動物]が#ruby[す][好]きだ。],
  [#ruby[こわ][怖]い], [#ruby[わる][悪]い#ruby[こと][事]が#ruby[く][来]ると#ruby[おも][思]う#ruby[かん][感]じ], [その#ruby[はなし][話]は#ruby[こわ][怖]い。],
  [#ruby[かな][悲]しい], [#ruby[こころ][心]が#ruby[おも][重]い#ruby[かん][感]じ。#ruby[な][泣]きたい。], [その#ruby[はなし][話]は#ruby[かな][悲]しい。],
  [#ruby[おこ][怒]る], [#ruby[わる][悪]い#ruby[こと][事]があって#ruby[こころ][心]が#ruby[つよ][強]くなる], [#ruby[ちち][父]が#ruby[おこ][怒]る。],
)]

== #ruby[い][言]う#ruby[こと][事]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[ことば][言葉]], [#ruby[ひと][人]が#ruby[い][言]うもの。#ruby[くち][口]から#ruby[で][出]る#ruby[おと][音]。], [この#ruby[ことば][言葉]が#ruby[わ][分]からない。],
  [#ruby[なまえ][名前]], [#ruby[ひと][人]や#ruby[もの][物]だけの#ruby[こと][言]#ruby[ば][葉]], [あなたの#ruby[なまえ][名前]を#ruby[おし][教]えてください。],
  [#ruby[おと][音]], [#ruby[みみ][耳]で#ruby[き][聞]くもの], [#ruby[へん][変]な#ruby[おと][音]を#ruby[き][聞]く。],
)]

== #ruby[とき][時]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[とき][時]], [#ruby[まえ][前]から#ruby[いま][今]、#ruby[いま][今]から#ruby[あと][後]までの#ruby[こと][事]], [#ruby[た][食]べる#ruby[とき][時]、#ruby[て][手]を#ruby[つか][使]う。],
  [#ruby[いま][今]], [この#ruby[とき][時]], [#ruby[いま][今]、#ruby[た][食]べる。],
  [#ruby[まえ][前]], [#ruby[いま][今]より#ruby[まえ][前]の#ruby[とき][時]], [#ruby[た][食]べる#ruby[まえ][前]に#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[あと][後]], [#ruby[いま][今]より#ruby[あと][後]の#ruby[とき][時]], [#ruby[た][食]べた#ruby[あと][後]、#ruby[いえ][家]に#ruby[い][行]く。],
  [#ruby[まい][毎]], [#ruby[ぜんぶ][全部]の#ruby[とき][時]。いつも。], [#ruby[まい][毎]#ruby[にち][日]#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[にち][日]], [#ruby[たいよう][太陽]が#ruby[で][出]てから#ruby[よる][夜]までの#ruby[とき][時]], [#ruby[よ][良]い#ruby[にち][日]だ。],
  [#ruby[とし][年]], [とても#ruby[なが][長]い#ruby[とき][時]], [#ruby[あたら][新]しい#ruby[とし][年]が#ruby[はじ][始]まる。],
  [#ruby[よる][夜]], [#ruby[たいよう][太陽]がなくて#ruby[あか][明]るくない#ruby[とき][時]], [#ruby[よる][夜]、#ruby[そら][空]に#ruby[つき][月]が#ruby[み][見]える。],
)]

== #ruby[ところ][所]と#ruby[うえ][上]#ruby[した][下]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[くに][国]], [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[ひと][一]つになって#ruby[い][生]きる#ruby[おお][大]きい#ruby[ところ][所]], [この#ruby[くに][国]は#ruby[おお][大]きい。],
  [#ruby[ところ][所]], [#ruby[ひと][人]や#ruby[もの][物]がいるところ。ここ、そこ、どこの#ruby[こと][事]。], [いい#ruby[ところ][所]を#ruby[さが][探]す。],
  [#ruby[いえ][家]], [#ruby[ひと][人]が#ruby[なか][中]で#ruby[い][生]きるところ], [#ruby[わたし][私]の#ruby[いえ][家]は#ruby[おお][大]きい。],
  [#ruby[みち][道]], [#ruby[ひと][人]が#ruby[い][行]く#ruby[なが][長]いところ], [#ruby[みち][道]を#ruby[い][行]く。],
  [#ruby[なか][中]], [#ruby[そと][外]でないところ], [#ruby[いえ][家]の#ruby[なか][中]に#ruby[もの][物]がある。],
  [#ruby[そと][外]], [#ruby[いえ][家]の#ruby[なか][中]でないところ], [#ruby[そと][外]に#ruby[い][行]く。],
  [#ruby[うえ][上]], [#ruby[たか][高]いところ], [#ruby[やま][山]の#ruby[うえ][上]に#ruby[ひと][人]がいる。],
  [#ruby[した][下]], [#ruby[うえ][上]でないところ], [#ruby[き][木]の#ruby[した][下]に#ruby[なに][何]かある。],
  [#ruby[みぎ][右]], [#ruby[ひだり][左]でないところ], [#ruby[みぎ][右]に#ruby[おお][大]きい#ruby[いえ][家]がある。],
  [#ruby[ひだり][左]], [#ruby[みぎ][右]でないところ], [#ruby[ひだり][左]に#ruby[やま][山]がある。],
  [#ruby[ちか][近]い], [ここからそこまでが#ruby[おお][大]きくない], [#ruby[やま][山]は#ruby[いえ][家]から#ruby[ちか][近]い。],
  [#ruby[とお][遠]い], [ここからそこまでがとても#ruby[おお][大]きい。#ruby[ちか][近]くない。], [#ruby[うみ][海]は#ruby[とお][遠]い。],
  [ここ], [#ruby[わたし][私]がいるところ], [ここに#ruby[すわ][座]ってください。],
  [そこ], [#ruby[ちか][近]いけどここでないところ], [そこに#ruby[なに][何]がある？],
  [どこ], [どのところかを#ruby[き][聞]く#ruby[こと][言]#ruby[ば][葉]], [#ruby[うみ][海]はどこ？],
)]

== #ruby[ひと][一]つにする#ruby[こと][言]#ruby[ば][葉]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[ぜんぶ][全部]], [#ruby[ひと][一]つもないものがない], [#ruby[ぜんぶ][全部]#ruby[た][食]べた。],
  [と], [#ruby[ふた][二]つのものを#ruby[ひと][一]つにする#ruby[こと][言]#ruby[ば][葉]], [#ruby[みず][水]と#ruby[た][食]べ#ruby[もの][物]をください。],
  [または], [#ruby[ひと][一]つかもう#ruby[ひと][一]つ], [#ruby[みず][水]または#ruby[の][飲]み#ruby[もの][物]をください。],
  [でも], [#ruby[まえ][前]の#ruby[こと][事]と#ruby[ちが][違]う#ruby[こと][事]を#ruby[い][言]う#ruby[とき][時]の#ruby[こと][言]#ruby[ば][葉]], [#ruby[ちい][小]さい。でも#ruby[つよ][強]い。],
  [から], [#ruby[はじ][始]まるところ。なぜかを#ruby[い][言]う#ruby[とき][時]の#ruby[こと][言]#ruby[ば][葉]。], [#ruby[さむ][寒]いから、#ruby[いえ][家]にいる。],
  [まで], [#ruby[お][終]わるところ], [#ruby[よる][夜]まで#ruby[ま][待]つ。],
  [なら], [もしそうだったらの#ruby[こと][言]#ruby[ば][葉]], [#ruby[とき][時]があるなら、#ruby[そと][外]に#ruby[い][行]く。],
  [だけ], [#ruby[ほか][他]にはない。それ#ruby[ひと][一]つ。], [#ruby[みず][水]だけ#ruby[の][飲]む。],
  [も], [それと#ruby[ほか][他]にもう#ruby[ひと][一]つある#ruby[こと][事]], [#ruby[わたし][私]も#ruby[い][行]く。],
  [もっと], [#ruby[いま][今]より#ruby[おお][多]く], [もっと#ruby[た][食]べたい。],
  [もう], [#ruby[まえ][前]にそれが#ruby[お][終]わった#ruby[こと][事]], [もう#ruby[た][食]べた。],
  [まだ], [#ruby[いま][今]もその#ruby[こと][事]が#ruby[か][変]わっていない], [まだ#ruby[た][食]べていない。],
  [とても], [#ruby[おお][多]く。#ruby[つよ][強]く。], [この#ruby[た][食]べ#ruby[もの][物]はとても#ruby[よ][良]い。],
  [#ruby[すこ][少]し], [#ruby[おお][多]くない], [#ruby[すこ][少]し#ruby[ま][待]ってください。],
  [#ruby[かた][方]], [どうするかの#ruby[かたち][形]。する#ruby[こと][事]の#ruby[あと][後]に#ruby[つ][付]ける。], [#ruby[た][食]べ#ruby[かた][方]を#ruby[おし][教]えてください。],
  [たぶん], [#ruby[ほんとう][本当]かどうか#ruby[し][知]らないけど、そうだと#ruby[おも][思]う#ruby[とき][時]の#ruby[こと][言]#ruby[ば][葉]], [たぶん#ruby[あめ][雨]が#ruby[く][来]る。],
)]

== はいといいえ

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [すみません], [#ruby[わる][悪]い#ruby[こと][事]をした#ruby[とき][時]に#ruby[い][言]う。#ruby[ひと][人]に#ruby[き][聞]く#ruby[まえ][前]にも#ruby[つか][使]う。], [すみません、#ruby[みち][道]を#ruby[おし][教]えてください。],
  [ありがとう], [#ruby[よ][良]い#ruby[こと][事]をもらった#ruby[とき][時]に#ruby[い][言]う#ruby[こと][言]#ruby[ば][葉]], [ありがとう。#ruby[たす][助]かった。],
  [ください], [#ruby[ほ][欲]しいものを#ruby[ひと][人]に#ruby[い][言]う#ruby[とき][時]の#ruby[こと][言]#ruby[ば][葉]], [#ruby[みず][水]をください。],
  [はい], [#ruby[ほんとう][本当]だと#ruby[い][言]う#ruby[とき][時]の#ruby[こと][言]#ruby[ば][葉]], [はい、#ruby[わ][分]かった。],
  [ない], [いない。ゼロ。そこに#ruby[なに][何]もない#ruby[こと][事]。], [お#ruby[かね][金]がない。],
  [どう], [どのようにかを#ruby[き][聞]く#ruby[こと][言]#ruby[ば][葉]], [これはどう#ruby[つか][使]う？],
  [いいえ], [#ruby[ほんとう][本当]でない#ruby[とき][時]に#ruby[い][言]う#ruby[こと][言]#ruby[ば][葉]], [いいえ、#ruby[ほ][欲]しくない。],
  [いつ], [どの#ruby[とき][時]かを#ruby[き][聞]く#ruby[こと][言]#ruby[ば][葉]], [いつ#ruby[く][来]る？],
  [なぜ], [#ruby[なに][何]からかを#ruby[き][聞]く#ruby[こと][言]#ruby[ば][葉]], [なぜ#ruby[い][行]かない？],
  [これ], [ここにあるもの], [これは#ruby[なん][何]だ？],
  [それ], [そこにあるもの], [それをください。],
  [この], [ここにあるものの], [この#ruby[ほん][本]は#ruby[よ][良]い。],
  [その], [そこにあるものの], [その#ruby[た][食]べ#ruby[もの][物]は#ruby[なん][何]だ？],
)]

== いくつ

#note-block[いくつは#ruby[ふた][二]つの#ruby[よ][読]み#ruby[かた][方]がある。4=し/よん、7=しち/なな、9=く/きゅう。#ruby[はな][話]す#ruby[とき][時]はよん、なな、きゅうが#ruby[おお][多]い。#ruby[おお][大]きいいくつの#ruby[つく][作]り#ruby[かた][方]: #ruby[に][二]+#ruby[じゅう][十]=20、#ruby[さん][三]+#ruby[ひゃく][百]=300。]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*][*#ruby[つか][使]い#ruby[かた][方]*],
  [#ruby[いち][一]], [#ruby[ひと][一]つだけ], [#ruby[ひと][一]りで#ruby[やま][山]に#ruby[い][行]った。],
  [#ruby[に][二]], [#ruby[いち][一]と#ruby[いち][一]], [#ruby[て][手]は#ruby[ふた][二]つある。],
  [#ruby[さん][三]], [#ruby[に][二]と#ruby[いち][一]], [#ruby[さん][三]#ruby[にん][人]の#ruby[こども][子供]がいる。],
  [#ruby[よん][四]], [#ruby[さん][三]と#ruby[いち][一]], [#ruby[いぬ][犬]の#ruby[あし][足]は#ruby[よん][四]つだ。],
  [#ruby[ご][五]], [#ruby[さん][三]と#ruby[に][二]], [#ruby[ご][五]#ruby[にん][人]の#ruby[ひと][人]が#ruby[き][来]た。],
  [#ruby[ろく][六]], [#ruby[ご][五]と#ruby[いち][一]], [#ruby[ろく][六]#ruby[がつ][月]は#ruby[あめ][雨]が#ruby[おお][多]い。],
  [#ruby[なな][七]], [#ruby[ご][五]と#ruby[に][二]], [#ruby[なな][七]つの#ruby[いろ][色]が#ruby[そら][空]に#ruby[で][出]た。],
  [#ruby[はち][八]], [#ruby[ご][五]と#ruby[さん][三]], [#ruby[はち][八]#ruby[がつ][月]はとても#ruby[あつ][暑]い。],
  [#ruby[きゅう][九]], [#ruby[じゅう][十]から#ruby[いち][一]をなくしたもの], [#ruby[く][九]#ruby[じ][時]に#ruby[ね][寝]る。],
  [#ruby[じゅう][十]], [#ruby[ご][五]と#ruby[ご][五]], [#ruby[じゅう][十]#ruby[にん][人]で#ruby[た][食]べた。],
  [#ruby[ひゃく][百]], [#ruby[じゅう][十]が#ruby[じゅう][十]], [#ruby[みず][水]は#ruby[ひゃく][百]#ruby[ご][五]#ruby[じゅう][十]だ。],
)]

#pagebreak(weak: true)

= 言葉の道

== #ruby[こと][言]#ruby[ば][葉]の#ruby[かたち][形]

#grammar-card[#ruby[こと][言]#ruby[ば][葉]の#ruby[く][来]る#ruby[ところ][所]][#ruby[ところ][所]を#ruby[つく][作]って、それからする#ruby[こと][事]。[#ruby[だれ][誰]] [いつ] [どこ] [#ruby[なに][何]] → [する#ruby[こと][事]]。する#ruby[こと][事]がいつも#ruby[お][終]わりに#ruby[く][来]る。#ruby[ひと][一]つにする#ruby[こと][言]#ruby[ば][葉]がどこに#ruby[なに][何]が#ruby[く][来]るか#ruby[み][見]せる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ほん][本]を #ruby[よ][読]む。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ひと][人]だ。]]

#grammar-card[#ruby[い][言]わない#ruby[こと][事]][#ruby[し][知]っている#ruby[こと][事]は#ruby[い][言]わない。#ruby[だれ][誰]が、#ruby[なに][何]を - #ruby[し][知]るなら#ruby[い][言]わなくていい。これがいつもの#ruby[こと][事]。][#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[なに][何]を #ruby[の][飲]む？」「#ruby[みず][水]。」]]

#grammar-card[ある / いる][ある#ruby[こと][事]は#ruby[も][持]つ#ruby[こと][事]と#ruby[ひと][一]つ。「#ruby[も][持]つ」のする#ruby[こと][事]はない。#ruby[い][生]き#ruby[もの][物]はいる、#ruby[ほか][他]は#ruby[ぜんぶ][全部]ある。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[どうぶつ][動物]がいる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ほん][本]がある。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ほん][本]がある。]]

== する#ruby[こと][事]の#ruby[かたち][形]

#grammar-card[#ruby[よっ][四]つの#ruby[かた][方]][#ruby[よっ][四]つのやり#ruby[かた][方]がある。これは#ruby[こと][言]#ruby[ば][葉]を#ruby[か][変]えるもの。る = #ruby[いま][今]と#ruby[あと][後]。た = #ruby[まえ][前]、#ruby[お][終]わった#ruby[こと][事]。ない = しない。なかった = #ruby[まえ][前]にしなかった。#ruby[ぜんぶ][全部]この#ruby[よっ][四]つの#ruby[うえ][上]に#ruby[つく][作]る。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べる → #ruby[た][食]べた → #ruby[た][食]べない → #ruby[た][食]べなかった]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]く → #ruby[い][行]った → #ruby[い][行]かない → #ruby[い][行]かなかった]
#block(inset: (top: 0.2em, bottom: 0.2em))[する → した → しない → しなかった]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[く][来]る → #ruby[き][来]た → #ruby[こ][来]ない → #ruby[こ][来]なかった]]

#grammar-card[ての#ruby[かた][方]][する#ruby[こと][事]を#ruby[ほんとう][本当]に#ruby[お][起]こる#ruby[かた][方]で#ruby[ひと][一]つにする。「と」「で」「のために」はいらない - する#ruby[こと][事]をそのまま#ruby[い][言]う。#ruby[とき][時]は#ruby[お][終]わりだけ。く→いて、む→んで、つ→って、る→て。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]く → #ruby[か][書]いて]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[の][飲]む → #ruby[の][飲]んで]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ま][待]つ → #ruby[ま][待]って]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べる → #ruby[た][食]べて]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]いて #ruby[よ][読]んで #ruby[ね][寝]た。]]

#grammar-card[て + もっと][ての#ruby[かた][方]にもっと#ruby[た][足]す。#ruby[ほ][欲]しい#ruby[こと][事] + ください、#ruby[いま][今]している + いる、していい + もいい、してはいけない + はいけない。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ま][待]ってください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いま][今] #ruby[よ][読]んでいる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[すわ][座]ってもいい？]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[はい][入]ってはいけない。]]

#grammar-card[られる / える][できる#ruby[こと][事]。る-のする#ruby[こと][事]: る をなくして、られる を#ruby[た][足]す。#ruby[ほか][他]: え の#ruby[かた][方] + る。する → できる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]く → #ruby[か][書]ける]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[み][見]る → #ruby[み][見]られる]
#block(inset: (top: 0.2em, bottom: 0.2em))[する → できる]]

#grammar-card[ないでください][しないでほしい#ruby[こと][事]を#ruby[い][言]う。する#ruby[こと][事]のない#ruby[かた][方] + で + ください。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[はい][入]らないでください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[て][手]で#ruby[も][持]たないでください。]]

== ますとです

#grammar-card[ます / です][よく#ruby[し][知]らない#ruby[ひと][人]と#ruby[はな][話]す#ruby[とき][時]はますを#ruby[つか][使]う。する#ruby[こと][事]の#ruby[はじ][始]め + ます。だ → です。いつも#ruby[おな][同]じ#ruby[かた][方]で#ruby[か][変]わる。ます / ました / ません / ませんでした。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]みます。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]に#ruby[い][行]きました。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さかな][魚]を#ruby[た][食]べません。]
#block(inset: (top: 0.2em, bottom: 0.2em))[この#ruby[ほん][本]は#ruby[よ][良]いです。]]

#grammar-card[いつますを#ruby[つか][使]うか][#ruby[し][知]らない#ruby[ひと][人]にはますを#ruby[つか][使]う。#ruby[か][買]う#ruby[ところ][所]の#ruby[ひと][人]、#ruby[おし][教]える#ruby[ひと][人]、#ruby[ほか][他]の#ruby[ひと][人]に#ruby[つか][使]う。#ruby[いえ][家]の#ruby[ひと][人]と#ruby[す][好]きな#ruby[ひと][人]にはるの#ruby[かた][方]でいい。ますは#ruby[ひと][人]への#ruby[よ][良]い#ruby[き][気]#ruby[も][持]ちを#ruby[み][見]せる。#ruby[つか][使]わないと#ruby[こども][子供]のように#ruby[き][聞]こえる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][買]う#ruby[ところ][所]で: これをください。いくらですか。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[す][好]きな#ruby[ひと][人]に: これ、いくら？]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]いです。]]

== #ruby[ひと][一]つにする#ruby[こと][言]#ruby[ば][葉]

#grammar-card[は][「これの#ruby[こと][事]は...」と#ruby[ところ][所]を#ruby[つく][作]る。#ruby[こと][言]#ruby[ば][葉]の#ruby[い][入]れる#ruby[ところ][所]の#ruby[ひと][一]つ#ruby[め][目]。#ruby[なに][何]の#ruby[こと][事]かを#ruby[み][見]せる。][#block(inset: (top: 0.2em, bottom: 0.2em))[この #ruby[ほん][本]は #ruby[よ][良]い。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[め][目]が #ruby[よ][良]い。]]

#grammar-card[が][する#ruby[ひと][人]。#ruby[だれ][誰]がそれをするか。#ruby[あたら][新]しい#ruby[こと][事]。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]が #ruby[く][来]る？]]

#grammar-card[を][#ruby[なに][何]にする#ruby[こと][事]をするか。[#ruby[なに][何]]の#ruby[い][入]れる#ruby[ところ][所]。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を #ruby[の][飲]む。]]

#grammar-card[に][どこに#ruby[い][行]く。いつ。どこにいる。[いつ]と[どこ]の#ruby[い][入]れる#ruby[ところ][所]。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]に #ruby[い][行]く。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よる][夜]に #ruby[ね][寝]る。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]に #ruby[どうぶつ][動物]がいる。]]

#grammar-card[で][どこでする。#ruby[なに][何]を#ruby[つか][使]ってする。に は#ruby[もの][物]がいるところ、で はする#ruby[こと][事]のところ。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]で #ruby[よ][読]む。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[て][手]で #ruby[か][書]く。]]

#grammar-card[の][#ruby[もの][物]と#ruby[もの][物]を#ruby[ひと][一]つにする。する#ruby[こと][事]を#ruby[もの][物]にもする (#ruby[ご][五]を#ruby[み][見]る)。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]の #ruby[ほん][本]。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]の #ruby[うえ][上]。]]

#grammar-card[と][「と」で#ruby[ひと][一]つにする。#ruby[い][言]った#ruby[こと][事]を#ruby[か][書]く。#ruby[い][言]う#ruby[こと][事]、#ruby[おも][思]う#ruby[こと][事]、#ruby[おと][音]、#ruby[なまえ][名前]。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]と #ruby[ほん][本]を #ruby[か][買]った。]
#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[い][行]く」と #ruby[い][言]った。]]

#grammar-card[も][「も」で#ruby[ひと][一]つ。は、が、を のの#ruby[ところ][所]に#ruby[つか][使]う。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ちち][父]は #ruby[ほん][本]を #ruby[よ][読]む。#ruby[はは][母]も #ruby[よ][読]む。]]

#grammar-card[から / まで][#ruby[はじ][始]まるところ (から)、#ruby[お][終]わるところ (まで)。から はなぜかも#ruby[い][言]える。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]から #ruby[やま][山]まで #ruby[い][行]く。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よる][夜]まで #ruby[ま][待]つ。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]いから、#ruby[いえ][家]にいる。]]

#grammar-card[より][Xより = 「Xよりもっと」。この#ruby[ひと][一]つの#ruby[こと][言]#ruby[ば][葉]で#ruby[ぜんぶ][全部]。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]より #ruby[おお][大]きい。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]より #ruby[た][食]べ#ruby[もの][物]が #ruby[す][好]きだ。]]

== どんな

#grammar-card[い の#ruby[こと][言]#ruby[ば][葉]][する#ruby[こと][事]と#ruby[ひと][一]つ。#ruby[さむ][寒]い だけで#ruby[こと][言]#ruby[ば][葉]が#ruby[お][終]わる。#ruby[か][変]える: くない、かった、くて。だ はいらない。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]い。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]くない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]かった。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]くて #ruby[かな][悲]しい。]]

#grammar-card[な の#ruby[こと][言]#ruby[ば][葉]][#ruby[もの][物]の#ruby[まえ][前]に な を#ruby[た][足]す。じゃない (#ruby[ちが][違]う)、だった (#ruby[まえ][前])。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]な #ruby[もの][物]。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]じゃない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]だった。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]で #ruby[よ][良]い。]]

#grammar-card[〜くなる / 〜になる][#ruby[か][変]わる#ruby[こと][事]。#ruby[ぜんぶ][全部]の#ruby[か][変]わり#ruby[かた][方]がこれ#ruby[ひと][一]つ。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あつ][暑]い → #ruby[あつ][暑]くなる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要] → #ruby[ひつよう][必要]になる。]]

#grammar-card[する#ruby[こと][事] + #ruby[もの][物]][する#ruby[こと][事]や#ruby[こと][言]#ruby[ば][葉]を#ruby[もの][物]の#ruby[まえ][前]に#ruby[い][入]れて、それを#ruby[み][見]せる。#ruby[こと][言]#ruby[ば][葉]#ruby[づく][作]りの#ruby[つよ][強]さ。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]で #ruby[うご][動]く #ruby[こども][子供]。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]が #ruby[か][買]った #ruby[もの][物]。]]

== #ruby[もの][物]にする

#grammar-card[の][いつもの#ruby[かた][方]。#ruby[た][食]べるのが#ruby[す][好]き。#ruby[き][聞]く#ruby[とき][時]にも: #ruby[なに][何]しているの？][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べるのが #ruby[す][好]きだ。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なに][何]しているの？]]

#grammar-card[こと][する#ruby[こと][事]を#ruby[かんが][考]えにする。#ruby[め][目]で#ruby[み][見]えない#ruby[こと][事]。「#ruby[うご][動]く#ruby[こと][事]」は#ruby[かんが][考]え。「#ruby[の][飲]む#ruby[もの][物]」は#ruby[て][手]で#ruby[も][持]てる。この#ruby[ちが][違]いが#ruby[ひつよう][必要]。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[うご][動]くことは#ruby[よ][良]い。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]くことができる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]なことを#ruby[い][言]う。]]

#grammar-card[もの][#ruby[て][手]で#ruby[も][持]てるもの。#ruby[ほんとう][本当]にある#ruby[なに][何]か。「#ruby[の][飲]むもの」= #ruby[の][飲]める#ruby[なに][何]か。「こと」は#ruby[かんが][考]え、「もの」は#ruby[もの][物]。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[の][飲]むもの。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][読]むもの。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]なものを#ruby[も][持]っている。]]

#grammar-card[#ruby[かた][方]][どうするかの#ruby[かた][方]。する#ruby[こと][事]の#ruby[はじ][始]めに#ruby[た][足]す。#ruby[た][食]べ#ruby[かた][方]= どう#ruby[た][食]べるか。#ruby[つか][使]い#ruby[かた][方]= どう#ruby[つか][使]うか。こと・もの・#ruby[かた][方]の#ruby[みっ][三]つで#ruby[ぜんぶ][全部]#ruby[い][言]える。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べ#ruby[かた][方]を#ruby[おし][教]えてください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[この#ruby[こと][言]#ruby[ば][葉]の#ruby[つか][使]い#ruby[かた][方]が#ruby[し][知]りたい。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[き][聞]き#ruby[かた][方]が#ruby[ひつよう][必要]だ。]]

== #ruby[おも][思]うと「もし」

#grammar-card[たい / #ruby[ほ][欲]しい][する#ruby[こと][事]がしたい (する#ruby[こと][事]の#ruby[はじ][始]め + たい)。#ruby[もの][物]が#ruby[ほ][欲]しい (#ruby[ほ][欲]しい)。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]きたい。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あたら][新]しい #ruby[いえ][家]が #ruby[ほ][欲]しい。]]

#grammar-card[たら / なら / ければ][たら = もしそれが#ruby[お][起]こったら (した + ら)。なら = もしそうなら。ければ = い の#ruby[こと][言]#ruby[ば][葉]の「もし」(い → ければ)。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あめ][雨]が #ruby[き][来]たら、#ruby[い][行]かない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[とき][時]があるなら、#ruby[き][来]てください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]ければ、#ruby[いえ][家]にいる。]]

#grammar-card[と#ruby[おも][思]う / と#ruby[い][言]う][と で#ruby[なん][何]でも#ruby[い][言]える。#ruby[おも][思]う#ruby[こと][事]、#ruby[い][言]う#ruby[こと][事]、#ruby[おと][音]。という = 「その#ruby[なまえ][名前]の」。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][良]いと #ruby[おも][思]う。]
#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[い][行]く」と #ruby[い][言]った。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[おお][大]きい#ruby[やま][山]という #ruby[ところ][所]]]

#grammar-card[ために][#ruby[なに][何]のためにするか。する#ruby[こと][事]+ために か #ruby[もの][物]+のために。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[し][知]るために #ruby[よ][読]む。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[こども][子供]のために。]]

#grammar-card[う / よう / ましょう][#ruby[ふた][二]りで#ruby[なに][何]かをする#ruby[こと][事]を#ruby[い][言]う。#ruby[い][行]こう = #ruby[ひと][一]つに#ruby[い][行]く。#ruby[た][食]べましょう = #ruby[ひと][一]つに#ruby[た][食]べる。する#ruby[こと][事]の#ruby[はじ][始]め + ましょう。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べましょう。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ふた][二]りで#ruby[い][行]きましょう。]]

#grammar-card[なくてはいけない / なきゃ][しなくてはいけない#ruby[こと][事]。ない → なくてはいけない。#ruby[はな][話]す#ruby[とき][時]は なきゃ だけでいい。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]まなきゃ。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[まい][毎]#ruby[にち][日]#ruby[ある][歩]かなくてはいけない。]]

#grammar-card[ほうがいい][した#ruby[ほう][方]がいい = するのが#ruby[よ][良]い。しない#ruby[ほう][方]がいい = しないのが#ruby[よ][良]い。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]んだほうがいい。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]かないほうがいい。]]

== #ruby[き][聞]き#ruby[かた][方]

#grammar-card[か / ね / よ][#ruby[き][聞]く / そうでしょう？ / #ruby[つよ][強]く#ruby[い][言]う。いつもの#ruby[こと][事]では か を#ruby[い][言]わない#ruby[こと][事]も#ruby[おお][多]い。][#block(inset: (top: 0.2em, bottom: 0.2em))[これは #ruby[みず][水]か？]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][良]い #ruby[にち][日]だね。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]くよ。]]

#grammar-card[#ruby[なに][何]・#ruby[だれ][誰]・どこ・いつ・なぜ + も/でも][#ruby[き][聞]く#ruby[こと][言]#ruby[ば][葉]は#ruby[い][言]う#ruby[こと][事]のところに#ruby[い][入]れる。+も (ない) = #ruby[なに][何]もない。+でも = #ruby[なん][何]でも。5つの#ruby[こと][言]#ruby[ば][葉] + 2つのつなぎ = 20の#ruby[こと][言]#ruby[ば][葉]が#ruby[つく][作]れる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なに][何]を #ruby[た][食]べる？→ #ruby[なに][何]も #ruby[た][食]べない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なん][何]でも #ruby[つく][作]れる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]もいない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]でもできる。]]

== いくつ

#grammar-card[つ (いくつ)][#ruby[もの][物]をいくつか#ruby[い][言]う#ruby[とき][時]に つ を#ruby[つか][使]う。#ruby[よ][読]み#ruby[かた][方]が#ruby[ぜんぶ][全部]#ruby[か][変]わる: 1=#ruby[ひと][一]つ 2=#ruby[ふた][二]つ 3=#ruby[みっ][三]つ 4=#ruby[よっ][四]つ 5=#ruby[いつ][五]つ 6=#ruby[むっ][六]つ 7=#ruby[なな][七]つ 8=#ruby[やっ][八]つ 9=#ruby[ここの][九]つ。10=#ruby[とお][十] (つ がない!)。#ruby[じゅう][十]より#ruby[うえ][上]はいくつだけ。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]を#ruby[みっ][三]つください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さかな][魚]を#ruby[ふた][二]つと#ruby[たまご][卵]を#ruby[いつ][五]つください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]を#ruby[やっ][八]つ#ruby[か][買]った。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]が#ruby[とお][十]ある。#ruby[ぜんぶ][全部]#ruby[た][食]べた。]]

#grammar-card[いくつの#ruby[つく][作]り#ruby[かた][方]][いくつの#ruby[まえ][前]に#ruby[じゅう][十]か#ruby[ひゃく][百]を#ruby[い][入]れる。#ruby[に][二]+#ruby[じゅう][十]=20。#ruby[さん][三]+#ruby[ひゃく][百]=300。#ruby[ぜんぶ][全部]#ruby[ひと][一]つにする: #ruby[さん][三]#ruby[びゃく][百]#ruby[ご][五]#ruby[じゅう][十]#ruby[に][二]=352。#ruby[ひゃく][百]の#ruby[まえ][前]で#ruby[おと][音]が#ruby[か][変]わる#ruby[こと][事]がある。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[に][二]#ruby[じゅう][十]#ruby[にん][人]の#ruby[ひと][人]が#ruby[き][来]た。]
#block(inset: (top: 0.2em, bottom: 0.2em))[これは#ruby[さん][三]#ruby[びゃく][百]#ruby[ご][五]#ruby[じゅう][十]#ruby[に][二]です。]]

#grammar-card[いくつの#ruby[よ][読]み#ruby[かた][方]][いつも#ruby[おな][同]じ#ruby[よ][読]み#ruby[かた][方]: いち(1) に(2) さん(3) ご(5) ろく(6) はち(8) じゅう(10) ひゃく(100)。#ruby[みっ][三]つだけ#ruby[ふた][二]つの#ruby[よ][読]み#ruby[かた][方]がある: し/よん(4) しち/なな(7) く/きゅう(9)。#ruby[わ][分]からない#ruby[とき][時]は よん なな きゅう を#ruby[つか][使]う。この#ruby[みっ][三]つの#ruby[かた][方]がいつも#ruby[つか][使]える。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[し][四]#ruby[がつ][月]に#ruby[あめ][雨]が#ruby[く][来]る。#ruby[よ][四]#ruby[じ][時]に#ruby[あ][会]う。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[しち][七]#ruby[がつ][月]は#ruby[あつ][暑]い。#ruby[なな][七]つの#ruby[やま][山]が#ruby[み][見]える。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[く][九]#ruby[がつ][月]から#ruby[さむ][寒]くなる。#ruby[きゅう][九]#ruby[じ][時]に#ruby[ね][寝]る。]
#block(inset: (top: 0.2em, bottom: 0.2em))[これは#ruby[さん][三]#ruby[びゃく][百]。それは#ruby[ろっ][六]#ruby[ぴゃく][百]。あれは#ruby[はっ][八]#ruby[ぴゃく][百]。]]

#pagebreak(weak: true)

= 言葉作り

== よく#ruby[つか][使]う#ruby[こと][言]#ruby[ば][葉]

#text(size: 9pt, fill: rgb("#666666"))[よく#ruby[つか][使]う#ruby[こと][言]#ruby[ば][葉]を206の#ruby[こと][言]#ruby[ば][葉]だけで#ruby[い][言]う。]

=== #ruby[ひと][人]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[す][好]きな#ruby[ひと][人]],
  [#ruby[ちち][父]と#ruby[はは][母]と#ruby[こども][子供]],
  [#ruby[おし][教]える#ruby[ひと][人]],
  [#ruby[おし][教]えてもらう#ruby[ひと][人]],
  [#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]],
  [#ruby[こころ][心]を#ruby[たす][助]ける#ruby[ひと][人]],
  [#ruby[まも][守]る#ruby[ひと][人]],
  [#ruby[たたか][戦]う#ruby[ひと][人]],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ひと][人]],
  [#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ひと][人]],
  [#ruby[ほん][本]を#ruby[か][書]く#ruby[ひと][人]],
  [よく#ruby[し][知]る#ruby[ひと][人]],
  [#ruby[うえ][上]の#ruby[ひと][人]],
  [#ruby[たす][助]ける#ruby[ひと][人]],
  [#ruby[もの][物]を#ruby[も][持]って#ruby[い][行]く#ruby[ひと][人]],
  [#ruby[いえ][家]が#ruby[ちか][近]い#ruby[ひと][人]],
  [#ruby[ちち][父]の#ruby[ちち][父]],
  [#ruby[はは][母]の#ruby[はは][母]],
  [#ruby[あたら][新]しい#ruby[こども][子供]],
  [#ruby[とし][年]が#ruby[おお][多]い#ruby[ひと][人]],
)]

=== #ruby[どうぶつ][動物]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [とても#ruby[ちい][小]さい#ruby[どうぶつ][動物]],
  [#ruby[ちい][小]さい#ruby[いえ][家]の#ruby[どうぶつ][動物]],
  [#ruby[はや][速]い#ruby[おお][大]きい#ruby[どうぶつ][動物]],
  [#ruby[なが][長]い#ruby[どうぶつ][動物]],
  [#ruby[うみ][海]のとても#ruby[おお][大]きい#ruby[どうぶつ][動物]],
  [#ruby[やま][山]の#ruby[つよ][強]い#ruby[どうぶつ][動物]],
  [#ruby[き][木]の#ruby[どうぶつ][動物]],
  [#ruby[みず][水]と#ruby[つち][土]の#ruby[どうぶつ][動物]],
  [#ruby[よる][夜]の#ruby[どうぶつ][動物]],
  [#ruby[つよ][強]い#ruby[どうぶつ][動物]],
  [とても#ruby[おお][大]きい#ruby[どうぶつ][動物]],
  [きれいな#ruby[ちい][小]さい#ruby[どうぶつ][動物]],
)]

=== #ruby[そと][外]の#ruby[もの][物]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[そら][空]の#ruby[こと][事]],
  [#ruby[そら][空]の#ruby[しろ][白]],
  [#ruby[よる][夜]の#ruby[ひかり][光]],
  [#ruby[つき][月]の#ruby[ひかり][光]],
  [#ruby[そら][空]の#ruby[ひ][火]],
  [#ruby[しろ][白]い#ruby[あめ][雨]],
  [#ruby[さむ][寒]い#ruby[みず][水]],
  [#ruby[しろ][白]い#ruby[かぜ][風]],
  [#ruby[つよ][強]い#ruby[かぜ][風]と#ruby[あめ][雨]],
  [#ruby[あめ][雨]の#ruby[あと][後]の#ruby[いろ][色]],
  [#ruby[つち][土]が#ruby[うご][動]く#ruby[こと][事]],
  [#ruby[みず][水]が#ruby[おお][多]すぎる#ruby[こと][事]],
  [#ruby[なが][長]い#ruby[みず][水]],
  [#ruby[おお][大]きい#ruby[みず][水]],
  [#ruby[うみ][海]の#ruby[なか][中]の#ruby[つち][土]],
  [#ruby[き][木]が#ruby[おお][多]い#ruby[ところ][所]],
  [#ruby[みず][水]がない#ruby[あつ][暑]い#ruby[ところ][所]],
  [#ruby[ひ][火]の#ruby[やま][山]],
  [#ruby[みず][水]が#ruby[した][下]に#ruby[い][行]く#ruby[ところ][所]],
  [#ruby[たいよう][太陽]が#ruby[で][出]る#ruby[とき][時]],
  [#ruby[たいよう][太陽]が#ruby[はい][入]る#ruby[とき][時]],
)]

=== #ruby[ところ][所]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[いえ][家]の#ruby[なか][中]],
  [#ruby[おし][教]える#ruby[ところ][所]],
  [#ruby[か][買]う#ruby[ところ][所]],
  [#ruby[た][食]べる#ruby[ところ][所]],
  [#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ところ][所]],
  [#ruby[ほん][本]が#ruby[おお][多]い#ruby[ところ][所]],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]],
  [#ruby[くさ][草]がある#ruby[ところ][所]],
  [#ruby[そと][外]の#ruby[ところ][所]],
  [#ruby[ひと][人]が#ruby[おお][多]い#ruby[ところ][所]],
  [#ruby[みず][水]の#ruby[うえ][上]の#ruby[みち][道]],
  [#ruby[たか][高]い#ruby[ところ][所]],
  [#ruby[で][出]られない#ruby[ところ][所]],
  [#ruby[そら][空]に#ruby[い][行]く#ruby[ところ][所]],
)]

=== #ruby[もの][物]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[つか][使]う#ruby[もの][物]],
  [#ruby[なか][中]に#ruby[い][入]れる#ruby[もの][物]],
  [#ruby[か][書]く#ruby[もの][物]],
  [#ruby[き][切]る#ruby[もの][物]],
  [#ruby[あ][開]ける#ruby[もの][物]],
  [#ruby[もの][物]を#ruby[も][持]つ#ruby[もの][物]],
  [#ruby[あめ][雨]の#ruby[もの][物]],
  [#ruby[ね][寝]る#ruby[ところ][所]],
  [#ruby[すわ][座]る#ruby[もの][物]],
  [#ruby[はい][入]る#ruby[ところ][所]],
  [#ruby[そと][外]を#ruby[み][見]る#ruby[ところ][所]],
  [#ruby[とき][時]を#ruby[み][見]る#ruby[もの][物]],
  [#ruby[わたし][私]を#ruby[み][見]る#ruby[もの][物]],
  [#ruby[ひ][火]の#ruby[ひかり][光]],
  [#ruby[なが][長]い#ruby[つよ][強]い#ruby[もの][物]],
  [#ruby[かんが][考]える#ruby[もの][物]],
  [#ruby[おと][音]で#ruby[い][言]う#ruby[もの][物]],
  [#ruby[はや][速]く#ruby[い][行]く#ruby[もの][物]],
  [#ruby[みず][水]の#ruby[うえ][上]の#ruby[もの][物]],
  [#ruby[そら][空]を#ruby[い][行]く#ruby[もの][物]],
)]

=== #ruby[た][食]べ#ruby[もの][物]と#ruby[からだ][体]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[き][木]の#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[くさ][草]の#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[しろ][白]い#ruby[どうぶつ][動物]の#ruby[みず][水]],
  [#ruby[からだ][体]を#ruby[よ][良]くする#ruby[もの][物]],
  [#ruby[からだ][体]を#ruby[わる][悪]くする#ruby[もの][物]],
  [#ruby[め][目]と#ruby[くち][口]がある#ruby[ところ][所]],
  [#ruby[からだ][体]の#ruby[なか][中]の#ruby[あか][赤]い#ruby[みず][水]],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[こと][事]],
  [#ruby[からだ][体]が#ruby[あつ][暑]い],
  [#ruby[わる][悪]い#ruby[かん][感]じ],
  [#ruby[ね][寝]る#ruby[とき][時]に#ruby[み][見]る#ruby[こと][事]],
  [#ruby[た][食]べ#ruby[もの][物]が#ruby[ほ][欲]しい],
  [#ruby[からだ][体]が#ruby[おも][重]い],
)]

=== #ruby[とき][時]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[まえ][前]の#ruby[にち][日]],
  [#ruby[あと][後]の#ruby[にち][日]],
  [#ruby[にち][日]の#ruby[なか][中]],
  [#ruby[よる][夜]の#ruby[なか][中]],
  [#ruby[いま][今]の#ruby[よる][夜]],
  [#ruby[あつ][暑]くなる#ruby[とき][時]],
  [#ruby[あつ][暑]い#ruby[とき][時]],
  [#ruby[さむ][寒]くなる#ruby[とき][時]],
  [#ruby[さむ][寒]い#ruby[とき][時]],
  [#ruby[お][終]わらない#ruby[とき][時]],
  [とても#ruby[まえ][前]の#ruby[とき][時]],
  [#ruby[あと][後]の#ruby[とき][時]],
  [する#ruby[こと][事]がない#ruby[にち][日]],
)]

=== どんな - 「ない」で#ruby[か][変]わる

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[なが][長]くない],
  [#ruby[たか][高]くない],
  [#ruby[おも][重]くない],
  [#ruby[つよ][強]くない],
  [#ruby[はや][速]くない],
  [#ruby[あたら][新]しくない],
  [きれいじゃない],
  [#ruby[あか][明]るくない],
  [#ruby[おと][音]がない],
  [#ruby[よ][良]くない],
  [#ruby[ひつよう][必要]じゃない],
  [できない],
  [#ruby[し][知]らない],
  [#ruby[み][見]えない],
  [#ruby[なか][中]に#ruby[なに][何]もない],
  [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こらない],
  [#ruby[たの][楽]しくない],
)]

=== する#ruby[こと][事]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[はや][速]く#ruby[あし][足]で#ruby[うご][動]く],
  [#ruby[みず][水]の#ruby[なか][中]を#ruby[うご][動]く],
  [#ruby[うえ][上]に#ruby[い][行]く],
  [#ruby[はや][速]く#ruby[うえ][上]に#ruby[うご][動]く],
  [#ruby[した][下]に#ruby[い][行]く],
  [#ruby[いえ][家]に#ruby[い][行]く],
  [#ruby[なに][何]もしない],
  [#ruby[たの][楽]しい#ruby[こと][事]をする],
  [#ruby[あたら][新]しく#ruby[し][知]る],
  [#ruby[し][知]らなくなる],
  [#ruby[み][見]えない#ruby[ところ][所]に#ruby[い][行]く],
  [#ruby[おと][音]を#ruby[つく][作]る],
  [#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る],
  [#ruby[ひと][人]の#ruby[もの][物]を#ruby[も][持]って#ruby[い][行]く],
  [#ruby[みず][水]できれいにする],
  [#ruby[わる][悪]くなった#ruby[もの][物]を#ruby[よ][良]くする],
  [#ruby[くさ][草]を#ruby[つち][土]に#ruby[い][入]れる],
  [#ruby[いろ][色]で#ruby[もの][物]を#ruby[つく][作]る],
)]

=== #ruby[こころ][心]と#ruby[かんが][考]え

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[い][生]きる#ruby[こと][事]],
  [#ruby[し][死]ぬ#ruby[こと][事]],
  [#ruby[こころ][心]がとても#ruby[す][好]きな#ruby[こと][事]],
  [#ruby[おこ][怒]る#ruby[こと][事]],
  [#ruby[こわ][怖]いと#ruby[かん][感]じる#ruby[こと][事]],
  [#ruby[よ][良]い#ruby[こと][事]を#ruby[ま][待]つ#ruby[こと][事]],
  [#ruby[たたか][戦]わない#ruby[こと][事]],
  [#ruby[くに][国]と#ruby[くに][国]が#ruby[たたか][戦]う#ruby[こと][事]],
  [#ruby[す][好]きにできる#ruby[こと][事]],
  [#ruby[ほんとう][本当]の#ruby[こと][事]],
  [#ruby[ほんとう][本当]じゃない#ruby[こと][事]],
  [#ruby[あたら][新]しい#ruby[かんが][考]え],
  [#ruby[よ][良]い#ruby[こと][事]が#ruby[お][起]こる#ruby[こと][事]],
  [#ruby[ほか][他]の#ruby[ひと][人]が#ruby[し][知]らない#ruby[こと][事]],
  [きれいな#ruby[おと][音]],
  [#ruby[なが][長]い#ruby[ことば][言葉]],
  [#ruby[おと][音]と#ruby[ことば][言葉]],
  [#ruby[か][書]いた#ruby[ことば][言葉]],
  [#ruby[あた][与]える#ruby[もの][物]],
  [#ruby[くに][国]の#ruby[ことば][言葉]],
  [#ruby[わる][悪]くした#ruby[こと][事]],
  [#ruby[こころ][心]が#ruby[よ][良]い#ruby[こと][事]],
  [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こる],
)]

=== なくなった#ruby[こと][言]#ruby[ば][葉]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[たいよう][太陽]が#ruby[で][出]る#ruby[とき][時]],
  [#ruby[いま][今]の#ruby[にち][日]],
  [する#ruby[こと][事]],
  [#ruby[わる][悪]い#ruby[こと][事]],
  [#ruby[ことば][言葉]の#ruby[こと][事]],
  [とても#ruby[ひつよう][必要]],
  [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こる],
  [#ruby[ぜんぶ][全部]の#ruby[ところ][所]],
  [#ruby[て][手]で#ruby[かん][感]じる],
)]

=== #ruby[まい][毎]#ruby[にち][日]の#ruby[こと][事]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[まい][毎]#ruby[にち][日]する#ruby[こと][事]],
  [#ruby[そと][外]にいる#ruby[ひと][人]と#ruby[ことば][言葉]を#ruby[つか][使]う#ruby[もの][物]],
  [#ruby[み][見]た#ruby[もの][物]を#ruby[か][書]いた#ruby[もの][物]],
  [#ruby[ひと][人]が#ruby[うご][動]く#ruby[こと][事]を#ruby[み][見]る#ruby[もの][物]],
  [きれいな#ruby[おと][音]],
  [#ruby[まい][毎]#ruby[にち][日]#ruby[か][書]く#ruby[ほん][本]],
  [#ruby[おお][多]い#ruby[こと][事]を#ruby[か][書]いた#ruby[ほん][本]],
  [#ruby[ひと][人]に#ruby[か][書]く#ruby[ことば][言葉]],
  [#ruby[も][持]つ#ruby[もの][物]],
  [#ruby[いえ][家]を#ruby[あ][開]ける#ruby[もの][物]],
  [#ruby[いえ][家]の#ruby[なか][中]に#ruby[そと][外]の#ruby[ひかり][光]が#ruby[はい][入]る#ruby[ところ][所]],
  [#ruby[いえ][家]の#ruby[みぎ][右]と#ruby[ひだり][左]にある#ruby[もの][物]],
  [#ruby[いえ][家]の#ruby[なか][中]の#ruby[した][下]],
  [#ruby[いえ][家]の#ruby[うえ][上]にある#ruby[もの][物]],
  [#ruby[た][食]べる#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]],
  [#ruby[からだ][体]を#ruby[みず][水]できれいにする#ruby[ところ][所]],
  [#ruby[いえ][家]の#ruby[なか][中]の#ruby[ところ][所]],
  [#ruby[ところ][所]をきれいにする#ruby[こと][事]],
  [#ruby[ふく][服]を#ruby[みず][水]できれいにする#ruby[こと][事]],
  [#ruby[た][食]べる#ruby[もの][物]を#ruby[つく][作]る#ruby[こと][事]],
  [#ruby[もの][物]を#ruby[か][買]う#ruby[こと][事]],
  [#ruby[そと][外]を#ruby[うご][動]いていく#ruby[こと][事]],
  [#ruby[まえ][前]にする#ruby[こと][事]],
  [#ruby[はじ][始]まる#ruby[まえ][前]にする#ruby[こと][事]],
  [#ruby[ひと][人]に「する」と#ruby[い][言]う#ruby[こと][事]],
  [#ruby[あと][後]にする#ruby[こと][事]],
  [#ruby[す][好]きでする#ruby[こと][事]],
  [#ruby[よ][良]くなるために#ruby[なに][何]かを#ruby[おお][多]くする#ruby[こと][事]],
  [#ruby[し][知]るために#ruby[よ][読]んだり#ruby[き][聞]いたりする#ruby[こと][事]],
  [#ruby[いえ][家]で#ruby[よ][読]んだり#ruby[か][書]いたりする#ruby[こと][事]],
  [#ruby[し][知]りたい#ruby[こと][事]を#ruby[き][聞]く#ruby[ことば][言葉]],
  [#ruby[き][聞]かれた#ruby[こと][事]を#ruby[い][言]う#ruby[こと][事]],
  [#ruby[ひと][人]の#ruby[ことば][言葉]に#ruby[い][言]う#ruby[こと][事]],
  [#ruby[あ][会]った#ruby[とき][時]に#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[ひと][人]に#ruby[し][知]らせる#ruby[こと][事]],
  [#ruby[ひと][人]と#ruby[かんが][考]える#ruby[こと][事]],
  [#ruby[ひと][人]や#ruby[もの][物]の#ruby[こと][事]を#ruby[ほか][他]の#ruby[ひと][人]に#ruby[おし][教]える#ruby[こと][事]],
  [#ruby[ひと][人]に「#ruby[き][来]てください」と#ruby[い][言]う#ruby[こと][事]],
  [#ruby[まえ][前]にした#ruby[こと][事]],
  [#ruby[あと][後]にする#ruby[こと][事]を#ruby[かんが][考]える#ruby[こと][事]],
  [よく#ruby[み][見]てほしい#ruby[こと][事]],
  [「これをください」と#ruby[い][言]う#ruby[こと][事]],
  [#ruby[もの][物]を#ruby[か][買]うお#ruby[おかね][金]],
  [お#ruby[おかね][金]が#ruby[すこ][少]しで#ruby[よ][良]くなる#ruby[こと][事]],
  [お#ruby[おかね][金]がない#ruby[こと][事]],
  [#ruby[へん][変]ではない],
  [#ruby[ほか][他]と#ruby[ちが][違]う#ruby[よ][良]い#ruby[こと][事]],
  [とても#ruby[ひつよう][必要]な],
  [だれでもできる],
  [#ruby[おお][多]くの#ruby[こと][事]が#ruby[なか][中]にある],
  [よく#ruby[つか][使]える#ruby[よ][良]い],
  [よく#ruby[つか][使]えない#ruby[わる][悪]い],
  [#ruby[ひと][人]に#ruby[よ][良]い#ruby[ことば][言葉]を#ruby[つか][使]う],
  [その#ruby[とき][時]に#ruby[よ][良]い],
  [したい#ruby[こと][事]ができる],
  [#ruby[ほか][他]の#ruby[くに][国]や#ruby[ところ][所]に#ruby[い][行]く#ruby[こと][事]],
  [#ruby[そら][空]の#ruby[いま][今]の#ruby[こと][事]],
  [#ruby[とし][年]の#ruby[なか][中]の#ruby[とき][時]],
)]

=== する#ruby[こと][事]と#ruby[し][知]る#ruby[こと][事]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [する#ruby[こと][事]],
  [する#ruby[こと][事]をする#ruby[ところ][所]],
  [する#ruby[こと][事]の#ruby[ところ][所]で#ruby[ひと][一]つだけ#ruby[うえ][上]の#ruby[ひと][人]],
  [する#ruby[こと][事]の#ruby[ところ][所]でする#ruby[こと][事]をする#ruby[ひと][人]],
  [する#ruby[こと][事]の#ruby[ところ][所]の#ruby[なか][中]の#ruby[おお][大]きい#ruby[ところ][所]の#ruby[うえ][上]の#ruby[ひと][人]],
  [する#ruby[こと][事]で#ruby[うえ][上]にいる#ruby[ひと][人]],
  [する#ruby[こと][事]で#ruby[した][下]にいる#ruby[ひと][人]],
  [する#ruby[こと][事]の#ruby[ところ][所]でする#ruby[こと][事]をする#ruby[ほか][他]の#ruby[ひと][人]],
  [#ruby[く][来]る#ruby[ひと][人]],
  [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[き][来]て#ruby[かんが][考]える#ruby[こと][事]],
  [する#ruby[こと][事]に#ruby[つか][使]う#ruby[か][書]いた#ruby[もの][物]],
  [した#ruby[こと][事]を#ruby[うえ][上]の#ruby[ひと][人]に#ruby[い][言]う#ruby[こと][事]],
  [#ruby[し][知]らない#ruby[ひと][人]に#ruby[ことば][言葉]で#ruby[おし][教]える#ruby[こと][事]],
  [#ruby[ひと][人]と#ruby[ちが][違]う#ruby[かんが][考]えを#ruby[い][言]う#ruby[こと][事]],
  [#ruby[ひと][人]と「する」と#ruby[か][書]いた#ruby[もの][物]],
  [する#ruby[こと][事]をしてもらうお#ruby[かね][金]],
  [#ruby[とき][時]が#ruby[お][終]わった#ruby[あと][後]もする#ruby[こと][事]],
  [する#ruby[こと][事]で#ruby[ほか][他]の#ruby[ところ][所]に#ruby[い][行]く#ruby[こと][事]],
  [する#ruby[こと][事]を#ruby[ちが][違]う#ruby[もの][物]に#ruby[か][変]える#ruby[こと][事]],
  [する#ruby[こと][事]を#ruby[お][終]わらせる#ruby[こと][事]],
  [はじめてする#ruby[こと][事]を#ruby[はじ][始]める#ruby[こと][事]],
  [する#ruby[こと][事]のために#ruby[あ][会]って#ruby[ことば][言葉]を#ruby[つか][使]う#ruby[こと][事]],
  [#ruby[し][知]っているかを#ruby[み][見]る#ruby[こと][事]],
  [#ruby[し][知]っている#ruby[こと][事]を#ruby[み][見]た#ruby[とき][時]の#ruby[よ][良]さ],
  [#ruby[おし][教]える#ruby[ところ][所]が#ruby[お][終]わる#ruby[こと][事]],
  [#ruby[おし][教]える#ruby[ところ][所]に#ruby[はい][入]る#ruby[こと][事]],
  [#ruby[おし][教]える#ruby[ところ][所]で#ruby[おし][教]えてもらう#ruby[こと][事]],
  [#ruby[おし][教]える#ruby[ところ][所]],
  [#ruby[おし][教]える#ruby[ところ][所]],
  [#ruby[おお][大]きい#ruby[おし][教]える#ruby[ところ][所]],
  [まだ#ruby[し][知]らない#ruby[こと][事]を#ruby[さが][探]す#ruby[こと][事]],
  [#ruby[し][知]るために#ruby[もの][物]を#ruby[つか][使]ってみる#ruby[こと][事]],
  [#ruby[もの][物]を#ruby[つく][作]ったり#ruby[つか][使]ったりできる#ruby[こと][事]],
  [できる#ruby[こと][事]],
  [#ruby[よ][良]くなるためにとても#ruby[つよ][強]くする#ruby[こと][事]],
  [したい#ruby[こと][事]ができた#ruby[こと][事]],
  [したい#ruby[こと][事]ができなかった#ruby[こと][事]],
  [した#ruby[あと][後]に#ruby[お][起]こる#ruby[こと][事]],
  [したい#ruby[こと][事]の#ruby[ところ][所]],
  [なぜかの#ruby[こと][事]],
  [どうするかの#ruby[こと][事]],
  [#ruby[よ][良]くない#ruby[こと][事]が#ruby[お][起]こっている],
  [#ruby[わる][悪]い#ruby[こと][事]を#ruby[よ][良]くする#ruby[こと][事]],
  [しなければならない#ruby[こと][事]],
  [しなければならない#ruby[こと][事]と、してはいけない#ruby[こと][事]],
  [「していい」と#ruby[い][言]う#ruby[こと][事]],
  [しなければならない#ruby[こと][事]],
  [#ruby[よ][良]いか#ruby[わる][悪]いかを#ruby[み][見]る#ruby[こと][事]],
  [#ruby[おお][多]くの#ruby[ひと][人]に#ruby[い][言]う#ruby[こと][事]],
  [#ruby[わたし][私]が#ruby[おも][思]う#ruby[こと][事]],
  [#ruby[おし][教]える#ruby[ひと][人]],
  [#ruby[おし][教]える#ruby[ところ][所]で#ruby[おし][教]えてもらう#ruby[こども][子供]],
)]

=== いくつと#ruby[い][言]い#ruby[かた][方]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[じゅう][十]が#ruby[じゅう][十]],
  [#ruby[じゅう][十]の#ruby[じゅう][十]が#ruby[じゅう][十]],
  [#ruby[じゅう][十]の#ruby[じゅう][十]の#ruby[じゅう][十]が#ruby[じゅう][十]],
  [#ruby[ひと][一]つの#ruby[もの][物]を#ruby[ふた][二]つに#ruby[き][切]った#ruby[ひと][一]つ],
  [もう#ruby[ひと][一]つ#ruby[おお][多]い#ruby[こと][事]],
  [その#ruby[もの][物]の#ruby[なまえ][名前]になる#ruby[おお][多]さ],
  [いくつあるかを#ruby[い][言]う#ruby[もの][物]],
  [#ruby[なに][何]かをした#ruby[おお][多]さ],
  [#ruby[なに][何]かが#ruby[お][起]こった#ruby[おお][多]さ],
  [#ruby[ほん][本]の#ruby[なか][中]のような#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[なが][長]い#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[どうぶつ][動物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[うご][動]く#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[の][飲]む#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[ほん][本]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[あし][足]に#ruby[き][着]る#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[からだ][体]に#ruby[き][着]る#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[じゅう][十]の#ruby[なか][中]の#ruby[ひと][一]つ],
  [#ruby[まえ][前]からいくつ#ruby[め][目]かを#ruby[い][言]う#ruby[ことば][言葉]],
  [#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[まえ][前]],
  [#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[まえ][前]の#ruby[とき][時]],
  [#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[あと][後]の#ruby[とき][時]],
  [#ruby[ぜんぶ][全部]の#ruby[おお][多]さ],
  [#ruby[ぜんぶ][全部]を#ruby[ひと][一]つにした#ruby[おお][多]さ],
)]

=== #ruby[ひと][人]と#ruby[ひと][人]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[いえ][家]の#ruby[ひと][人]たち],
  [#ruby[おとこ][男]の#ruby[うえ][上]の#ruby[こども][子供]],
  [#ruby[おとこ][男]の#ruby[した][下]の#ruby[こども][子供]],
  [#ruby[おんな][女]の#ruby[うえ][上]の#ruby[こども][子供]],
  [#ruby[おんな][女]の#ruby[した][下]の#ruby[こども][子供]],
  [#ruby[おんな][女]の#ruby[ひと][人]の#ruby[おとこ][男]],
  [#ruby[おとこ][男]の#ruby[ひと][人]の#ruby[おんな][女]],
  [#ruby[わたし][私]の#ruby[おとこ][男]の#ruby[こども][子供]],
  [#ruby[わたし][私]の#ruby[おんな][女]の#ruby[こども][子供]],
  [#ruby[こども][子供]の#ruby[ちち][父]または#ruby[はは][母]],
  [#ruby[ちち][父]の#ruby[ちち][父]],
  [#ruby[ちち][父]の#ruby[はは][母]],
  [#ruby[こども][子供]の#ruby[こども][子供]],
  [よく#ruby[あ][会]う#ruby[す][好]きな#ruby[ひと][人]],
  [とても#ruby[す][好]きな#ruby[ひと][人]],
  [あの#ruby[おとこ][男]の#ruby[ひと][人]],
  [あの#ruby[おんな][女]の#ruby[ひと][人]],
  [#ruby[まえ][前]からいる#ruby[ひと][人]],
  [#ruby[あと][後]から#ruby[き][来]た#ruby[ひと][人]],
  [よく#ruby[あ][会]う#ruby[ひと][人]たち],
  [#ruby[ちか][近]くにいる#ruby[ひと][人]],
  [#ruby[あ][会]っている#ruby[ひと][人]],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]],
  [まだ#ruby[おお][大]きくなっていない#ruby[こども][子供]],
  [#ruby[とし][年]が#ruby[すこ][少]しの#ruby[ひと][人]],
  [#ruby[とし][年]が#ruby[おお][多]い#ruby[ひと][人]],
  [#ruby[おお][大]きくなった#ruby[ひと][人]],
  [#ruby[おし][教]える#ruby[ひと][人]],
  [#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]],
  [#ruby[わる][悪]いことをする#ruby[ひと][人]を#ruby[と][止]める#ruby[ひと][人]],
  [#ruby[たたか][戦]う#ruby[ひと][人]],
  [#ruby[くに][国]で#ruby[たか][高]い#ruby[ひと][人]],
  [とても#ruby[つよ][強]い#ruby[うえ][上]にいる#ruby[ひと][人]],
  [その#ruby[くに][国]にいる#ruby[ひと][人]],
  [その#ruby[くに][国]の#ruby[ぜんぶ][全部]の#ruby[ひと][人]],
  [#ruby[たたか][戦]う#ruby[わる][悪]い#ruby[ひと][人]],
  [よく#ruby[たす][助]けてくれる#ruby[ひと][人]],
  [#ruby[わる][悪]いことをされた#ruby[ひと][人]],
  [#ruby[わる][悪]いことをした#ruby[ひと][人]],
  [#ruby[そと][外]の#ruby[くに][国]から#ruby[き][来]た#ruby[ひと][人]],
  [その#ruby[ところ][所]を#ruby[み][見]に#ruby[き][来]た#ruby[ひと][人]],
  [#ruby[うご][動]く#ruby[もの][物]の#ruby[なか][中]にいる#ruby[ひと][人]],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[ひと][人]],
  [#ruby[えら][選]ばれた#ruby[ひと][人]],
  [#ruby[くち][口]から#ruby[おと][音]を#ruby[だ][出]す#ruby[ひと][人]],
  [#ruby[ほん][本]を#ruby[つく][作]る#ruby[ひと][人]],
  [きれいな#ruby[もの][物]を#ruby[つく][作]る#ruby[ひと][人]],
  [#ruby[うえ][上]にいる#ruby[ひと][人]],
  [#ruby[した][下]にいる#ruby[ひと][人]],
  [#ruby[き][来]た#ruby[ひと][人]],
)]

=== #ruby[こころ][心]の#ruby[かん][感]じ

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[よ][良]いことがあった#ruby[こころ][心]],
  [#ruby[ひと][一]りで#ruby[かな][悲]しい],
  [#ruby[ひと][人]に#ruby[み][見]られたくない#ruby[こころ][心]],
  [#ruby[からだ][体]も#ruby[こころ][心]もとても#ruby[わる][悪]い],
  [とても#ruby[かな][悲]しくて#ruby[わる][悪]い],
  [#ruby[ひと][人]に#ruby[よ][良]くする#ruby[こころ][心]がある],
  [とても#ruby[つよ][強]くて#ruby[わる][悪]いことを#ruby[と][止]める],
  [#ruby[へん][変]なことをしない#ruby[よ][良]い#ruby[こころ][心]],
  [#ruby[よ][良]くしようと#ruby[かんが][考]える#ruby[ひと][人]],
  [#ruby[からだ][体]も#ruby[こころ][心]も#ruby[よ][良]い],
  [#ruby[よ][良]いことが#ruby[おお][多]くある#ruby[こころ][心]],
  [これから#ruby[わる][悪]いことが#ruby[く][来]るかもしれないと#ruby[おも][思]う#ruby[こころ][心]],
  [#ruby[わる][悪]いことが#ruby[お][起]こるかもと#ruby[かんが][考]える],
  [#ruby[こわ][怖]くて#ruby[からだ][体]が#ruby[うご][動]きにくい],
  [#ruby[こころ][心]が#ruby[おお][大]きく#ruby[うご][動]く],
  [ありがとうと#ruby[おも][思]う#ruby[こころ][心]],
  [#ruby[まえ][前]にしたことが#ruby[わる][悪]かったと#ruby[おも][思]う],
  [#ruby[わたし][私]は#ruby[よ][良]いと#ruby[おも][思]う#ruby[つよ][強]い#ruby[こころ][心]],
  [#ruby[よ][良]いことが#ruby[く][来]ると#ruby[おも][思]って#ruby[ま][待]つ],
  [#ruby[よ][良]いことが#ruby[お][起]こってほしいと#ruby[おも][思]う],
  [#ruby[よ][良]いことはないと#ruby[おも][思]う],
  [もっと#ruby[し][知]りたいと#ruby[おも][思]う#ruby[こころ][心]],
  [#ruby[たの][楽]しいことが#ruby[なに][何]もない],
  [#ruby[し][知]らなかったことが#ruby[お][起]こって#ruby[かん][感]じる],
  [どうすればいいか#ruby[おも][思]えなくて#ruby[わる][悪]い],
  [どれを#ruby[えら][選]ぶかと#ruby[かんが][考]えて#ruby[と][止]まる],
  [#ruby[はや][速]くしなければと#ruby[おも][思]って#ruby[こわ][怖]い],
  [#ruby[わる][悪]くても#ruby[と][止]まらずにいること],
  [#ruby[わる][悪]いことをした#ruby[ひと][人]を#ruby[よ][良]いと#ruby[い][言]う],
  [#ruby[ほんとう][本当]だと#ruby[おも][思]う],
  [#ruby[ほんとう][本当]かどうかと#ruby[おも][思]う],
  [とても#ruby[よ][良]い#ruby[ひと][人]だと#ruby[おも][思]う],
  [とても#ruby[わる][悪]い#ruby[ひと][人]だと#ruby[おも][思]う],
  [#ruby[かな][悲]しい#ruby[ひと][人]の#ruby[こころ][心]を#ruby[かん][感]じる],
  [#ruby[ほか][他]の#ruby[ひと][人]が#ruby[も][持]っているものを#ruby[ほ][欲]しいと#ruby[おも][思]う],
  [#ruby[わる][悪]いことをされてまだ#ruby[おこ][怒]る],
  [あの#ruby[ひと][人]のようになりたいと#ruby[おも][思]う],
  [もう#ruby[よ][良]いと#ruby[かん][感]じる],
  [まだ#ruby[よ][良]くないと#ruby[おも][思]う],
  [#ruby[ひと][一]りしかいなくて#ruby[かな][悲]しい],
  [#ruby[こわ][怖]くても#ruby[まえ][前]に#ruby[い][行]く#ruby[つよ][強]い#ruby[こころ][心]],
  [#ruby[わたし][私]は#ruby[よ][良]いと#ruby[かん][感]じる#ruby[つよ][強]い#ruby[こころ][心]],
  [ある#ruby[ひと][人]がとても#ruby[す][好]きになる#ruby[こころ][心]],
  [ある#ruby[ひと][人]をとても#ruby[よ][良]くしたい#ruby[つよ][強]い#ruby[こころ][心]],
  [#ruby[わる][悪]いことが#ruby[お][起]こって#ruby[おこ][怒]る#ruby[こころ][心]],
  [#ruby[よ][良]いことが#ruby[お][起]こって#ruby[わら][笑]いたい#ruby[こころ][心]],
  [#ruby[し][知]らなかったことを#ruby[み][見]たり#ruby[き][聞]いたりした#ruby[こころ][心]],
  [とても#ruby[こわ][怖]い#ruby[こころ][心]],
  [#ruby[おこ][怒]らないで#ruby[よ][良]く#ruby[かんが][考]える],
  [#ruby[ほか][他]の#ruby[ひと][人]の#ruby[よ][良]いものを#ruby[ほ][欲]しいと#ruby[おも][思]う],
)]

=== #ruby[ひと][人]の#ruby[なか][中]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[ひと][人]たちがいる#ruby[ところ][所]],
  [#ruby[くに][国]をどうするかを#ruby[えら][選]ぶこと],
  [お#ruby[おかね][金]と#ruby[もの][物]の#ruby[うご][動]き],
  [#ruby[くに][国]の#ruby[ひと][人]がしなければならないこと],
  [#ruby[ひと][人]がしてもいいこと],
  [#ruby[ひと][人]がしなければならないこと],
  [したいことができること],
  [#ruby[たたか][戦]いがない#ruby[よ][良]い#ruby[とき][時]],
  [#ruby[くに][国]と#ruby[くに][国]が#ruby[たたか][戦]うこと],
  [#ruby[くに][国]のために#ruby[たたか][戦]う#ruby[ひと][人]たち],
  [#ruby[くに][国]を#ruby[うご][動]かす#ruby[ひと][人]たち],
  [#ruby[くに][国]を#ruby[うご][動]かす#ruby[ひと][人]を#ruby[えら][選]ぶこと],
  [#ruby[くに][国]に#ruby[あた][与]えるお#ruby[おかね][金]],
  [#ruby[まえ][前]に#ruby[お][起]こったこと],
  [その#ruby[くに][国]の#ruby[ひと][人]たちがすること],
  [#ruby[ひと][人]の#ruby[うえ][上]にいる#ruby[つよ][強]い#ruby[もの][物]を#ruby[おも][思]うこと],
  [#ruby[ひと][人]に#ruby[おし][教]えること],
  [#ruby[もの][物]がどうなっているかを#ruby[し][知]ること],
  [きれいな#ruby[もの][物]を#ruby[つく][作]ること],
  [#ruby[ことば][言葉]で#ruby[つく][作]った#ruby[ほん][本]],
  [なぜ#ruby[い][生]きるかを#ruby[かんが][考]えること],
  [#ruby[まえ][前]からある#ruby[こと][事]],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]で#ruby[たの][楽]しくする#ruby[にち][日]],
  [#ruby[ひと][人]たちが#ruby[まえ][前]からする#ruby[こと][事]],
  [#ruby[おとこ][男]と#ruby[おんな][女]が#ruby[いえ][家]の#ruby[ひと][人]になること],
  [#ruby[し][死]んだ#ruby[ひと][人]のためにする#ruby[こと][事]],
  [#ruby[わる][悪]いことが#ruby[お][起]こった#ruby[こと][事]],
  [#ruby[おも][思]わないで#ruby[わる][悪]いことが#ruby[お][起]こること],
  [#ruby[ひと][人]がしてはいけない#ruby[わる][悪]いこと],
  [#ruby[わる][悪]いことをしたかどうかを#ruby[ひと][人]が#ruby[い][言]うこと],
  [#ruby[わる][悪]いことをした#ruby[ひと][人]に#ruby[あた][与]える#ruby[わる][悪]いこと],
  [#ruby[まい][毎]#ruby[にち][日]の#ruby[こと][事]が#ruby[か][書]いてある#ruby[ほん][本]],
  [#ruby[おお][多]くの#ruby[ひと][人]に#ruby[おと][音]や#ruby[ひかり][光]で#ruby[ことば][言葉]を#ruby[だ][出]すこと],
  [#ruby[もの][物]を#ruby[か][買]ってほしいと#ruby[い][言]うこと],
  [#ruby[ひと][人]に#ruby[し][知]らせること],
  [#ruby[ひと][人]に#ruby[ことば][言葉]を#ruby[だ][出]すこと],
  [#ruby[もの][物]を#ruby[つく][作]るための#ruby[し][知]ること],
  [#ruby[おお][多]くの#ruby[もの][物]を#ruby[つく][作]ること],
  [#ruby[くに][国]と#ruby[くに][国]で#ruby[もの][物]を#ruby[か][買]ったり#ruby[あた][与]えたりすること],
  [#ruby[ひと][人]の#ruby[そと][外]にある#ruby[みず][水]や#ruby[かぜ][風]や#ruby[つち][土]],
  [#ruby[みず][水]や#ruby[かぜ][風]が#ruby[わる][悪]くなること],
  [#ruby[ひと][人]が#ruby[つか][使]える#ruby[もの][物]],
  [その#ruby[ところ][所]にいる#ruby[ひと][人]の#ruby[おお][多]さ],
  [ある#ruby[ひと][人]を#ruby[ほか][他]の#ruby[ひと][人]より#ruby[わる][悪]くすること],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]が#ruby[よ][良]いとすること],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]が#ruby[くに][国]のことを#ruby[えら][選]べること],
  [#ruby[くに][国]のやることを#ruby[おお][大]きく#ruby[か][変]えること],
  [#ruby[ほか][他]の#ruby[くに][国]が#ruby[も][持]っている#ruby[ところ][所]],
  [#ruby[ほか][他]の#ruby[くに][国]に#ruby[い][行]ってそこにいる#ruby[ひと][人]],
  [#ruby[こわ][怖]いので#ruby[くに][国]から#ruby[で][出]た#ruby[ひと][人]],
)]

=== #ruby[ところ][所]と#ruby[おお][大]きい#ruby[もの][物]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[おお][多]くの#ruby[ひと][人]がいる#ruby[ところ][所]],
  [とても#ruby[おお][多]くの#ruby[ひと][人]がいる#ruby[おお][大]きい#ruby[ところ][所]],
  [#ruby[ひと][人]が#ruby[すこ][少]しだけいる#ruby[ところ][所]],
  [#ruby[ひと][人]が#ruby[く][来]る#ruby[もの][物]を#ruby[ま][待]つ#ruby[ところ][所]],
  [#ruby[もの][物]を#ruby[か][買]う#ruby[ところ][所]],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[ひと][人]を#ruby[たす][助]ける#ruby[ところ][所]],
  [お#ruby[おかね][金]を#ruby[まも][守]る#ruby[ところ][所]],
  [#ruby[か][書]いた#ruby[もの][物]を#ruby[ほか][他]の#ruby[ひと][人]に#ruby[あた][与]える#ruby[ところ][所]],
  [#ruby[ほん][本]を#ruby[よ][読]む#ruby[ところ][所]],
  [きれいな#ruby[もの][物]を#ruby[み][見]る#ruby[ところ][所]],
  [#ruby[くに][国]の#ruby[もの][物]を#ruby[み][見]る#ruby[ところ][所]],
  [#ruby[ひと][人]が#ruby[み][見]せる#ruby[こと][事]をする#ruby[ところ][所]],
  [#ruby[おお][大]きい#ruby[ひかり][光]の#ruby[もの][物]を#ruby[み][見]る#ruby[ところ][所]],
  [#ruby[そと][外]で#ruby[たの][楽]しくいられる#ruby[ところ][所]],
  [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[く][来]る#ruby[そと][外]の#ruby[ところ][所]],
  [#ruby[みず][水]の#ruby[うえ][上]を#ruby[い][行]く#ruby[みち][道]],
  [#ruby[たか][高]くて#ruby[なが][長]い#ruby[もの][物]],
  [#ruby[つよ][強]い#ruby[ひと][人]が#ruby[まも][守]る#ruby[おお][大]きい#ruby[いえ][家]],
  [#ruby[ひと][人]が#ruby[こころ][心]の#ruby[こと][事]を#ruby[かんが][考]える#ruby[ところ][所]],
  [この#ruby[くに][国]の#ruby[こころ][心]に#ruby[い][言]う#ruby[ところ][所]],
  [#ruby[ひと][人]が#ruby[こころ][心]に#ruby[よ][良]いことを#ruby[き][聞]く#ruby[ところ][所]],
  [#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]],
  [#ruby[もの][物]を#ruby[なか][中]に#ruby[い][入]れて#ruby[まも][守]る#ruby[ところ][所]],
  [#ruby[うみ][海]を#ruby[うご][動]く#ruby[もの][物]が#ruby[く][来]る#ruby[ところ][所]],
  [#ruby[そら][空]を#ruby[うご][動]く#ruby[もの][物]が#ruby[で][出]る#ruby[ところ][所]],
  [#ruby[もの][物]が#ruby[はや][速]く#ruby[うご][動]く#ruby[みち][道]],
  [#ruby[みち][道]と#ruby[みち][道]が#ruby[あ][会]う#ruby[ところ][所]],
  [#ruby[あか][赤]と#ruby[あお][青]の#ruby[ひかり][光]で#ruby[うご][動]くのを#ruby[と][止]める#ruby[もの][物]],
  [#ruby[うえ][上]に#ruby[い][行]くための#ruby[みち][道]],
  [#ruby[なか][中]に#ruby[はい][入]るための#ruby[ところ][所]],
  [#ruby[そと][外]に#ruby[で][出]るための#ruby[ところ][所]],
  [#ruby[いえ][家]にあって#ruby[そと][外]が#ruby[み][見]えるもの],
  [#ruby[あ][開]いたり#ruby[し][閉]めたりする#ruby[もの][物]],
  [#ruby[そと][外]と#ruby[なか][中]の#ruby[い][入]り#ruby[ぐち][口]にある#ruby[おお][大]きい#ruby[もの][物]],
  [#ruby[いえ][家]の#ruby[いち][一]ばん#ruby[うえ][上]にある#ruby[もの][物]],
  [#ruby[いえ][家]の#ruby[そと][外]にある#ruby[いし][石]や#ruby[き][木]でできた#ruby[もの][物]],
  [#ruby[いえ][家]の#ruby[なか][中]で#ruby[あし][足]が#ruby[うえ][上]にある#ruby[した][下]の#ruby[もの][物]],
  [#ruby[いえ][家]の#ruby[なか][中]の#ruby[いち][一]ばん#ruby[うえ][上]],
  [#ruby[いえ][家]の#ruby[そと][外]にある#ruby[くさ][草]の#ruby[ところ][所]],
  [#ruby[いえ][家]の#ruby[なか][中]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]],
  [#ruby[いえ][家]の#ruby[なか][中]で#ruby[ひと][人]が#ruby[たの][楽]しくいる#ruby[ところ][所]],
  [#ruby[いえ][家]の#ruby[なか][中]で#ruby[ね][寝]る#ruby[ところ][所]],
  [#ruby[つち][土]の#ruby[した][下]],
  [#ruby[つち][土]の#ruby[うえ][上]],
  [#ruby[うみ][海]の#ruby[なか][中]にある#ruby[つち][土]の#ruby[ところ][所]],
  [#ruby[みず][水]がなくて#ruby[あつ][暑]い#ruby[ところ][所]],
  [#ruby[き][木]が#ruby[おお][多]くある#ruby[ところ][所]],
  [#ruby[やま][山]と#ruby[やま][山]の#ruby[した][下]にある#ruby[ところ][所]],
  [#ruby[やま][山]から#ruby[うみ][海]へ#ruby[みず][水]が#ruby[うご][動]く#ruby[みち][道]],
)]

=== #ruby[うご][動]く#ruby[もの][物]と#ruby[い][行]く#ruby[こと][事]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[みち][道]を#ruby[はや][速]く#ruby[うご][動]く#ruby[もの][物]],
  [#ruby[みち][道]の#ruby[うえ][上]を#ruby[うご][動]く#ruby[なが][長]い#ruby[もの][物]],
  [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[なか][中]に#ruby[はい][入]る#ruby[おお][大]きい#ruby[もの][物]],
  [#ruby[そら][空]を#ruby[うご][動]く#ruby[もの][物]],
  [#ruby[うみ][海]を#ruby[うご][動]く#ruby[もの][物]],
  [#ruby[あし][足]を#ruby[つか][使]って#ruby[うご][動]かす#ruby[もの][物]],
  [お#ruby[おかね][金]を#ruby[あた][与]えて#ruby[なか][中]に#ruby[はい][入]る#ruby[もの][物]],
  [#ruby[おも][重]い#ruby[もの][物]を#ruby[も][持]って#ruby[うご][動]く#ruby[おお][大]きい#ruby[もの][物]],
  [#ruby[はや][速]く#ruby[うご][動]ける#ruby[おお][大]きい#ruby[みち][道]],
  [#ruby[なが][長]い#ruby[もの][物]が#ruby[うご][動]く#ruby[みち][道]],
  [#ruby[なが][長]い#ruby[もの][物]が#ruby[うえ][上]を#ruby[うご][動]く#ruby[みち][道]],
  [#ruby[もの][物]を#ruby[うご][動]かすこと],
  [#ruby[ところ][所]を#ruby[で][出]ること],
  [#ruby[ところ][所]に#ruby[く][来]ること],
  [#ruby[ほか][他]の#ruby[ところ][所]に#ruby[い][行]くこと],
  [#ruby[ほか][他]の#ruby[ところ][所]を#ruby[み][見]ること],
  [#ruby[みち][道]や#ruby[ところ][所]を#ruby[おし][教]えること],
  [#ruby[ところ][所]を#ruby[か][書]いた#ruby[もの][物]],
  [#ruby[なか][中]に#ruby[はい][入]るために#ruby[か][買]う#ruby[もの][物]],
  [#ruby[ほか][他]の#ruby[くに][国]に#ruby[い][行]くときに#ruby[ひつよう][必要]な#ruby[ほん][本]],
  [#ruby[い][行]く#ruby[とき][時]に#ruby[も][持]って#ruby[い][行]く#ruby[もの][物]],
  [#ruby[すわ][座]る#ruby[ところ][所]],
  [どのくらい#ruby[はや][速]いかということ],
  [#ruby[ふた][二]つの#ruby[ところ][所]がどのくらい#ruby[とお][遠]いか],
  [どちらに#ruby[い][行]くかということ],
  [#ruby[みち][道]を#ruby[ひと][人]や#ruby[もの][物]が#ruby[うご][動]くこと],
  [#ruby[もの][物]が#ruby[うご][動]けなくなること],
  [#ruby[わる][悪]いことが#ruby[お][起]こること],
  [#ruby[なか][中]に#ruby[はい][入]るために#ruby[あた][与]えるお#ruby[おかね][金]],
  [#ruby[い][行]くだけで#ruby[こ][来]ない#ruby[みち][道]],
  [#ruby[い][行]って#ruby[く][来]ること],
  [#ruby[い][行]きたい#ruby[ところ][所]],
  [#ruby[ほか][他]の#ruby[くに][国]],
  [もとの#ruby[くに][国]に#ruby[く][来]ること],
  [#ruby[みち][道]が#ruby[み][見]えなくなった#ruby[こども][子供]],
  [#ruby[はじ][始]まりと#ruby[お][終]わりの#ruby[まえ][前]],
  [#ruby[もの][物]の#ruby[なか][中]に#ruby[はい][入]る#ruby[ひと][人]],
  [#ruby[もの][物]を#ruby[うご][動]かす#ruby[ひと][人]],
  [#ruby[うご][動]く#ruby[もの][物]が#ruby[と][止]まって#ruby[お][終]わる#ruby[ところ][所]],
)]

=== #ruby[そと][外]と#ruby[そら][空]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[そら][空]から#ruby[しろ][白]くて#ruby[さむ][寒]い#ruby[みず][水]が#ruby[く][来]ること],
  [#ruby[さむ][寒]くなった#ruby[みず][水]],
  [#ruby[しろ][白]い#ruby[かぜ][風]で#ruby[なに][何]も#ruby[み][見]えなくなること],
  [#ruby[あめ][雨]の#ruby[あと][後]に#ruby[そら][空]に#ruby[で][出]る#ruby[いろ][色]の#ruby[ひかり][光]],
  [#ruby[そら][空]で#ruby[おお][大]きい#ruby[おと][音]と#ruby[ひかり][光]が#ruby[お][起]こること],
  [#ruby[つよ][強]い#ruby[かぜ][風]と#ruby[あめ][雨]が#ruby[く][来]ること],
  [#ruby[つち][土]が#ruby[うご][動]くこと],
  [#ruby[みず][水]が#ruby[おお][多]くなって#ruby[ところ][所]が#ruby[みず][水]の#ruby[なか][中]に#ruby[はい][入]ること],
  [#ruby[そと][外]で#ruby[お][起]こる#ruby[わる][悪]いこと],
  [#ruby[やま][山]や#ruby[つち][土]の#ruby[なか][中]にある#ruby[おお][大]きい#ruby[みず][水]],
  [#ruby[やま][山]や#ruby[つち][土]の#ruby[なか][中]にある#ruby[みず][水]],
  [#ruby[たか][高]い#ruby[ところ][所]から#ruby[みず][水]が#ruby[した][下]に#ruby[で][出]てくること],
  [#ruby[つち][土]の#ruby[なか][中]から#ruby[みず][水]が#ruby[で][出]てくる#ruby[ところ][所]],
  [#ruby[き][木]が#ruby[おお][多]くある#ruby[ところ][所]],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[つち][土]の#ruby[ところ][所]],
  [#ruby[みず][水]を#ruby[つか][使]って#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]],
  [#ruby[うみ][海]や#ruby[やま][山]にある#ruby[いし][石]でできた#ruby[もの][物]],
  [#ruby[くさ][草]や#ruby[き][木]にある#ruby[いろ][色]のある#ruby[もの][物]],
  [#ruby[しろ][白]や#ruby[あか][赤]の#ruby[いろ][色]の#ruby[き][木]の#ruby[もの][物]],
  [#ruby[き][木]の#ruby[みどり][緑]の#ruby[もの][物]],
  [#ruby[き][木]や#ruby[くさ][草]の#ruby[つち][土]の#ruby[なか][中]にある#ruby[もの][物]],
  [#ruby[くさ][草]や#ruby[き][木]になる#ruby[まえ][前]の#ruby[もの][物]],
  [#ruby[き][木]にある#ruby[た][食]べられる#ruby[もの][物]],
  [#ruby[あし][足]が#ruby[おお][多]い#ruby[どうぶつ][動物]],
  [#ruby[いえ][家]にいる#ruby[どうぶつ][動物]],
  [#ruby[おお][大]きくて#ruby[つよ][強]い#ruby[どうぶつ][動物]で#ruby[ひと][人]が#ruby[うえ][上]に#ruby[すわ][座]るもの],
  [#ruby[しろ][白]と#ruby[くろ][黒]の#ruby[おお][大]きい#ruby[どうぶつ][動物]],
  [#ruby[あし][足]がなくて#ruby[なが][長]い#ruby[どうぶつ][動物]],
  [#ruby[おお][大]きくて#ruby[つよ][強]くて#ruby[こわ][怖]い#ruby[どうぶつ][動物]],
  [#ruby[そら][空]を#ruby[うご][動]く#ruby[どうぶつ][動物]が#ruby[つか][使]う#ruby[もの][物]],
  [#ruby[とし][年]の#ruby[なか][中]で#ruby[あつ][暑]さや#ruby[さむ][寒]さが#ruby[か][変]わる#ruby[とき][時]],
  [#ruby[さむ][寒]い#ruby[とき][時]の#ruby[あと][後]で#ruby[あつ][暑]くなる#ruby[まえ][前]の#ruby[とき][時]],
  [#ruby[とし][年]で#ruby[いち][一]ばん#ruby[あつ][暑]い#ruby[とき][時]],
  [#ruby[あつ][暑]い#ruby[とき][時]の#ruby[あと][後]で#ruby[さむ][寒]くなる#ruby[まえ][前]の#ruby[とき][時]],
  [#ruby[とし][年]で#ruby[いち][一]ばん#ruby[さむ][寒]い#ruby[とき][時]],
  [#ruby[たいよう][太陽]が#ruby[そら][空]に#ruby[で][出]てくること],
  [#ruby[たいよう][太陽]が#ruby[した][下]に#ruby[はい][入]ること],
  [#ruby[たいよう][太陽]が#ruby[で][出]てきた#ruby[あと][後]の#ruby[とき][時]],
  [#ruby[うみ][海]の#ruby[みず][水]が#ruby[うえ][上]に#ruby[く][来]たり#ruby[した][下]に#ruby[い][行]ったりすること],
  [#ruby[うみ][海]の#ruby[みず][水]が#ruby[うご][動]くこと],
)]

=== #ruby[た][食]べ#ruby[もの][物]と#ruby[の][飲]み#ruby[もの][物]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[ひ][火]で#ruby[つく][作]った#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[た][食]べる#ruby[こと][事]],
  [#ruby[にち][日]の#ruby[はじ][始]まりに#ruby[た][食]べる#ruby[もの][物]],
  [#ruby[にち][日]の#ruby[なか][中]の#ruby[とき][時]に#ruby[た][食]べる#ruby[もの][物]],
  [#ruby[よる][夜]に#ruby[た][食]べる#ruby[もの][物]],
  [#ruby[そと][外]で#ruby[た][食]べるために#ruby[つく][作]った#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[こども][子供]が#ruby[す][好]きな#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[くさ][草]から#ruby[つく][作]った#ruby[しろ][白]い#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[に][日]ほんで#ruby[おお][多]く#ruby[た][食]べる#ruby[しろ][白]い#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[みず][水]で#ruby[つく][作]った#ruby[しろ][白]い#ruby[くさ][草]の#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[つち][土]から#ruby[で][出]る#ruby[た][食]べる#ruby[くさ][草]],
  [#ruby[き][木]からもらう#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[うみ][海]の#ruby[みず][水]から#ruby[つく][作]る#ruby[しろ][白]い#ruby[もの][物]],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[よ][良]い#ruby[かん][感]じにする#ruby[しろ][白]い#ruby[もの][物]],
  [#ruby[くろ][黒]い#ruby[いろ][色]の#ruby[た][食]べ#ruby[もの][物]に#ruby[つか][使]う#ruby[みず][水]],
  [#ruby[くち][口]で#ruby[かん][感]じる#ruby[こと][事]],
  [#ruby[はな][鼻]で#ruby[かん][感]じる#ruby[こと][事]],
  [#ruby[の][飲]むと#ruby[からだ][体]が#ruby[へん][変]になる#ruby[みず][水]],
  [#ruby[くさ][草]から#ruby[つく][作]った#ruby[の][飲]み#ruby[もの][物]],
  [#ruby[き][木]の#ruby[た][食]べ#ruby[もの][物]から#ruby[で][出]る#ruby[みず][水]],
  [#ruby[どう][動]#ruby[ぶつ][物]の#ruby[からだ][体]から#ruby[で][出]る#ruby[しろ][白]い#ruby[の][飲]み#ruby[もの][物]],
  [#ruby[くろ][黒]い#ruby[の][飲]み#ruby[もの][物]],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[うえ][上]に#ruby[い][入]れる#ruby[もの][物]],
  [#ruby[た][食]べる#ruby[とき][時]に#ruby[つか][使]う#ruby[に][二]#ruby[ほん][本]の#ruby[き][木]],
  [#ruby[の][飲]み#ruby[もの][物]を#ruby[い][入]れる#ruby[もの][物]],
  [#ruby[みず][水]や#ruby[の][飲]み#ruby[もの][物]を#ruby[い][入]れる#ruby[もの][物]],
  [#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[もの][物]],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[き][切]る#ruby[もの][物]],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[さむ][寒]くして#ruby[い][入]れる#ruby[もの][物]],
  [とても#ruby[さむ][寒]くなった#ruby[みず][水]],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[ひ][火]で#ruby[つく][作]る#ruby[とき][時]に#ruby[つか][使]う#ruby[もの][物]],
  [#ruby[みず][水]で#ruby[つく][作]った#ruby[あつ][暑]い#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[き][切]った#ruby[くさ][草]の#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[た][食]べて#ruby[くち][口]で#ruby[よ][良]い#ruby[かん][感]じ],
  [#ruby[た][食]べて#ruby[くち][口]で#ruby[わる][悪]い#ruby[かん][感]じ],
  [#ruby[くち][口]に#ruby[つよ][強]い#ruby[かん][感]じがする#ruby[た][食]べ#ruby[もの][物]の#ruby[こと][事]],
  [#ruby[くち][口]がとても#ruby[へん][変]に#ruby[かん][感]じる#ruby[た][食]べ#ruby[もの][物]の#ruby[こと][事]],
  [#ruby[た][食]べ#ruby[もの][物]が#ruby[くち][口]で#ruby[よ][良]い#ruby[かん][感]じがする],
  [#ruby[た][食]べ#ruby[もの][物]の#ruby[くち][口]の#ruby[かん][感]じが#ruby[わる][悪]い],
  [#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る],
  [#ruby[みず][水]と#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る],
  [#ruby[あつ][暑]い#ruby[みず][水]のような#ruby[もの][物]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る],
  [#ruby[た][食]べ#ruby[もの][物]が#ruby[ほ][欲]しくなる],
  [#ruby[の][飲]み#ruby[もの][物]が#ruby[ほ][欲]しくなる],
)]

=== #ruby[からだ][体]と#ruby[よ][良]い#ruby[からだ][体]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[とき][時]],
  [#ruby[からだ][体]を#ruby[よ][良]くするために#ruby[の][飲]む#ruby[もの][物]],
  [#ruby[からだ][体]が#ruby[わる][悪]くなった#ruby[こと][事]],
  [#ruby[からだ][体]が#ruby[わる][悪]く#ruby[かん][感]じる],
  [#ruby[からだ][体]がとても#ruby[あつ][暑]くなる#ruby[こと][事]],
  [#ruby[からだ][体]が#ruby[わる][悪]くて#ruby[あつ][暑]くなる#ruby[こと][事]],
  [#ruby[くち][口]から#ruby[つよ][強]く#ruby[くう][空]#ruby[き][気]が#ruby[で][出]る#ruby[こと][事]],
  [#ruby[からだ][体]を#ruby[うご][動]かす#ruby[もの][物]],
  [#ruby[くち][口]の#ruby[なか][中]で#ruby[た][食]べ#ruby[もの][物]を#ruby[き][切]る#ruby[しろ][白]い#ruby[もの][物]],
  [#ruby[て][手]や#ruby[あし][足]の#ruby[お][終]わりの#ruby[なが][長]い#ruby[ところ][所]],
  [#ruby[あたま][頭]の#ruby[した][下]、#ruby[て][手]の#ruby[うえ][上]にある#ruby[からだ][体]の#ruby[ところ][所]],
  [#ruby[からだ][体]の#ruby[なか][中]ほどにある#ruby[ところ][所]],
  [#ruby[からだ][体]の#ruby[うし][後]ろにある#ruby[ところ][所]],
  [#ruby[あたま][頭]と#ruby[からだ][体]の#ruby[なか][中]の#ruby[ところ][所]],
  [#ruby[からだ][体]の#ruby[まえ][前]の#ruby[うえ][上]の#ruby[ところ][所]],
  [#ruby[からだ][体]の#ruby[まえ][前]の#ruby[なか][中]ほどの#ruby[ところ][所]],
  [#ruby[あたま][頭]の#ruby[まえ][前]の#ruby[ところ][所]],
  [#ruby[て][手]や#ruby[あし][足]の#ruby[お][終]わりにある#ruby[つよ][強]い#ruby[もの][物]],
  [#ruby[くち][口]の#ruby[そと][外]の#ruby[あか][赤]い#ruby[ところ][所]],
  [#ruby[くち][口]の#ruby[なか][中]で#ruby[た][食]べ#ruby[もの][物]を#ruby[かん][感]じる#ruby[もの][物]],
  [#ruby[かな][悲]しい#ruby[とき][時]に#ruby[め][目]から#ruby[で][出]る#ruby[みず][水]],
  [#ruby[あつ][暑]い#ruby[とき][時]に#ruby[からだ][体]から#ruby[で][出]る#ruby[みず][水]],
  [#ruby[くち][口]から#ruby[で][出]る#ruby[おと][音]],
  [#ruby[くち][口]や#ruby[はな][鼻]から#ruby[で][出]る#ruby[くう][空]#ruby[き][気]],
  [#ruby[くう][空]#ruby[き][気]を#ruby[からだ][体]の#ruby[なか][中]に#ruby[い][入]れたり#ruby[だ][出]したりする#ruby[こと][事]],
  [#ruby[からだ][体]の#ruby[なか][中]の#ruby[あか][赤]い#ruby[みず][水]が#ruby[うご][動]く#ruby[おと][音]],
  [#ruby[からだ][体]が#ruby[よ][良]い#ruby[とき][時]],
  [#ruby[からだ][体]も#ruby[こころ][心]も#ruby[よ][良]い#ruby[とき][時]],
  [#ruby[からだ][体]や#ruby[こころ][心]が#ruby[うご][動]けなくなる],
  [#ruby[ね][寝]たいと#ruby[かん][感]じる],
  [#ruby[ね][寝]ている#ruby[とき][時]から#ruby[で][出]る],
  [#ruby[からだ][体]の#ruby[わる][悪]い#ruby[ひと][人]を#ruby[たす][助]ける#ruby[ひと][人]],
  [#ruby[からだ][体]の#ruby[わる][悪]い#ruby[ひと][人]を#ruby[たす][助]ける#ruby[ひと][人]],
  [#ruby[からだ][体]を#ruby[き][切]って#ruby[なか][中]を#ruby[よ][良]くする#ruby[こと][事]],
  [#ruby[からだ][体]の#ruby[なか][中]に#ruby[もの][物]を#ruby[い][入]れる#ruby[こと][事]],
  [#ruby[からだ][体]がとても#ruby[わる][悪]くて#ruby[いえ][家]を#ruby[で][出]てどこかに#ruby[はい][入]る#ruby[こと][事]],
  [#ruby[からだ][体]が#ruby[よ][良]くなって#ruby[で][出]る#ruby[こと][事]],
  [#ruby[からだ][体]の#ruby[なか][中]を#ruby[み][見]る#ruby[こと][事]],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[とき][時]に#ruby[で][出]る#ruby[へん][変]な#ruby[こと][事]],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[とき][時]から#ruby[よ][良]くなる],
  [#ruby[からだ][体]を#ruby[よ][良]くする#ruby[こと][事]],
  [#ruby[からだ][体]が#ruby[おお][大]きく#ruby[おも][重]くなる],
  [#ruby[からだ][体]が#ruby[おも][重]くなくなる],
  [#ruby[おんな][女]の#ruby[からだ][体]の#ruby[なか][中]に#ruby[こども][子供]がいる#ruby[とき][時]],
  [#ruby[からだ][体]から#ruby[こ][子]#ruby[ども][供]が#ruby[で][出]る#ruby[こと][事]],
  [ある#ruby[もの][物]に#ruby[からだ][体]が#ruby[わる][悪]く#ruby[か][変]わる#ruby[こと][事]],
  [#ruby[からだ][体]が#ruby[き][切]れた#ruby[ところ][所]],
)]

=== #ruby[とき][時]の#ruby[こと][言]#ruby[ば][葉]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[で][出]てくる#ruby[とき][時]],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[うえ][上]にある#ruby[とき][時]],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[した][下]に#ruby[はい][入]る#ruby[とき][時]],
  [#ruby[いま][今]の#ruby[にち][日]の#ruby[はじ][始]まりの#ruby[とき][時]],
  [#ruby[いま][今]#ruby[にち][日]の#ruby[よる][夜]],
  [#ruby[あす][明]の#ruby[あと][後]の#ruby[にち][日]],
  [#ruby[まえ][前]の#ruby[まえ][前]の#ruby[にち][日]],
  [#ruby[いま][今]より#ruby[すこ][少]し#ruby[まえ][前]の#ruby[とき][時]],
  [#ruby[いま][今]の#ruby[ちか][近]くの#ruby[にち][日]の#ruby[とき][時]],
  [#ruby[いま][今]より#ruby[すこ][少]し#ruby[あと][後]の#ruby[とき][時]],
  [#ruby[いま][今]の#ruby[つき][月]の#ruby[まえ][前]の#ruby[つき][月]],
  [#ruby[いま][今]の#ruby[つき][月]],
  [#ruby[いま][今]の#ruby[つき][月]の#ruby[あと][後]の#ruby[つき][月]],
  [#ruby[いま][今]の#ruby[とし][年]の#ruby[まえ][前]の#ruby[とし][年]],
  [#ruby[いま][今]の#ruby[とし][年]],
  [#ruby[いま][今]の#ruby[とし][年]の#ruby[あと][後]の#ruby[とし][年]],
  [#ruby[にち][日]のまとまりの#ruby[お][終]わりの#ruby[にち][日]],
  [#ruby[まい][毎]#ruby[にち][日]のいつもの#ruby[にち][日]],
  [#ruby[いま][今]から#ruby[まえ][前]や#ruby[あと][後]まで#ruby[と][止]まらない#ruby[もの][物]],
  [#ruby[いち][一]の#ruby[とき][時]を#ruby[おお][多]く#ruby[き][切]った#ruby[ひと][一]つ],
  [とても#ruby[すこ][少]しの#ruby[とき][時]],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[たか][高]くなる#ruby[まえ][前]の#ruby[とき][時]],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[たか][高]くなった#ruby[あと][後]の#ruby[とき][時]],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[ひと][一]つだけ#ruby[たか][高]い#ruby[とき][時]],
  [#ruby[たい][太]#ruby[よう][陽]の#ruby[にち][日]],
  [#ruby[つき][月]の#ruby[にち][日]],
  [#ruby[なに][何]もしなくていい#ruby[にち][日]],
  [#ruby[くに][国]が#ruby[えら][選]んだ#ruby[なに][何]もしない#ruby[にち][日]],
  [#ruby[とし][年]の#ruby[なか][中]で#ruby[そら][空]が#ruby[か][変]わる#ruby[とき][時]],
  [#ruby[ひと][人]が#ruby[い][生]きる#ruby[こと][事]が#ruby[はじ][始]まった#ruby[にち][日]],
  [よく#ruby[おも][思]い#ruby[だ][出]す#ruby[ひつよう][必要]な#ruby[にち][日]],
  [とても#ruby[すこ][少]しの#ruby[とき][時]],
  [#ruby[はじ][始]まりから#ruby[お][終]わりまでの#ruby[とき][時]],
  [その#ruby[こと][事]が#ruby[お][終]わらなければならない#ruby[とき][時]],
  [これより#ruby[あと][後]はできないという#ruby[とき][時]],
  [#ruby[いま][今]から#ruby[すこ][少]し#ruby[まえ][前]の#ruby[とき][時]],
  [とても#ruby[すこ][少]しの#ruby[とき][時]の#ruby[あと][後]に],
  [#ruby[すこ][少]し#ruby[あと][後]の#ruby[とき][時]に],
  [#ruby[お][終]わらない#ruby[とき][時]],
  [#ruby[い][生]きている#ruby[ぜん][全]#ruby[ぶ][部]の#ruby[とき][時]],
  [#ruby[じゅう][十]の#ruby[じゅう][十]の#ruby[とし][年]の#ruby[とき][時]],
  [ある#ruby[なが][長]い#ruby[とき][時]の#ruby[こと][事]が#ruby[お][起]こった#ruby[とき][時]],
  [とても#ruby[なが][長]い#ruby[とき][時]の#ruby[あと][後]に],
  [#ruby[おも][思]っていなかった#ruby[とき][時]に#ruby[お][起]こる],
  [#ruby[なが][長]い#ruby[とき][時]が#ruby[お][終]わって#ruby[あ][会]う],
)]

=== する#ruby[こと][事]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[はや][速]く#ruby[あし][足]で#ruby[うご][動]く],
  [#ruby[みず][水]の#ruby[なか][中]で#ruby[うご][動]く],
  [#ruby[うえ][上]へ#ruby[い][行]く],
  [#ruby[した][下]へ#ruby[うご][動]く],
  [#ruby[した][下]へ#ruby[で][出]る],
  [#ruby[うえ][上]に#ruby[はい][入]る],
  [#ruby[も][持]って#ruby[い][行]く],
  [ある#ruby[ところ][所]へ#ruby[い][行]かせる],
  [#ruby[も][持]って#ruby[き][来]て#ruby[あた][与]える],
  [#ruby[き][来]て#ruby[て][手]に#ruby[はい][入]る],
  [#ruby[も][持]って#ruby[あた][与]える],
  [#ruby[みぎ][右]か#ruby[ひだり][左]の#ruby[そと][外]へ#ruby[い][行]く],
  [#ruby[て][手]で#ruby[かん][感]じる],
  [#ruby[て][手]で#ruby[うご][動]かす],
  [#ruby[て][手]で#ruby[ちか][近]くへ#ruby[うご][動]かす],
  [#ruby[て][手]で#ruby[そら][空]へ#ruby[で][出]す],
  [#ruby[した][下]にある#ruby[もの][物]を#ruby[て][手]で#ruby[も][持]つ],
  [ある#ruby[ところ][所]に#ruby[と][止]める],
  [#ruby[うえ][上]から#ruby[もの][物]を#ruby[と][止]める],
  [お#ruby[おかね][金]を#ruby[あた][与]える],
  [お#ruby[おかね][金]をもらって#ruby[もの][物]を#ruby[あた][与]える],
  [また#ruby[も][持]って#ruby[く][来]るために#ruby[あた][与]える],
  [#ruby[あと][後]で#ruby[あた][与]えるためにもらう],
  [もらった#ruby[ひと][人]に#ruby[あた][与]える],
  [いらない#ruby[もの][物]を#ruby[で][出]す],
  [#ruby[おお][多]く#ruby[も][持]ってくる],
  [#ruby[ひと][一]つの#ruby[もの][物]を#ruby[ふた][二]つより#ruby[おお][多]くにする],
  [#ruby[ふた][二]つより#ruby[おお][多]くの#ruby[もの][物]を#ruby[ひと][一]つにする],
  [#ruby[ひと][一]つ#ruby[ひと][一]つ#ruby[まえ][前]と#ruby[あと][後]に#ruby[た][立]つ],
  [#ruby[お][終]わらずに#ruby[お][起]こる],
  [#ruby[お][終]わらせずにする],
  [#ruby[ひと][一]つを#ruby[えら][選]ぶ],
  [#ruby[ひと][一]つに#ruby[えら][選]ばれる],
  [#ruby[ふた][二]つの#ruby[もの][物]が#ruby[ちが][違]うか#ruby[み][見]る],
  [いくつあるか#ruby[し][知]る],
  [#ruby[よ][良]いか#ruby[み][見]るためにする],
  [ほんとうかどうか#ruby[み][見]る],
  [#ruby[し][知]るために#ruby[み][見]る],
  [#ruby[き][聞]かれたことを#ruby[い][言]う],
  [してほしいと#ruby[い][言]う],
  [しないと#ruby[い][言]う],
  [#ruby[き][来]てほしいと#ruby[い][言]う],
  [#ruby[ことば][言葉]で#ruby[し][知]らせる],
  [とても#ruby[おお][大]きな#ruby[おと][音]で#ruby[くち][口]から#ruby[い][言]う],
  [#ruby[なまえ][名前]を#ruby[い][言]って#ruby[く][来]るように#ruby[い][言]う],
  [#ruby[おと][音]のある#ruby[ことば][言葉]を#ruby[くち][口]から#ruby[で][出]す],
  [#ruby[おと][音]で#ruby[からだ][体]を#ruby[うご][動]かす],
  [#ruby[たの][楽]しいことをする],
  [お#ruby[おかね][金]のためにする],
  [ある#ruby[とき][時]まで#ruby[と][止]める],
  [#ruby[ね][寝]るのを#ruby[と][止]めて#ruby[た][立]つ],
  [ある#ruby[ところ][所]に#ruby[まい][毎]#ruby[にち][日]いる],
  [#ruby[わたし][私]の#ruby[いえ][家]へ#ruby[い][行]く],
  [ある#ruby[ところ][所]の#ruby[なか][中]を#ruby[い][行]く],
  [その#ruby[ところ][所]を#ruby[で][出]る],
  [とても#ruby[はや][速]くする],
  [#ruby[こわ][怖]いものから#ruby[そと][外]へ#ruby[い][行]く],
  [ある#ruby[ひと][人]・#ruby[もの][物]の#ruby[あと][後]から#ruby[い][行]く],
  [#ruby[うご][動]けないようにする],
  [#ruby[み][見]えないようにする],
  [#ruby[み][見]えるようになる],
  [#ruby[み][見]えなくなる],
  [もっと#ruby[おお][多]くなる],
  [より#ruby[すこ][少]しになる],
  [#ruby[うえ][上]へ#ruby[うご][動]く],
  [#ruby[した][下]へ#ruby[うご][動]く],
  [ある#ruby[もの][物]の#ruby[そと][外]を#ruby[うご][動]く],
  [#ruby[みち][道]が#ruby[みぎ][右]か#ruby[ひだり][左]へ#ruby[か][変]わる],
  [#ruby[からだ][体]が#ruby[はや][速]く#ruby[すこ][少]し#ruby[うご][動]く],
  [#ruby[みぎ][右]と#ruby[ひだり][左]に#ruby[はや][速]くなく#ruby[うご][動]く],
  [#ruby[ひかり][光]を#ruby[で][出]す],
  [#ruby[ひ][火]になる],
  [#ruby[みず][水]のようになる],
  [#ruby[みず][水]がなくなる],
  [#ruby[みず][水]がつく],
  [#ruby[わる][悪]いものがつく],
  [きれいになるようにする],
  [#ruby[もの][物]の#ruby[そと][外]を#ruby[ぜんぶ][全部]#ruby[み][見]えないようにする],
  [#ruby[ふた][二]つの#ruby[もの][物]を#ruby[ひと][一]つに#ruby[と][止]める],
  [#ruby[て][手]で#ruby[め][目]に#ruby[み][見]えるものを#ruby[つく][作]る],
)]

=== どんな

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [#ruby[なが][長]くない],
  [#ruby[たか][高]くない],
  [#ruby[おも][重]くない],
  [#ruby[つよ][強]くない],
  [#ruby[はや][速]くない],
  [#ruby[あたら][新]しくない],
  [#ruby[とし][年]が#ruby[すこ][少]ない],
  [#ruby[おお][大]きな#ruby[ところ][所]だ],
  [#ruby[ところ][所]が#ruby[ちい][小]さい],
  [#ruby[した][下]まで#ruby[なが][長]い],
  [#ruby[した][下]まで#ruby[なが][長]くない],
  [#ruby[なか][中]まで#ruby[なが][長]い],
  [#ruby[なか][中]まで#ruby[なが][長]くない],
  [#ruby[そと][外]が#ruby[おお][大]きい],
  [#ruby[そと][外]が#ruby[ちい][小]さい],
  [#ruby[つき][月]や#ruby[たいよう][太陽]のような#ruby[もの][物]だ],
  [#ruby[て][手]で#ruby[か][変]えられない],
  [#ruby[て][手]で#ruby[か][変]えられる],
  [#ruby[た][食]べると#ruby[よ][良]いと#ruby[かん][感]じる],
  [#ruby[た][食]べると#ruby[す][好]きではないと#ruby[かん][感]じる],
  [#ruby[た][食]べると#ruby[ひ][火]のように#ruby[かん][感]じる],
  [#ruby[た][食]べると#ruby[へん][変]に#ruby[かん][感]じる],
  [#ruby[おと][音]が#ruby[おお][大]きすぎる],
  [#ruby[おと][音]がない],
  [#ruby[よ][良]いと#ruby[い][言]える],
  [できない#ruby[こと][事]が#ruby[おお][多]い],
  [すぐにできる],
  [することが#ruby[おお][多]すぎる],
  [することがない],
  [とてもきれいだ],
  [きれいではない],
  [#ruby[わる][悪]いものがある],
  [#ruby[わる][悪]い#ruby[かぜ][風]がある],
  [#ruby[からだ][体]が#ruby[わる][悪]く#ruby[かん][感]じる],
  [#ruby[ね][寝]たいと#ruby[かん][感]じる],
  [#ruby[ほか][他]の#ruby[ひと][人]に#ruby[み][見]られたくないと#ruby[かん][感]じる],
  [あまり#ruby[み][見]ない#ruby[もの][物]だ],
  [#ruby[まえ][前]のことを#ruby[おも][思]って#ruby[よ][良]いと#ruby[かん][感]じる],
  [とても#ruby[よ][良]い],
  [#ruby[よ][良]い#ruby[もの][物]が#ruby[おお][多]い],
  [お#ruby[おかね][金]がとても#ruby[すこ][少]ない],
  [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[し][知]っている],
  [#ruby[おお][多]くのことがある],
  [ことが#ruby[すこ][少]ない],
  [#ruby[こわ][怖]いことがない],
  [#ruby[わる][悪]いことが#ruby[お][起]こるかもしれない],
  [できる],
  [できない],
  [#ruby[へん][変]ではない],
  [ほかと#ruby[ちが][違]う],
  [#ruby[ぜんぶ][全部]で#ruby[ひと][一]つだけ#ruby[よ][良]い],
  [#ruby[ぜんぶ][全部]で#ruby[ひと][一]つだけ#ruby[わる][悪]い],
  [もっと#ruby[ひつよう][必要]ではない],
  [この#ruby[こと][事]に#ruby[よ][良]い],
)]

=== #ruby[かんが][考]えの#ruby[こと][事]

#rounded-table[#table(
  columns: (1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ#ruby[ほん][本]の#ruby[こと][言]#ruby[ば][葉]*],
  [その#ruby[ことば][言葉]が#ruby[い][言]うこと],
  [なぜそうなったかということ],
  [どうするかということ],
  [なぜするかということ],
  [したあとに#ruby[お][起]こること],
  [それが#ruby[お][起]こる#ruby[まえ][前]にあったもの],
  [あることが#ruby[ほか][他]のことを#ruby[か][変]えること],
  [#ruby[ふた][二]つの#ruby[もの][物]や#ruby[ひと][人]が#ruby[ひと][一]つのことに#ruby[はい][入]っていること],
  [そうなるために#ruby[ひつよう][必要]なこと],
  [#ruby[いま][今]どうなっているかということ],
  [どのくらいかということ],
  [どんな#ruby[もの][物]かということ],
  [#ruby[わる][悪]いことで#ruby[かんが][考]えなければならないこと],
  [#ruby[き][聞]かれたことへの#ruby[ことば][言葉]],
  [#ruby[し][知]りたいことを#ruby[き][聞]くこと],
  [こういう#ruby[もの][物]だということを#ruby[み][見]せるもの],
  [ある#ruby[とき][時]に#ruby[お][起]こること],
  [できる#ruby[とき][時]があること],
  [#ruby[お][起]こるかもしれないということ],
  [したことがあるということ],
  [#ruby[まえ][前]のことを#ruby[こころ][心]に#ruby[も][持]っていること],
  [#ruby[み][見]えないものを#ruby[あたま][頭]の#ruby[なか][中]で#ruby[つく][作]ること],
  [#ruby[み][見]た#ruby[とき][時]に#ruby[かん][感]じたこと],
  [あることについて#ruby[おも][思]うこと],
  [#ruby[あたま][頭]の#ruby[なか][中]にあること],
  [#ruby[こころ][心]で#ruby[かん][感]じること],
  [#ruby[ひと][人]に#ruby[み][見]せる#ruby[からだ][体]と#ruby[ことば][言葉]の#ruby[うご][動]き],
  [すること],
  [#ruby[つよ][強]くしようとすること],
  [しようとしたことができたこと],
  [しようとしたことができなかったこと],
  [#ruby[か][変]わること],
  [より#ruby[よ][良]くなること],
  [もっと#ruby[おお][大]きくなること],
  [#ruby[い][生]きていること],
  [これから#ruby[お][起]こる#ruby[こと][事]が#ruby[まえ][前]に#ruby[えら][選]ばれているという#ruby[かんが][考]え],
  [#ruby[つよ][強]く#ruby[うご][動]かすことができること],
  [できることがあること],
  [とても#ruby[よ][良]くできること],
  [#ruby[し][知]っていること],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]が#ruby[し][知]っていること],
  [#ruby[まい][毎]#ruby[にち][日]すること],
  [#ruby[ほか][他]の#ruby[ひと][人]に#ruby[い][言]わないこと],
  [すると#ruby[い][言]ったこと],
  [しなければならないと#ruby[おも][思]うこと],
  [しなければならないこと],
  [してもいいと#ruby[い][言]われていること],
  [#ruby[よ][良]いことをするという#ruby[かんが][考]え],
  [どのくらい#ruby[よ][良]いかということ],
  [するという#ruby[つよ][強]い#ruby[こころ][心]],
)]

== #ruby[か][書]いた#ruby[もの][物]を#ruby[ひと][一]つにする

#text(size: 9pt, fill: rgb("#666666"))[206の#ruby[こと][言]#ruby[ば][葉]の#ruby[なか][中]の#ruby[か][書]いた#ruby[もの][物]で#ruby[つく][作]った#ruby[ほんとう][本当]の#ruby[こと][言]#ruby[ば][葉]。]

#note-block[#ruby[か][書]いた#ruby[もの][物]には#ruby[よ][読]み#ruby[かた][方]がいろいろある。#ruby[ひと][一]つの#ruby[か][書]いた#ruby[もの][物]でも#ruby[こと][言]#ruby[ば][葉]によって#ruby[おと][音]が#ruby[か][変]わる。#ruby[ひと][一]つ#ruby[ひと][一]つの#ruby[こと][言]#ruby[ば][葉]を#ruby[ぜんぶ][全部]で#ruby[し][知]る。]

=== #ruby[ひと][人]

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[おとな][大人]], [#ruby[おお][大]きくなった#ruby[ひと][人]],
  [#ruby[ひとり][一人]], [#ruby[ひと][人]が#ruby[ひと][一]つだけ],
  [#ruby[ふたり][二人]], [#ruby[ふた][二]つの#ruby[ひと][人]],
  [#ruby[だんじょ][男女]], [#ruby[おとこ][男]と#ruby[おんな][女]],
  [#ruby[だんし][男子]], [#ruby[おとこ][男]の#ruby[こども][子供]],
  [#ruby[じょし][女子]], [#ruby[おんな][女]の#ruby[こども][子供]],
  [#ruby[ふぼ][父母]], [#ruby[ちち][父]と#ruby[はは][母]],
  [#ruby[ふし][父子]], [#ruby[ちち][父]と#ruby[こども][子供]],
  [#ruby[ぼし][母子]], [#ruby[はは][母]と#ruby[こども][子供]],
  [#ruby[ちょうなん][長男]], [#ruby[いち][一]の#ruby[おとこ][男]の#ruby[こども][子供]],
  [#ruby[ちょうじょ][長女]], [#ruby[いち][一]の#ruby[おんな][女]の#ruby[こども][子供]],
  [#ruby[しんじん][新人]], [#ruby[あたら][新]しく#ruby[き][来]た#ruby[ひと][人]],
  [#ruby[ほんにん][本人]], [その#ruby[ひと][人]#ruby[ほんとう][本当]],
  [#ruby[たにん][他人]], [#ruby[ほか][他]の#ruby[ひと][人]],
  [#ruby[ちじん][知人]], [#ruby[し][知]っている#ruby[ひと][人]],
  [#ruby[めいじん][名人]], [することがとても#ruby[よ][良]い#ruby[ひと][人]],
  [#ruby[あくにん][悪人]], [#ruby[わる][悪]い#ruby[ひと][人]],
  [#ruby[へんじん][変人]], [#ruby[へん][変]な#ruby[ひと][人]],
  [#ruby[せいねん][青年]], [#ruby[とし][年]がまだ#ruby[すこ][少]しの#ruby[ひと][人]],
  [#ruby[じんせい][人生]], [#ruby[ひと][人]が#ruby[い][生]きること],
  [#ruby[じんぶつ][人物]], [ある#ruby[ひと][人]のこと],
  [#ruby[じんこう][人口]], [#ruby[くに][国]にいる#ruby[ひと][人]の#ruby[おお][多]さ],
  [#ruby[ひとで][人手]], [#ruby[たす][助]ける#ruby[ひと][人]の#ruby[て][手]],
  [#ruby[ひとめ][人目]], [#ruby[ほか][他]の#ruby[ひと][人]の#ruby[め][目]],
  [#ruby[にほんじん][日本人]], [この#ruby[くに][国]の#ruby[ひと][人]],
  [#ruby[がいこくじん][外国人]], [#ruby[そと][外]の#ruby[くに][国]の#ruby[ひと][人]],
  [#ruby[こつにく][骨肉]], [#ruby[ほね][骨]と#ruby[にく][肉]。#ruby[いえ][家]の#ruby[ひと][人]の#ruby[こと][事]],
  [#ruby[ふくしん][腹心]], [#ruby[はら][腹]の#ruby[こころ][心]。とても#ruby[し][知]っている#ruby[す][好]きな#ruby[ひと][人]],
)]

=== #ruby[そと][外]の#ruby[もの][物]

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[おおぞら][大空]], [#ruby[おお][大]きい#ruby[そら][空]],
  [#ruby[あおぞら][青空]], [#ruby[あお][青]い#ruby[そら][空]],
  [#ruby[たいぼく][大木]], [#ruby[おお][大]きい#ruby[き][木]],
  [#ruby[こだち][木立]], [#ruby[き][木]が#ruby[おお][多]く#ruby[た][立]つ#ruby[ところ][所]],
  [#ruby[かざん][火山]], [#ruby[ひ][火]が#ruby[で][出]る#ruby[やま][山]],
  [#ruby[こうざん][高山]], [#ruby[たか][高]い#ruby[やま][山]],
  [#ruby[やまみち][山道]], [#ruby[やま][山]の#ruby[みち][道]],
  [#ruby[さんちゅう][山中]], [#ruby[やま][山]の#ruby[なか][中]],
  [#ruby[やまぐち][山口]], [#ruby[やま][山]に#ruby[はい][入]る#ruby[ところ][所]],
  [#ruby[ちかみち][近道]], [#ruby[ちか][近]い#ruby[ほう][方]の#ruby[みち][道]],
  [#ruby[こくどう][国道]], [#ruby[くに][国]の#ruby[おお][大]きい#ruby[みち][道]],
  [#ruby[すいどう][水道]], [#ruby[みず][水]が#ruby[く][来]る#ruby[みち][道]],
  [#ruby[すいちゅう][水中]], [#ruby[みず][水]の#ruby[なか][中]],
  [#ruby[かいすい][海水]], [#ruby[うみ][海]の#ruby[みず][水]],
  [#ruby[かいじょう][海上]], [#ruby[うみ][海]の#ruby[うえ][上]],
  [#ruby[たいかい][大海]], [#ruby[おお][大]きい#ruby[うみ][海]],
  [#ruby[おおあめ][大雨]], [とても#ruby[おお][多]い#ruby[あめ][雨]],
  [#ruby[おおみず][大水]], [#ruby[みず][水]が#ruby[おお][多]く#ruby[で][出]ること],
  [#ruby[たいか][大火]], [#ruby[おお][大]きい#ruby[ひ][火]],
  [#ruby[かこう][火口]], [#ruby[ひ][火]が#ruby[で][出]る#ruby[くち][口]],
  [#ruby[きょうふう][強風]], [#ruby[つよ][強]い#ruby[かぜ][風]],
  [#ruby[きんざん][金山]], [お#ruby[かね][金]が#ruby[で][出]る#ruby[やま][山]],
  [#ruby[えんそく][遠足]], [#ruby[とお][遠]い#ruby[ところ][所]に#ruby[あし][足]で#ruby[い][行]く#ruby[こと][事]],
  [#ruby[ほどう][歩道]], [#ruby[ある][歩]く#ruby[みち][道]],
  [#ruby[はくちょう][白鳥]], [#ruby[しろ][白]い#ruby[とり][鳥]],
  [#ruby[こいぬ][小犬]], [#ruby[ちい][小]さい#ruby[いぬ][犬]],
  [#ruby[こざかな][小魚]], [#ruby[ちい][小]さい#ruby[さかな][魚]],
  [#ruby[あまぐも][雨雲]], [#ruby[あめ][雨]の#ruby[くも][雲]],
  [#ruby[みずどり][水鳥]], [#ruby[みず][水]の#ruby[とり][鳥]],
)]

=== #ruby[そら][空]と#ruby[とき][時]

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[にっこう][日光]], [#ruby[たいよう][太陽]の#ruby[ひかり][光]],
  [#ruby[げっこう][月光]], [#ruby[つき][月]の#ruby[ひかり][光]],
  [#ruby[つきよ][月夜]], [#ruby[つき][月]が#ruby[あか][明]るい#ruby[よる][夜]],
  [#ruby[しんげつ][新月]], [#ruby[あたら][新]しい#ruby[つき][月]],
  [#ruby[つきひ][月日]], [#ruby[つき][月]と#ruby[にち][日]の#ruby[とき][時]],
  [#ruby[きょう][今日]], [#ruby[いま][今]の#ruby[にち][日]],
  [#ruby[あした][明日]], [#ruby[いま][今]の#ruby[にち][日]の#ruby[あと][後]の#ruby[にち][日]],
  [#ruby[ぜんじつ][前日]], [#ruby[まえ][前]の#ruby[にち][日]],
  [#ruby[ごじつ][後日]], [#ruby[あと][後]の#ruby[にち][日]],
  [#ruby[まいにち][毎日]], [#ruby[まい][毎]の#ruby[にち][日]],
  [#ruby[まいつき][毎月]], [#ruby[まい][毎]の#ruby[つき][月]],
  [#ruby[まいとし][毎年]], [#ruby[まい][毎]の#ruby[とし][年]],
  [#ruby[しんねん][新年]], [#ruby[あたら][新]しい#ruby[とし][年]],
  [#ruby[ながねん][長年]], [#ruby[なが][長]い#ruby[とし][年]の#ruby[とき][時]],
  [#ruby[ねんじゅう][年中]], [#ruby[とし][年]の#ruby[ぜんぶ][全部]の#ruby[とき][時]],
  [#ruby[としうえ][年上]], [#ruby[とし][年]が#ruby[うえ][上]],
  [#ruby[としした][年下]], [#ruby[とし][年]が#ruby[した][下]],
  [#ruby[ねんきん][年金]], [#ruby[とし][年]ごとにもらうお#ruby[かね][金]],
  [#ruby[にっちゅう][日中]], [#ruby[にち][日]の#ruby[なか][中]の#ruby[とき][時]],
  [#ruby[いちにち][一日]], [#ruby[ひと][一]つの#ruby[にち][日]],
  [#ruby[どうじ][同時]], [#ruby[おな][同]じ#ruby[とき][時]],
  [#ruby[ひゃくねん][百年]], [#ruby[ひゃく][百]の#ruby[とし][年]],
  [#ruby[ひゃくにち][百日]], [#ruby[ひゃく][百]の#ruby[にち][日]],
)]

=== #ruby[からだ][体]

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[てあし][手足]], [#ruby[て][手]と#ruby[あし][足]],
  [#ruby[みぎて][右手]], [#ruby[みぎ][右]の#ruby[て][手]],
  [#ruby[ひだりて][左手]], [#ruby[ひだり][左]の#ruby[て][手]],
  [#ruby[みぎあし][右足]], [#ruby[みぎ][右]の#ruby[あし][足]],
  [#ruby[ひだりあし][左足]], [#ruby[ひだり][左]の#ruby[あし][足]],
  [#ruby[じもく][耳目]], [#ruby[みみ][耳]と#ruby[め][目]],
  [#ruby[めうえ][目上]], [#ruby[わたし][私]より#ruby[うえ][上]の#ruby[ひと][人]],
  [#ruby[めした][目下]], [#ruby[わたし][私]より#ruby[した][下]の#ruby[ひと][人]],
  [#ruby[もくぜん][目前]], [#ruby[め][目]の#ruby[まえ][前]],
  [#ruby[あしおと][足音]], [#ruby[あし][足]の#ruby[おと][音]],
  [#ruby[ぜんたい][全体]], [#ruby[ぜんぶ][全部]の#ruby[からだ][体]],
  [#ruby[だいたい][大体]], [#ruby[おお][大]きくは#ruby[ぜんぶ][全部]],
  [#ruby[いったい][一体]], [#ruby[ほんとう][本当]に#ruby[なに][何]],
  [#ruby[しゅっけつ][出血]], [#ruby[ち][血]が#ruby[で][出]る#ruby[こと][事]],
  [#ruby[ひにく][皮肉]], [#ruby[かわ][皮]と#ruby[にく][肉]。#ruby[そと][外]と#ruby[なか][中]が#ruby[ちが][違]う#ruby[こと][事]],
  [#ruby[しらが][白髪]], [#ruby[しろ][白]い#ruby[かみ][髪]],
  [#ruby[けんし][犬歯]], [#ruby[いぬ][犬]の#ruby[は][歯]のような#ruby[は][歯]],
)]

=== #ruby[もの][物]

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[ほんもの][本物]], [#ruby[ほんとう][本当]の#ruby[もの][物]],
  [#ruby[こうぶつ][好物]], [#ruby[す][好]きな#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[めいぶつ][名物]], [その#ruby[ところ][所]で#ruby[し][知]られた#ruby[もの][物]],
  [#ruby[しょもつ][書物]], [#ruby[か][書]いた#ruby[もの][物]],
  [#ruby[しょくもつ][食物]], [#ruby[た][食]べる#ruby[もの][物]],
  [#ruby[さくもつ][作物]], [#ruby[つち][土]で#ruby[つく][作]る#ruby[た][食]べ#ruby[もの][物]],
  [#ruby[せいぶつ][生物]], [#ruby[い][生]きている#ruby[もの][物]],
  [#ruby[ふうぶつ][風物]], [その#ruby[ところ][所]の#ruby[み][見]る#ruby[もの][物]],
  [#ruby[かなもの][金物]], [お#ruby[かね][金]で#ruby[つく][作]った#ruby[もの][物]],
  [#ruby[きもの][着物]], [#ruby[き][着]る#ruby[もの][物]],
  [#ruby[のみもの][飲み物]], [#ruby[の][飲]む#ruby[もの][物]],
  [#ruby[かいもの][買い物]], [#ruby[もの][物]を#ruby[か][買]うこと],
  [#ruby[よみもの][読み物]], [#ruby[よ][読]む#ruby[もの][物]],
  [#ruby[もちもの][持ち物]], [#ruby[も][持]っている#ruby[もの][物]],
  [#ruby[ものおと][物音]], [#ruby[もの][物]の#ruby[おと][音]],
  [#ruby[けんぶつ][見物]], [#ruby[もの][物]を#ruby[み][見]に#ruby[い][行]くこと],
  [#ruby[きんぎょ][金魚]], [お#ruby[かね][金]の#ruby[いろ][色]の#ruby[さかな][魚]],
  [#ruby[とりにく][鳥肉]], [#ruby[とり][鳥]の#ruby[にく][肉]],
  [#ruby[ぎょにく][魚肉]], [#ruby[さかな][魚]の#ruby[にく][肉]],
  [#ruby[にくしょく][肉食]], [#ruby[にく][肉]を#ruby[た][食]べる#ruby[こと][事]],
  [#ruby[なまたまご][生卵]], [#ruby[い][生]きている#ruby[たまご][卵]],
)]

=== #ruby[て][手]

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[てほん][手本]], [#ruby[み][見]て#ruby[おし][教]わる#ruby[ほん][本]],
  [#ruby[てまえ][手前]], [#ruby[わたし][私]の#ruby[ちか][近]い#ruby[まえ][前]],
  [#ruby[じょうず][上手]], [することがとても#ruby[よ][良]い],
  [#ruby[へた][下手]], [することが#ruby[よ][良]くない],
  [#ruby[きって][切手]], [#ruby[か][書]いた#ruby[もの][物]を#ruby[だ][出]す#ruby[とき][時]に#ruby[つか][使]う],
  [#ruby[にゅうしゅ][入手]], [#ruby[て][手]に#ruby[い][入]れること],
  [#ruby[せんしゅ][選手]], [#ruby[えら][選]ばれた#ruby[ひと][人]],
  [#ruby[じょしゅ][助手]], [#ruby[たす][助]ける#ruby[ひと][人]],
  [#ruby[ちゃくしゅ][着手]], [することを#ruby[はじ][始]めること],
)]

=== #ruby[はい][入]ると#ruby[で][出]る

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[いりぐち][入口]], [#ruby[なか][中]に#ruby[はい][入]る#ruby[ところ][所]],
  [#ruby[でぐち][出口]], [#ruby[そと][外]に#ruby[で][出]る#ruby[ところ][所]],
  [#ruby[でいり][出入]], [#ruby[で][出]ることと#ruby[はい][入]ること],
  [#ruby[にゅうきん][入金]], [お#ruby[かね][金]を#ruby[い][入]れること],
  [#ruby[しゅっきん][出金]], [お#ruby[かね][金]を#ruby[だ][出]すこと],
  [#ruby[がいしゅつ][外出]], [#ruby[そと][外]に#ruby[で][出]ること],
  [#ruby[しんにゅう][新入]], [#ruby[あたら][新]しく#ruby[はい][入]ること],
  [#ruby[たちいり][立入]], [#ruby[なか][中]に#ruby[はい][入]ること],
)]

=== #ruby[ほん][本]と#ruby[か][書]く

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[にほん][日本]], [#ruby[くに][国]の#ruby[なまえ][名前]],
  [#ruby[ほんみょう][本名]], [#ruby[ほんとう][本当]の#ruby[なまえ][名前]],
  [#ruby[ほんしん][本心]], [#ruby[ほんとう][本当]の#ruby[こころ][心]],
  [#ruby[みほん][見本]], [#ruby[み][見]るための#ruby[もの][物]],
  [#ruby[きょうほん][教本]], [#ruby[おし][教]えるための#ruby[ほん][本]],
  [#ruby[とくほん][読本]], [#ruby[よ][読]むための#ruby[ほん][本]],
  [#ruby[どくしょ][読書]], [#ruby[ほん][本]を#ruby[よ][読]むこと],
  [#ruby[おんどく][音読]], [#ruby[おと][音]を#ruby[だ][出]して#ruby[よ][読]むこと],
  [#ruby[しんぶん][新聞]], [#ruby[あたら][新]しいことを#ruby[か][書]いた#ruby[もの][物]],
  [#ruby[かいわ][会話]], [#ruby[あ][会]って#ruby[はな][話]す#ruby[こと][事]],
)]

=== #ruby[くに][国]

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[がいこく][外国]], [#ruby[そと][外]の#ruby[くに][国]],
  [#ruby[たいこく][大国]], [#ruby[おお][大]きい#ruby[くに][国]],
  [#ruby[ぜんこく][全国]], [#ruby[くに][国]の#ruby[ぜんぶ][全部]],
  [#ruby[こくりつ][国立]], [#ruby[くに][国]が#ruby[つく][作]った],
  [#ruby[こくがい][国外]], [#ruby[くに][国]の#ruby[そと][外]],
  [#ruby[こくめい][国名]], [#ruby[くに][国]の#ruby[なまえ][名前]],
  [#ruby[かいがい][海外]], [#ruby[うみ][海]の#ruby[そと][外]の#ruby[くに][国]],
)]

=== #ruby[こころ][心]と#ruby[かん][感]じ

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[ちゅうしん][中心]], [#ruby[もの][物]の#ruby[なか][中]の#ruby[なか][中]],
  [#ruby[かんしん][感心]], [#ruby[よ][良]いと#ruby[かん][感]じる#ruby[こころ][心]],
  [#ruby[かんどう][感動]], [#ruby[こころ][心]が#ruby[つよ][強]く#ruby[うご][動]くこと],
  [#ruby[きもち][気持ち]], [#ruby[こころ][心]が#ruby[かん][感]じること],
  [#ruby[おもいで][思い出]], [#ruby[まえ][前]のことを#ruby[おも][思]い#ruby[だ][出]すこと],
  [#ruby[どうかん][同感]], [#ruby[おな][同]じ#ruby[かん][感]じ],
)]

=== #ruby[うご][動]くと#ruby[か][変]わる

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[どうさ][動作]], [#ruby[からだ][体]を#ruby[うご][動]かすこと],
  [#ruby[へんどう][変動]], [#ruby[か][変]わって#ruby[うご][動]くこと],
  [#ruby[かいし][開始]], [#ruby[はじ][始]まること],
  [#ruby[かいへい][開閉]], [#ruby[あ][開]くことと#ruby[し][閉]めること],
  [#ruby[しじゅう][始終]], [#ruby[はじ][始]めから#ruby[お][終]わりまで],
  [#ruby[せいし][生死]], [#ruby[い][生]きることと#ruby[し][死]ぬこと],
  [#ruby[できごと][出来事]], [#ruby[お][起]こった#ruby[こと][事]],
  [#ruby[ひこう][飛行]], [#ruby[と][飛]んで#ruby[い][行]く#ruby[こと][事]],
  [#ruby[どうこう][同行]], [#ruby[おな][同]じに#ruby[い][行]く#ruby[こと][事]],
)]

=== #ruby[おお][大]きい

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[だいじ][大事]], [とても#ruby[ひつよう][必要]なこと],
  [#ruby[たいせつ][大切]], [とても#ruby[ひつよう][必要]で#ruby[す][好]きなこと],
  [#ruby[たいへん][大変]], [#ruby[おお][大]きく#ruby[か][変]わること],
  [#ruby[たいきん][大金]], [#ruby[おお][多]いお#ruby[かね][金]],
  [#ruby[おおや][大家]], [#ruby[いえ][家]を#ruby[も][持]つ#ruby[ひと][人]],
  [#ruby[たいし][大使]], [#ruby[くに][国]が#ruby[そと][外]に#ruby[だ][出]す#ruby[ひと][人]],
)]

=== #ruby[ほか][他]

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*#ruby[こと][言]#ruby[ば][葉]*][*#ruby[なに][何]の#ruby[こと][事]*],
  [#ruby[しょくじ][食事]], [#ruby[た][食]べること],
  [#ruby[かじ][火事]], [#ruby[ひ][火]が#ruby[おお][大]きくなる#ruby[わる][悪]い#ruby[こと][事]],
  [#ruby[ちじ][知事]], [#ruby[くに][国]の#ruby[ところ][所]を#ruby[まも][守]る#ruby[ひと][人]],
  [#ruby[きんいろ][金色]], [お#ruby[かね][金]の#ruby[いろ][色]],
  [#ruby[みずいろ][水色]], [#ruby[みず][水]の#ruby[いろ][色]],
  [#ruby[ねいろ][音色]], [#ruby[おと][音]の#ruby[いろ][色]],
  [#ruby[もくめ][木目]], [#ruby[き][木]を#ruby[き][切]ると#ruby[み][見]えるもの],
  [#ruby[めいもく][名目]], [#ruby[なまえ][名前]だけのこと],
  [#ruby[めいはく][明白]], [#ruby[あか][明]るくて#ruby[み][見]えること],
  [#ruby[たしょう][多少]], [#ruby[おお][多]いか#ruby[すこ][少]しか],
  [#ruby[がいけん][外見]], [#ruby[そと][外]から#ruby[み][見]ること],
  [#ruby[うわぎ][上着]], [#ruby[うえ][上]に#ruby[き][着]る#ruby[ふく][服]],
  [#ruby[したぎ][下着]], [#ruby[した][下]に#ruby[き][着]る#ruby[ふく][服]],
  [#ruby[あまおと][雨音]], [#ruby[あめ][雨]の#ruby[おと][音]],
  [#ruby[いっしょう][一生]], [#ruby[ひと][人]が#ruby[い][生]きる#ruby[ぜんぶ][全部]の#ruby[とき][時]],
  [#ruby[せいぜん][生前]], [#ruby[し][死]ぬ#ruby[まえ][前]の#ruby[とき][時]],
  [#ruby[ひとめ][一目]], [#ruby[ひと][一]つ#ruby[み][見]ること],
  [#ruby[ひとこと][一言]], [#ruby[ひと][一]つの#ruby[ことば][言葉]],
  [#ruby[あたまきん][頭金]], [#ruby[はじ][始]めに#ruby[だ][出]すお#ruby[かね][金]],
  [#ruby[ことり][小鳥]], [#ruby[ちい][小]さい#ruby[とり][鳥]],
  [#ruby[こいし][小石]], [#ruby[ちい][小]さい#ruby[いし][石]],
  [#ruby[こみち][小道]], [#ruby[ちい][小]さい#ruby[みち][道]],
  [#ruby[こさめ][小雨]], [#ruby[ちい][小]さい#ruby[あめ][雨]],
  [#ruby[うんかい][雲海]], [#ruby[くも][雲]の#ruby[うみ][海]。#ruby[やま][山]の#ruby[うえ][上]から#ruby[み][見]える],
  [#ruby[ひゃくにん][百人]], [#ruby[ひゃく][百]の#ruby[ひと][人]],
  [#ruby[こびと][小人]], [#ruby[ちい][小]さい#ruby[ひと][人]],
  [#ruby[すいぶん][水分]], [#ruby[みず][水]の#ruby[ぶん][分]],
  [#ruby[たぶん][多分]], [#ruby[おお][多]くの#ruby[ぶん][分]],
  [#ruby[じゅうぶん][十分]], [#ruby[じゅう][十]の#ruby[ぶん][分]で#ruby[ぜんぶ][全部]],
)]

#pagebreak(weak: true)

= 読み物

== #ruby[はな][話]し

=== #ruby[まい][毎]#ruby[にち][日]の#ruby[はな][話]し

#dialog-block[#ruby[か][買]う#ruby[ところ][所]で][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。この#ruby[た][食]べ#ruby[もの][物]は#ruby[なに][何]ですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* これは#ruby[よ][良]い#ruby[た][食]べ#ruby[もの][物]です。#ruby[みず][水]と#ruby[くさ][草]で#ruby[つく][作]りました。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* これをください。#ruby[ほか][他]の#ruby[もの][物]もありますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。そこに#ruby[あたら][新]しい#ruby[もの][物]があります。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それも#ruby[み][見]てもいいですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。#ruby[て][手]で#ruby[も][持]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* これを#ruby[か][買]います。ありがとう。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* ありがとう。また#ruby[き][来]てください。]][#none]

#dialog-block[#ruby[みち][道]で#ruby[ひと][人]と#ruby[あ][会]う][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* あ！どこに#ruby[い][行]きますか？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[いま][今]は#ruby[うみ][海]に#ruby[い][行]きます。あなたは？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]は#ruby[いえ][家]に#ruby[く][来]る。#ruby[からだ][体]が#ruby[すこ][少]し#ruby[わる][悪]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[からだ][体]が#ruby[わる][悪]いですか？#ruby[みず][水]を#ruby[の][飲]んで、#ruby[ね][寝]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとう。#ruby[うみ][海]の#ruby[かぜ][風]はとても#ruby[よ][良]いね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そうだね。でも#ruby[いま][今]は#ruby[かぜ][風]が#ruby[つよ][強]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[よ][良]く#ruby[まも][守]ってください。また#ruby[あ][会]おう！]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、また#ruby[あ][会]おう！]][#none]

#dialog-block[#ruby[いえ][家]の#ruby[よる][夜]の#ruby[た][食]べ#ruby[もの][物]][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[すわ][座]ってください。#ruby[た][食]べ#ruby[もの][物]ができた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[いま][今]は#ruby[なに][何]を#ruby[た][食]べる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[くさ][草]と#ruby[みず][水]で#ruby[つく][作]った。#ruby[からだ][体]に#ruby[よ][良]い。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* とても#ruby[よ][良]い#ruby[もの][物]だね。#ruby[いま][今]まで#ruby[からだ][体]がとても#ruby[おも][重]かった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[ちち][父]、#ruby[いま][今]の#ruby[にち][日]は#ruby[たの][楽]しかったか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* まあまあだった。でも#ruby[いえ][家]に#ruby[く][来]ることがもっと#ruby[す][好]きだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* この#ruby[もの][物]を#ruby[ぜんぶ][全部]#ruby[た][食]べてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい！とても#ruby[よ][良]い。ありがとう、#ruby[はは][母]。]][#none]

#dialog-block[#ruby[みち][道]を#ruby[き][聞]く][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。#ruby[おお][大]きい#ruby[おお][大]きい#ruby[いえ][家]はどこですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* ここから#ruby[とお][遠]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* どう#ruby[い][行]ったらいいですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* この#ruby[みち][道]を#ruby[い][行]ってください。#ruby[おお][大]きい#ruby[き][木]の#ruby[まえ][前]で#ruby[みぎ][右]に#ruby[はい][入]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[き][木]の#ruby[まえ][前]で#ruby[みぎ][右]だね。その#ruby[あと][後]は？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[おお][大]きい#ruby[いえ][家]を#ruby[み][見]ることができます。それです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ある][歩]いて#ruby[い][行]けますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、#ruby[ある][歩]いて#ruby[い][行]けます。#ruby[とお][遠]いですが、#ruby[よ][良]い#ruby[みち][道]だ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとう！]][#none]

#dialog-block[#ruby[にち][日]の#ruby[はじ][始]まり][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* もう#ruby[た][立]ってください！#ruby[にち][日]が#ruby[で][出]ている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* まだ#ruby[め][目]が#ruby[おも][重]い。もう#ruby[すこ][少]し#ruby[ね][寝]たい。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* いけない。#ruby[はや][速]く#ruby[ふく][服]を#ruby[き][着]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい。でも#ruby[いま][今]は#ruby[そら][空]が#ruby[あか][明]るくない。#ruby[あめ][雨]が#ruby[く][来]るか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* そうだね。#ruby[そと][外]は#ruby[すこ][少]し#ruby[さむ][寒]いから、#ruby[よ][良]い#ruby[ふく][服]を#ruby[き][着]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[いま][今]は#ruby[なに][何]を#ruby[た][食]べる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[みず][水]と#ruby[た][食]べ#ruby[もの][物]がある。#ruby[ぜんぶ][全部]#ruby[た][食]べてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい、#ruby[はは][母]。#ruby[いま][今]の#ruby[にち][日]も#ruby[たの][楽]しいと#ruby[おも][思]う！]][#none]

=== #ruby[かんが][考]える#ruby[はな][話]し

#dialog-block[#ruby[い][生]きるとは#ruby[なに][何]か][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[いし][石]は#ruby[うご][動]かない。#ruby[くさ][草]は#ruby[うご][動]く。#ruby[なに][何]が#ruby[い][生]き#ruby[もの][物]を#ruby[い][生]きている#ruby[もの][物]にする？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[うご][動]くだけじゃない。#ruby[みず][水]も#ruby[うご][動]く。#ruby[ひ][火]も#ruby[うご][動]く。でもそれは#ruby[い][生]きていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* じゃあ#ruby[なに][何]だ？#ruby[い][生]き#ruby[もの][物]には#ruby[なに][何]があって#ruby[いし][石]にはない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[い][生]きる#ruby[かぜ][風]だ。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]が#ruby[い][生]き#ruby[もの][物]に#ruby[い][生]きる#ruby[かぜ][風]を#ruby[あた][与]えた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[い][生]きる#ruby[かぜ][風]？#ruby[わたし][私]たちが#ruby[の][飲]む#ruby[かぜ][風]と#ruby[おな][同]じ？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* でも#ruby[ちが][違]う#ruby[かぜ][風]だ。それがないと#ruby[からだ][体]は#ruby[つち][土]と#ruby[みず][水]だけだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ぜんぶ][全部]の#ruby[い][生]き#ruby[もの][物]に#ruby[い][生]きる#ruby[かぜ][風]がある。でも#ruby[ひと][人]は#ruby[ほか][他]の#ruby[い][生]き#ruby[もの][物]と#ruby[ちが][違]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]は#ruby[ひと][人]をその#ruby[ひと][人]に#ruby[ちか][近]く#ruby[つく][作]った。だから#ruby[ひと][人]は#ruby[ぜんぶ][全部]の#ruby[い][生]き#ruby[もの][物]の#ruby[なか][中]でもっとも#ruby[おお][大]きい。]][#none]

#dialog-block[#ruby[よる][夜]の#ruby[ひかり][光]][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[よる][夜]の#ruby[そら][空]の#ruby[ひかり][光]は#ruby[なん][何]だと#ruby[おも][思]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* あの#ruby[ひかり][光]は#ruby[ぜんぶ][全部]の#ruby[はじ][始]まりの#ruby[とき][時]に#ruby[そら][空]に#ruby[あた][与]えられた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[はじ][始]まりの#ruby[とき][時]に？#ruby[ひと][人]より#ruby[まえ][前]に？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]が#ruby[そら][空]と#ruby[つち][土]を#ruby[つく][作]った#ruby[あと][後]に#ruby[そら][空]に#ruby[ひかり][光]を#ruby[あた][与]えた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* じゃああの#ruby[ひかり][光]は#ruby[ひかり][光]だけじゃない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[み][見]#ruby[まも][守]る#ruby[もの][物]だ。#ruby[そら][空]に#ruby[あた][与]えられた#ruby[つか][使]いだ。#ruby[うえ][上]から#ruby[わたし][私]たちを#ruby[み][見]#ruby[まも][守]っている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[うえ][上]からの#ruby[つか][使]い？#ruby[はじ][始]まりの#ruby[とき][時]からそこにいる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[つち][土]と#ruby[うみ][海]が#ruby[つく][作]られた#ruby[とき][時]から#ruby[か][変]わっていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* だから#ruby[まい][毎]#ruby[よる][夜]#ruby[か][変]わらない#ruby[ひかり][光]がある。いつも#ruby[うえ][上]から#ruby[み][見]#ruby[まも][守]っている。]][#none]

#dialog-block[なぜ#ruby[ひと][人]は#ruby[たたか][戦]うの？][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[ちち][父]さん、なぜ#ruby[ひと][人]は#ruby[たたか][戦]うの？#ruby[たたか][戦]うと#ruby[かな][悲]しいことが#ruby[お][起]こるのに。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* そうだね。#ruby[ひと][人]は#ruby[こわ][怖]い#ruby[とき][時]に#ruby[す][好]きな#ruby[もの][物]を#ruby[まも][守]りたくなる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* でも#ruby[たたか][戦]って#ruby[まも][守]れるの？#ruby[たたか][戦]うともっと#ruby[かな][悲]しいことが#ruby[お][起]こる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* #ruby[ほんとう][本当]にそうだ。#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[つよ][強]い#ruby[まも][守]り#ruby[かた][方]は#ruby[す][好]きでいることだ。#ruby[わたし][私]を#ruby[す][好]きなように#ruby[ほか][他]の#ruby[ひと][人]も#ruby[す][好]きでいること。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* でも#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]は？#ruby[たたか][戦]いに#ruby[く][来]る#ruby[ひと][人]は？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* その#ruby[ひと][人]たちもだ。#ruby[わたし][私]に#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]も#ruby[す][好]きでいる。それが#ruby[ひと][人]にできる#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[つよ][強]い#ruby[こと][事]だ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[わたし][私]に#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]を#ruby[す][好]きでいるの？それはとてもできにくいと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* できにくい。でも#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]がそう#ruby[い][言]った。#ruby[わたし][私]を#ruby[す][好]きなように#ruby[ほか][他]の#ruby[ひと][人]を#ruby[す][好]きでいなさい。#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]も。]][#none]

#dialog-block[#ruby[ひと][人]だけが#ruby[も][持]つ#ruby[もの][物]][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[どうぶつ][動物]も#ruby[た][食]べて、#ruby[の][飲]んで、#ruby[こども][子供]を#ruby[まも][守]る。#ruby[ひと][人]と#ruby[ほんとう][本当]に#ruby[ちが][違]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ひと][人]は#ruby[か][書]く。#ruby[あ][会]ったことのない#ruby[ひと][人]に#ruby[ことば][言葉]を#ruby[あた][与]える。#ruby[し][死]んだ#ruby[あと][後]も。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それは#ruby[おお][大]きい。#ruby[どうぶつ][動物]は#ruby[いま][今]に#ruby[い][生]きる。#ruby[ひと][人]は#ruby[まえ][前]と#ruby[あと][後]に#ruby[い][生]きる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ひと][人]は#ruby[うご][動]く#ruby[もの][物]も#ruby[つく][作]る。#ruby[て][手]でできないことを#ruby[うご][動]く#ruby[もの][物]でできるようにする。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* でも#ruby[いし][石]を#ruby[つか][使]う#ruby[どうぶつ][動物]もいる。#ruby[ひと][人]だけが#ruby[もの][物]を#ruby[つか][使]うのではない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[もの][物]を#ruby[つか][使]うことと、#ruby[もの][物]について#ruby[かんが][考]えることは#ruby[ちが][違]う。#ruby[ひと][人]は#ruby[み][見]えない#ruby[こと][事]を#ruby[かんが][考]える。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[み][見]えない#ruby[こと][事]？　どんな#ruby[こと][事]？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* 「なぜ#ruby[い][生]きるのか」。#ruby[どうぶつ][動物]はこれを#ruby[き][聞]かない。#ruby[ひと][人]だけが#ruby[き][聞]く。それが#ruby[よ][良]いことか#ruby[わる][悪]いことかは、まだ#ruby[し][知]らない。]][#none]

#dialog-block[#ruby[とき][時]について][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[ところ][所]に#ruby[き][来]て、#ruby[おお][多]い#ruby[とし][年]が#ruby[お][終]わった。あの#ruby[き][木]は#ruby[まえ][前]に#ruby[ちい][小]さかった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[き][木]は#ruby[か][変]わった。でも#ruby[やま][山]は#ruby[か][変]わっていない。#ruby[とき][時]は#ruby[もの][物]によって#ruby[ちが][違]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]たちも#ruby[か][変]わった。#ruby[からだ][体]が#ruby[か][変]わった。でも……#ruby[こころ][心]の#ruby[なか][中]はどうだろう。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[こども][子供]の#ruby[とき][時]に#ruby[かん][感]じた#ruby[こと][事]は、まだ#ruby[こころ][心]の#ruby[なか][中]にある。#ruby[か][変]わっていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[とき][時]は#ruby[まえ][前]に#ruby[うご][動]くだけ？　#ruby[まえ][前]に#ruby[い][行]くことはできない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[からだ][体]は#ruby[まえ][前]に#ruby[い][行]けない。でも#ruby[こころ][心]は#ruby[い][行]ける。#ruby[ほん][本]の#ruby[なか][中]で、#ruby[め][目]を#ruby[し][閉]めた#ruby[なか][中]で。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それなら#ruby[とき][時]は#ruby[ふた][二]つある。#ruby[からだ][体]の#ruby[とき][時]と、#ruby[こころ][心]の#ruby[とき][時]と。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そして#ruby[わたし][私]たちが#ruby[し][死]んだ#ruby[あと][後]も、あなたと#ruby[わたし][私]が#ruby[かん][感]じた#ruby[こと][事]は#ruby[ほか][他]の#ruby[ひと][人]の#ruby[こころ][心]の#ruby[なか][中]で#ruby[い][生]きるかもしれない。]][#none]

#dialog-block[#ruby[し][知]ること][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[おし][教]える#ruby[ひと][人]、#ruby[ほん][本]を#ruby[よ][読]んだら、その#ruby[こと][事]を#ruby[し][知]っていると#ruby[い][言]えるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ほん][本]の#ruby[ことば][言葉]は#ruby[し][知]ることができる。でも、#ruby[ほんとう][本当]に#ruby[し][知]ることは#ruby[ちが][違]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* どう#ruby[ちが][違]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[て][手]で#ruby[つく][作]ったり、#ruby[からだ][体]で#ruby[かん][感]じたりしたとき、#ruby[ほんとう][本当]に#ruby[し][知]る#ruby[こと][事]が#ruby[はじ][始]まる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* では、#ruby[わたし][私]はまだ#ruby[し][知]らないのか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[し][知]りたいと#ruby[おも][思]っているなら、もう#ruby[はじ][始]まっている。それで#ruby[よ][良]いと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[し][知]ることは#ruby[お][終]わるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[よ][良]い#ruby[おし][教]える#ruby[ひと][人]も、まだ#ruby[し][知]らない#ruby[こと][事]がとても#ruby[おお][多]いと#ruby[かん][感]じている。]][#none]

#dialog-block[#ruby[うみ][海]の#ruby[そと][外]][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[うみ][海]はとても#ruby[おお][大]きいね。#ruby[そと][外]に#ruby[なに][何]があるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ほか][他]の#ruby[くに][国]がある。でも#ruby[め][目]では#ruby[み][見]えない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* その#ruby[くに][国]の#ruby[ひと][人]たちも、この#ruby[みず][水]を#ruby[み][見]ていると#ruby[おも][思]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、#ruby[ぜんぶ][全部]#ruby[ひと][一]つの#ruby[みず][水]だ。#ruby[うみ][海]は#ruby[ひと][一]つだと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[みず][水]の#ruby[なか][中]に#ruby[なに][何]がいるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[どうぶつ][動物]が#ruby[おお][多]くいる。#ruby[わたし][私]たちが#ruby[し][知]らない#ruby[どうぶつ][動物]も、まだいると#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[うみ][海]は#ruby[こわ][怖]いか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[こわ][怖]い。でも#ruby[うみ][海]の#ruby[おと][音]を#ruby[き][聞]くと、#ruby[こころ][心]が#ruby[よ][良]くなる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]もそう#ruby[かん][感]じる。#ruby[おお][大]きい#ruby[もの][物]の#ruby[まえ][前]に#ruby[た][立]つと、#ruby[こころ][心]が#ruby[ちい][小]さくなる。]][#none]

#dialog-block[#ruby[あたら][新]しいものと#ruby[まえ][前]のもの][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[くに][国]はとても#ruby[か][変]わったね。#ruby[まえ][前]は#ruby[ちが][違]った。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。#ruby[あたら][新]しい#ruby[おお][大]きい#ruby[いえ][家]が#ruby[おお][多]くなった。#ruby[まえ][前]からある#ruby[いえ][家]は#ruby[すく][少]なくなった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[まえ][前]からある#ruby[みち][道]も#ruby[か][変]わった。#ruby[まえ][前]は#ruby[き][木]が#ruby[おお][多]かった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[あたら][新]しいものは#ruby[よ][良]いか、#ruby[わる][悪]いか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[あたら][新]しい#ruby[うご][動]く#ruby[もの][物]で、#ruby[ひと][人]がする#ruby[こと][事]が#ruby[はや][速]くなった。でも#ruby[まえ][前]にしていた#ruby[こと][事]を#ruby[し][知]っている#ruby[ひと][人]が#ruby[すく][少]なくなっている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ことば][言葉]も#ruby[か][変]わる。#ruby[まえ][前]の#ruby[ひと][人]たちの#ruby[ことば][言葉]は#ruby[いま][今]もあるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ほん][本]の#ruby[なか][中]にある。でも#ruby[つか][使]う#ruby[ひと][人]は#ruby[すこ][少]しだけだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[か][変]わらない#ruby[こと][事]はあるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[やま][山]と#ruby[うみ][海]はまだ#ruby[か][変]わらない。#ruby[たいよう][太陽]も#ruby[まい][毎]#ruby[にち][日]#ruby[で][出]る。]][#none]

#dialog-block[#ruby[おと][音]と#ruby[こころ][心]][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* あの#ruby[ひと][人]が#ruby[つく][作]った#ruby[おと][音]を#ruby[き][聞]くと、#ruby[かな][悲]しくなる。なぜか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[わたし][私]もそう#ruby[かん][感]じる。その#ruby[おと][音]は#ruby[なに][何]かを#ruby[かん][感]じさせる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ことば][言葉]は#ruby[つか][使]っていない。でも#ruby[こころ][心]に#ruby[はい][入]る。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ことば][言葉]より#ruby[まえ][前]に、#ruby[からだ][体]が#ruby[かん][感]じると#ruby[おも][思]う。#ruby[あめ][雨]の#ruby[おと][音]や#ruby[かぜ][風]の#ruby[おと][音]も、#ruby[こころ][心]を#ruby[うご][動]かす。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* では、#ruby[ひと][人]が#ruby[つく][作]る#ruby[おと][音]と#ruby[やま][山]や#ruby[うみ][海]の#ruby[おと][音]は#ruby[ちが][違]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ちが][違]うと#ruby[おも][思]う。#ruby[ひと][人]が#ruby[つく][作]る#ruby[おと][音]の#ruby[なか][中]には、その#ruby[ひと][人]の#ruby[こころ][心]がある。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[かな][悲]しい#ruby[おと][音]を#ruby[き][聞]いて、なぜ#ruby[たの][楽]しいと#ruby[かん][感]じるか。#ruby[へん][変]だね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[かな][悲]しさを#ruby[かん][感]じていい、と#ruby[おも][思]えるからかもしれない。#ruby[ひと][一]りじゃないと#ruby[かん][感]じる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* その#ruby[おと][音]を#ruby[つく][作]った#ruby[ひと][人]も、その#ruby[かな][悲]しさを#ruby[し][知]っていたのだね。]][#none]

== #ruby[なが][長]くない#ruby[はな][話]し

#story-block[#ruby[やま][山]][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[ひと][一]りで#ruby[やま][山]に#ruby[い][行]った。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[こころ][心]の#ruby[なか][中]で、#ruby[なに][何]かが#ruby[か][変]わった。]][#none]

#story-block[#ruby[ふた][二]つの#ruby[くに][国]][#block(inset: (top: 0.15em, bottom: 0.15em))[ある#ruby[くに][国]の#ruby[ひと][人]は#ruby[うみ][海]の#ruby[ちか][近]くにいた。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[つき][月]が#ruby[そら][空]に#ruby[で][出]ていた。#ruby[ふた][二]つの#ruby[くに][国]から#ruby[み][見]ても、#ruby[ひと][一]つの#ruby[つき][月]だ。]][#none]

#story-block[#ruby[おお][大]きい#ruby[き][木]][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[やま][山]の#ruby[なか][中]に#ruby[ひと][一]つの#ruby[おお][大]きい#ruby[き][木]があった。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[き][木]も#ruby[なに][何]も#ruby[い][言]わなかった。でも#ruby[ふた][二]つの#ruby[こころ][心]は#ruby[ひと][一]つになった。]][#none]

#story-block[#ruby[こども][子供]の「なぜ」][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[こども][子供]はいつも「なぜ？」と#ruby[き][聞]いた。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちち][父]はその#ruby[こと][事]を#ruby[かん][感]じて、#ruby[わら][笑]った。]][#none]

#story-block[#ruby[いぬ][犬]と#ruby[とり][鳥]][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]の#ruby[いぬ][犬]は#ruby[まい][毎]#ruby[にち][日]#ruby[そと][外]を#ruby[ある][歩]く。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いま][今]#ruby[にち][日]も#ruby[みち][道]を#ruby[ある][歩]いていた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[そら][空]に#ruby[しろ][白]い#ruby[くも][雲]があった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[その#ruby[くも][雲]の#ruby[した][下]で、#ruby[とり][鳥]が#ruby[と][飛]んでいた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[うえ][上]を#ruby[み][見]て、#ruby[うご][動]かなくなった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[と][飛]びたいと#ruby[おも][思]った。でも#ruby[あし][足]は#ruby[つち][土]の#ruby[うえ][上]にある。]
#block(inset: (top: 0.15em, bottom: 0.15em))[その#ruby[とき][時]、#ruby[ちい][小]さい#ruby[とり][鳥]が#ruby[いち][一]つ、#ruby[き][木]の#ruby[した][下]に#ruby[き][来]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちい][小]さい#ruby[とり][鳥]は#ruby[ある][歩]いていた。#ruby[と][飛]ばなかった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]と#ruby[とり][鳥]は#ruby[おな][同]じ#ruby[みち][道]を#ruby[ある][歩]いた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[わ][分]かった。#ruby[そら][空]を#ruby[と][飛]ばなくても、#ruby[おな][同]じ#ruby[ところ][所]に#ruby[い][行]ける。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ふた][二]つの#ruby[どうぶつ][動物]は、#ruby[おな][同]じ#ruby[かぜ][風]を#ruby[かん][感]じていた。]][#none]

#story-block[#ruby[とお][遠]い#ruby[ところ][所]の#ruby[さかな][魚]][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[はら][腹]に#ruby[た][食]べ#ruby[もの][物]がなかった。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[たぶん#ruby[あと][後]の#ruby[にち][日]も、あの#ruby[さかな][魚]を#ruby[か][買]いに#ruby[い][行]く。]][#none]

#story-block[#ruby[かみ][髪]を#ruby[き][切]る#ruby[ひと][人]][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[かみ][髪]が#ruby[なが][長]くなった。#ruby[き][切]る#ruby[とき][時]が#ruby[き][来]た。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[かみ][髪]を#ruby[き][切]る#ruby[ひと][人]と#ruby[はな][話]すのは#ruby[たの][楽]しかった。]][#none]

== #ruby[すこ][少]しの#ruby[こと][言]#ruby[ば][葉]

=== #ruby[そと][外]の#ruby[もの][物]

#haiku-block[#ruby[やま][山]の#ruby[うえ][上] #linebreak() #ruby[かぜ][風]が#ruby[き][来]ている #linebreak() #ruby[そら][空]#ruby[あお][青]い][#none]

#haiku-block[#ruby[あめ][雨]の#ruby[おと][音] #linebreak() #ruby[そと][外]に#ruby[き][聞]こえる #linebreak() #ruby[よる][夜]の#ruby[みち][道]][#none]

#haiku-block[#ruby[うみ][海]の#ruby[みず][水] #linebreak() #ruby[おお][大]きく#ruby[うご][動]く #linebreak() #ruby[しろ][白]い#ruby[いし][石]][#none]

#haiku-block[#ruby[しろ][白]い#ruby[つき][月] #linebreak() #ruby[みず][水]の#ruby[うえ][上]#ruby[で][出]る #linebreak() #ruby[よる][夜]の#ruby[うみ][海]][#none]

#haiku-block[#ruby[くも][雲]が#ruby[く][来]る #linebreak() #ruby[とり][鳥]が#ruby[と][飛]んでる #linebreak() #ruby[あめ][雨]の#ruby[まえ][前]][#none]

#haiku-block[#ruby[さかな][魚]#ruby[い][行]く #linebreak() #ruby[みず][水]で#ruby[ひか][光]って #linebreak() #ruby[うみ][海]の#ruby[おと][音]][#none]

=== #ruby[まい][毎]#ruby[にち][日]

#haiku-block[#ruby[みず][水]を#ruby[の][飲]む #linebreak() #ruby[たいよう][太陽]が#ruby[で][出]て #linebreak() #ruby[そと][外]を#ruby[み][見]る][#none]

#haiku-block[#ruby[た][食]べ#ruby[もの][物]を #linebreak() #ruby[こども][子供]と#ruby[た][食]べる #linebreak() #ruby[いえ][家]の#ruby[なか][中]][#none]

#haiku-block[#ruby[みち][道]を#ruby[い][行]く #linebreak() #ruby[おお][大]きい#ruby[き][木]#ruby[み][見]る #linebreak() #ruby[かぜ][風]の#ruby[おと][音]][#none]

#haiku-block[#ruby[よる][夜]が#ruby[く][来]る #linebreak() #ruby[つき][月]を#ruby[み][見]ている #linebreak() #ruby[め][目]を#ruby[し][閉]める][#none]

#haiku-block[#ruby[いぬ][犬]#ruby[ある][歩]く #linebreak() #ruby[おな][同]じ#ruby[みち][道]#ruby[い][行]く #linebreak() #ruby[かぜ][風]#ruby[ちが][違]う][#none]

#haiku-block[#ruby[はら][腹]が#ruby[い][言]う #linebreak() #ruby[さかな][魚]#ruby[た][食]べたい #linebreak() #ruby[うみ][海]#ruby[とお][遠]い][#none]

=== #ruby[こころ][心]

#haiku-block[#ruby[ひと][人]を#ruby[ま][待]つ #linebreak() #ruby[こころ][心]の#ruby[なか][中]に #linebreak() いつもいる][#none]

#haiku-block[#ruby[たの][楽]しくて #linebreak() #ruby[こども][子供]が#ruby[わら][笑]う #linebreak() #ruby[おと][音]を#ruby[き][聞]く][#none]

#haiku-block[#ruby[な][泣]く#ruby[こども][子供] #linebreak() #ruby[はは][母]が#ruby[て][手]を#ruby[も][持]つ #linebreak() #ruby[ひかり][光]#ruby[み][見]る][#none]

#haiku-block[#ruby[ひと][人]に#ruby[あ][会]う #linebreak() #ruby[ことば][言葉]を#ruby[すこ][少]し #linebreak() #ruby[わら][笑]う#ruby[ひと][人]][#none]

#haiku-block[#ruby[わ][分]かりたい #linebreak() #ruby[こころ][心]で#ruby[わ][分]かる #linebreak() たぶんそう][#none]

#haiku-block[#ruby[はな][話]したい #linebreak() #ruby[ことば][言葉]ない#ruby[とき][時] #linebreak() #ruby[め][目]が#ruby[はな][話]す][#none]

=== #ruby[とき][時]の#ruby[か][変]わり

#haiku-block[#ruby[くさ][草]#ruby[ひら][開]く #linebreak() #ruby[やま][山]の#ruby[かぜ][風]#ruby[く][来]る #linebreak() #ruby[くさ][草]#ruby[うご][動]く][#none]

#haiku-block[#ruby[そら][空]#ruby[あつ][暑]い #linebreak() #ruby[みず][水]を#ruby[の][飲]む#ruby[ひと][人] #linebreak() #ruby[にち][日]#ruby[お][終]わる][#none]

#haiku-block[#ruby[き][木]が#ruby[か][変]わる #linebreak() #ruby[あか][赤]くなる#ruby[やま][山] #linebreak() #ruby[かぜ][風]#ruby[さむ][寒]い][#none]

#haiku-block[#ruby[さむ][寒]い#ruby[よる][夜] #linebreak() #ruby[ひ][火]に#ruby[ちか][近]い#ruby[ひと][人] #linebreak() #ruby[おと][音]もない][#none]

=== #ruby[ひと][人]と#ruby[ひと][人]

#haiku-block[#ruby[だれ][誰]か#ruby[く][来]る #linebreak() #ruby[し][知]らない#ruby[なまえ][名前] #linebreak() #ruby[わら][笑]う#ruby[ひと][人]][#none]

#haiku-block[また#ruby[あ][会]おう #linebreak() と#ruby[い][言]った#ruby[あと][後]に #linebreak() #ruby[みち][道]#ruby[なが][長]い][#none]

#haiku-block[あなた#ruby[ま][待]つ #linebreak() #ruby[こ][来]ないと#ruby[し][知]って #linebreak() まだここに][#none]

#haiku-block[#ruby[て][手]#ruby[あた][与]える #linebreak() もらう#ruby[ひと][人]の#ruby[め][目] #linebreak() #ruby[ひかり][光]#ruby[み][見]た][#none]

#haiku-block[いいえ#ruby[い][言]う #linebreak() #ruby[こころ][心]#ruby[かな][悲]しい #linebreak() それでいい][#none]

=== #ruby[い][生]きると#ruby[し][死]ぬ

#haiku-block[#ruby[はじ][始]まりの #linebreak() #ruby[すこ][少]しの#ruby[からだ][体] #linebreak() #ruby[な][泣]いている][#none]

#haiku-block[#ruby[い][生]きること #linebreak() #ruby[た][食]べて#ruby[うご][動]いて #linebreak() #ruby[く][来]る#ruby[にち][日]へ][#none]

#haiku-block[#ruby[ひと][人]は#ruby[し][死]ぬ #linebreak() #ruby[つち][土]の#ruby[なか][中]#ruby[い][入]る #linebreak() #ruby[くさ][草]#ruby[い][生]きる][#none]

#haiku-block[#ruby[お][終]わる#ruby[よる][夜] #linebreak() #ruby[ひかり][光]#ruby[はじ][始]まる #linebreak() #ruby[そら][空]はある][#none]

#haiku-block[#ruby[しろ][白]い#ruby[かみ][髪] #linebreak() #ruby[ひゃく][百]#ruby[ねん][年]#ruby[い][生]きて #linebreak() #ruby[ほね][骨]#ruby[つよ][強]い][#none]

=== #ruby[ひかり][光]と#ruby[ひかり][光]がない

#haiku-block[#ruby[つき][月]の#ruby[よる][夜] #linebreak() #ruby[ひ][火]が#ruby[ひと][一]つある #linebreak() #ruby[だれ][誰]かいる][#none]

#haiku-block[#ruby[ひかり][光]#ruby[く][来]る #linebreak() #ruby[こわ][怖]いの#ruby[お][終]わる #linebreak() #ruby[め][目]を#ruby[ひら][開]く][#none]

#haiku-block[#ruby[ひ][火]を#ruby[と][止]めて #linebreak() #ruby[ひかり][光]なくなる #linebreak() #ruby[からだ][体]だけ][#none]

#haiku-block[#ruby[よる][夜]の#ruby[そら][空] #linebreak() #ruby[つき][月]#ruby[しろ][白]く#ruby[で][出]る #linebreak() #ruby[みち][道]#ruby[しろ][白]い][#none]

=== #ruby[こと][言]#ruby[ば][葉]

#haiku-block[#ruby[ことば][言葉]ない #linebreak() #ruby[こころ][心]が#ruby[うご][動]く #linebreak() #ruby[ひと][人]と#ruby[ひと][人]][#none]

#haiku-block[#ruby[か][書]く#ruby[ことば][言葉] #linebreak() #ruby[だれ][誰]も#ruby[よ][読]まない #linebreak() まだそこに][#none]

#haiku-block[#ruby[き][聞]く#ruby[ことば][言葉] #linebreak() #ruby[し][知]らない#ruby[ことば][言葉] #linebreak() #ruby[みち][道]#ruby[ひら][開]く][#none]

#haiku-block[#ruby[い][言]わないで #linebreak() #ruby[て][手]を#ruby[も][持]っている #linebreak() それでいい][#none]

#back-cover("minihongo.com")
