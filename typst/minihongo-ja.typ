#import "template.typ": *

#show: book.with(title: "ミニ本語", lang: "ja", print: false)

#cover-page("ミニ本語", "207語で何でも言える。", "/site/static/logo.svg")
#pagebreak()

#outline(title: none, indent: 1.5em, depth: 3)
#pagebreak()

= 語彙

== #ruby[ひと][人]と#ruby[だれ][誰] (代名詞と人)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[ひと][人]], [人間、ひと], [あの#ruby[ひと][人]は#ruby[だれ][誰]？],
  [#ruby[わたし][私]], [自分、わたくし], [#ruby[わたし][私]は#ruby[ひと][人]だ。],
  [あなた], [あなた、相手], [あなたは#ruby[だれ][誰]？],
  [#ruby[だれ][誰]], [誰、何者], [#ruby[だれ][誰]が#ruby[く][来]る？],
  [#ruby[おとこ][男]], [男性], [あの#ruby[おとこ][男]は#ruby[おお][大]きい。],
  [#ruby[おんな][女]], [女性], [あの#ruby[おんな][女]は#ruby[はは][母]だ。],
  [#ruby[こども][子供]], [子供、幼い人], [#ruby[こども][子供]は#ruby[そと][外]で#ruby[はし][走]る。],
  [#ruby[はは][母]], [母親], [#ruby[はは][母]は#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る。],
  [#ruby[ちち][父]], [父親], [#ruby[ちち][父]は#ruby[やま][山]に#ruby[い][行]く。],
)]

== #ruby[もの][物]と#ruby[た][食]べ#ruby[もの][物] (物と食べ物)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[もの][物]], [品物、もの], [この#ruby[もの][物]は#ruby[なん][何]だ？],
  [#ruby[こと][事]], [事柄、抽象的なこと], [その#ruby[こと][事]は#ruby[ひつよう][必要]だ。],
  [#ruby[なに][何]], [何、不明なもの], [#ruby[なに][何]を#ruby[た][食]べる？],
  [#ruby[ふく][服]], [衣服], [#ruby[あたら][新]しい#ruby[ふく][服]を#ruby[き][着]る。],
  [#ruby[ほん][本]], [書物], [#ruby[ほん][本]を#ruby[よ][読]む。],
  [お#ruby[かね][金]], [貨幣、通貨], [お#ruby[かね][金]で#ruby[た][食]べ#ruby[もの][物]を#ruby[か][買]う。],
  [#ruby[にく][肉]], [肉、食肉], [#ruby[にく][肉]を#ruby[た][食]べる。],
  [#ruby[たまご][卵]], [卵、玉子], [#ruby[たまご][卵]を#ruby[た][食]べる。],
)]

== #ruby[そと][外]の#ruby[もの][物] (自然)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[いし][石]], [石、岩], [#ruby[みち][道]に#ruby[いし][石]がある。],
  [#ruby[き][木]], [樹木、木材], [#ruby[やま][山]に#ruby[き][木]がある。],
  [#ruby[つち][土]], [土壌、大地], [#ruby[つち][土]の#ruby[なか][中]に#ruby[くさ][草]がある。],
  [#ruby[みず][水]], [水、液体], [#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[ひ][火]], [炎、火], [#ruby[ひ][火]は#ruby[あつ][暑]い。],
  [#ruby[かぜ][風]], [風], [#ruby[そと][外]は#ruby[かぜ][風]が#ruby[つよ][強]い。],
  [#ruby[たいよう][太陽]], [太陽], [#ruby[たいよう][太陽]は#ruby[そら][空]にある。],
  [#ruby[ひかり][光]], [光、明かり], [#ruby[たいよう][太陽]の#ruby[ひかり][光]が#ruby[み][見]える。],
  [#ruby[つき][月]], [月], [#ruby[よる][夜]、#ruby[つき][月]が#ruby[み][見]える。],
  [#ruby[そら][空]], [空], [#ruby[そら][空]が#ruby[あお][青]い。],
  [#ruby[やま][山]], [山], [#ruby[やま][山]に#ruby[い][行]く。],
  [#ruby[うみ][海]], [海、大洋], [#ruby[うみ][海]はとても#ruby[おお][大]きい。],
  [#ruby[あめ][雨]], [雨], [#ruby[あめ][雨]の#ruby[にち][日]は#ruby[そと][外]に#ruby[い][行]かない。],
  [#ruby[くさ][草]], [草、植物], [#ruby[くさ][草]が#ruby[みどり][緑]だ。],
  [#ruby[くも][雲]], [雲], [#ruby[そら][空]に#ruby[くも][雲]がある。],
)]

== #ruby[どうぶつ][動物] (動物)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[どうぶつ][動物]], [動物], [#ruby[どうぶつ][動物]が#ruby[す][好]きだ。],
  [#ruby[さかな][魚]], [魚、魚類], [#ruby[うみ][海]に#ruby[さかな][魚]がいる。],
  [#ruby[とり][鳥]], [鳥、鳥類], [#ruby[とり][鳥]が#ruby[そら][空]を#ruby[と][飛]ぶ。],
  [#ruby[いぬ][犬]], [犬], [#ruby[いぬ][犬]が#ruby[いえ][家]にいる。],
)]

== #ruby[からだ][体] (体の部位)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[からだ][体]], [体、身体], [#ruby[からだ][体]が#ruby[つよ][強]い。],
  [#ruby[あたま][頭]], [頭], [#ruby[あたま][頭]で#ruby[かんが][考]える。],
  [#ruby[て][手]], [手], [#ruby[て][手]で#ruby[もの][物]を#ruby[も][持]つ。],
  [#ruby[あし][足]], [足、脚], [#ruby[あし][足]で#ruby[うご][動]く。],
  [#ruby[め][目]], [目], [#ruby[め][目]で#ruby[み][見]る。],
  [#ruby[くち][口]], [口], [#ruby[くち][口]で#ruby[た][食]べる。],
  [#ruby[みみ][耳]], [耳], [#ruby[みみ][耳]で#ruby[き][聞]く。],
  [#ruby[はな][鼻]], [鼻], [#ruby[はな][鼻]から#ruby[かぜ][風]が#ruby[はい][入]る。],
  [#ruby[こころ][心]], [心、精神], [#ruby[こころ][心]が#ruby[あたた][温]かい#ruby[ひと][人]だ。],
  [#ruby[は][歯]], [歯], [#ruby[は][歯]で#ruby[た][食]べ#ruby[もの][物]を#ruby[き][切]る。],
  [#ruby[ち][血]], [血、血液], [#ruby[て][手]から#ruby[ち][血]が#ruby[で][出]る。],
  [#ruby[ほね][骨]], [骨], [#ruby[ほね][骨]が#ruby[つよ][強]い。],
  [#ruby[はら][腹]], [腹、お腹], [#ruby[はら][腹]に#ruby[た][食]べ#ruby[もの][物]がない。],
  [#ruby[かみ][髪]], [髪、髪の毛], [#ruby[かみ][髪]が#ruby[なが][長]い。],
  [#ruby[かわ][皮]], [皮、肌、皮膚], [#ruby[かわ][皮]が#ruby[あか][赤]い。],
)]

== する#ruby[こと][事] (動詞)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [する], [する、行う], [#ruby[なに][何]をする？],
  [いる], [いる、存在する], [#ruby[どうぶつ][動物]が#ruby[やま][山]にいる。],
  [ある], [ある、持っている], [#ruby[ほん][本]が#ruby[いえ][家]にある。],
  [なる], [なる、変化する], [#ruby[おお][大]きくなる。],
  [#ruby[お][起]こる], [起こる], [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こる。],
  [#ruby[い][行]く], [行く], [#ruby[やま][山]に#ruby[い][行]く。],
  [#ruby[く][来]る], [来る], [#ruby[ひと][人]が#ruby[いえ][家]に#ruby[く][来]る。],
  [#ruby[うご][動]く], [動く], [#ruby[どうぶつ][動物]が#ruby[うご][動]く。],
  [#ruby[はい][入]る], [入る], [#ruby[いえ][家]に#ruby[はい][入]る。],
  [#ruby[で][出]る], [出る], [#ruby[いえ][家]から#ruby[で][出]る。],
  [#ruby[と][止]める], [止まる、止める], [#ruby[うご][動]きを#ruby[と][止]める。],
  [#ruby[つく][作]る], [作る、創る], [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る。],
  [#ruby[つか][使]う], [使う], [#ruby[もの][物]を#ruby[つか][使]う。],
  [#ruby[き][切]る], [切る], [#ruby[き][木]を#ruby[き][切]る。],
  [#ruby[た][食]べる], [食べる], [#ruby[よる][夜]に#ruby[た][食]べる。],
  [#ruby[の][飲]む], [飲む], [#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[ね][寝]る], [寝る、眠る], [#ruby[よる][夜]に#ruby[ね][寝]る。],
  [#ruby[き][着]る], [着る], [#ruby[ふく][服]を#ruby[き][着]る。],
  [#ruby[すわ][座]る], [座る], [#ruby[いえ][家]で#ruby[すわ][座]る。],
  [#ruby[た][立]つ], [立つ], [#ruby[そと][外]で#ruby[た][立]つ。],
  [#ruby[い][生]きる], [生きる], [#ruby[どうぶつ][動物]は#ruby[みず][水]で#ruby[い][生]きる。],
  [#ruby[し][死]ぬ], [死ぬ], [#ruby[くさ][草]が#ruby[し][死]ぬ。],
  [#ruby[はじ][始]まる], [始まる], [#ruby[にち][日]が#ruby[はじ][始]まる。],
  [#ruby[お][終]わる], [終わる], [#ruby[にち][日]が#ruby[お][終]わる。],
  [#ruby[あ][開]く], [開ける、開く], [#ruby[め][目]が#ruby[あ][開]く。],
  [#ruby[し][閉]める], [閉める、閉じる], [#ruby[め][目]を#ruby[し][閉]める。],
  [#ruby[か][変]わる], [変わる], [#ruby[そら][空]の#ruby[いろ][色]が#ruby[か][変]わる。],
  [#ruby[あた][与]える], [与える], [#ruby[どうぶつ][動物]に#ruby[た][食]べ#ruby[もの][物]を#ruby[あた][与]える。],
  [もらう], [受ける、もらう], [#ruby[ひと][人]から#ruby[ほん][本]をもらう。],
  [#ruby[も][持]つ], [持つ、所有する], [#ruby[ほん][本]を#ruby[も][持]つ。],
  [#ruby[あ][会]う], [会う], [#ruby[ひと][人]に#ruby[あ][会]う。],
  [#ruby[ま][待]つ], [待つ], [#ruby[ひと][人]を#ruby[ま][待]つ。],
  [#ruby[たす][助]ける], [助ける], [#ruby[ひと][人]を#ruby[たす][助]ける。],
  [#ruby[まも][守]る], [守る], [#ruby[こども][子供]を#ruby[まも][守]る。],
  [#ruby[たたか][戦]う], [戦う], [#ruby[ひつよう][必要]な#ruby[もの][物]のために#ruby[たたか][戦]う。],
  [#ruby[えら][選]ぶ], [選ぶ], [#ruby[た][食]べ#ruby[もの][物]を#ruby[えら][選]ぶ。],
  [#ruby[さが][探]す], [探す], [#ruby[みち][道]を#ruby[さが][探]す。],
  [#ruby[か][買]う], [買う], [#ruby[た][食]べ#ruby[もの][物]を#ruby[か][買]う。],
  [#ruby[い][言]う], [言う、話す], [#ruby[なまえ][名前]を#ruby[い][言]う。],
  [#ruby[か][書]く], [書く], [#ruby[ほん][本]に#ruby[か][書]く。],
  [#ruby[よ][読]む], [読む], [#ruby[ほん][本]を#ruby[よ][読]む。],
  [#ruby[おし][教]える], [教える], [#ruby[ひと][人]に#ruby[ことば][言葉]を#ruby[おし][教]える。],
  [#ruby[かんが][考]える], [考える], [#ruby[こと][事]を#ruby[かんが][考]える。],
  [#ruby[わら][笑]う], [笑う], [#ruby[ひと][人]と#ruby[わら][笑]う。],
  [#ruby[な][泣]く], [泣く], [#ruby[こども][子供]が#ruby[な][泣]く。],
  [できる], [できる], [これは#ruby[ひと][一]りでできる。],
  [#ruby[わ][分]かる], [分かる、理解する], [この#ruby[ことば][言葉]が#ruby[わ][分]からない。],
  [#ruby[はな][話]す], [話す、会話する], [#ruby[ひと][人]と#ruby[はな][話]すのが#ruby[す][好]きだ。],
  [#ruby[ある][歩]く], [歩く、徒歩], [#ruby[いえ][家]まで#ruby[ある][歩]く。],
  [#ruby[と][飛]ぶ], [飛ぶ、飛翔する], [#ruby[とり][鳥]が#ruby[と][飛]ぶ。],
)]

== どんな (性質)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[あつ][暑]い], [気温が高い], [#ruby[そと][外]は#ruby[あつ][暑]い。],
  [#ruby[さむ][寒]い], [気温が低い], [#ruby[そと][外]は#ruby[さむ][寒]い。],
  [#ruby[よ][良]い], [良い], [この#ruby[ほん][本]は#ruby[よ][良]い。],
  [#ruby[わる][悪]い], [悪い], [#ruby[そら][空]が#ruby[わる][悪]い。],
  [#ruby[おお][大]きい], [大きい], [あの#ruby[やま][山]は#ruby[おお][大]きい。],
  [#ruby[なが][長]い], [長い], [この#ruby[みち][道]は#ruby[なが][長]い。],
  [#ruby[たか][高]い], [高い], [この#ruby[おお][大]きい#ruby[いえ][家]は#ruby[たか][高]い。],
  [#ruby[おも][重]い], [重い], [この#ruby[いし][石]は#ruby[おも][重]い。],
  [#ruby[へん][変]], [変な、不思議な], [この#ruby[おと][音]は#ruby[へん][変]だ。],
  [きれい], [綺麗な、清潔な], [この#ruby[やま][山]はきれいだ。],
  [#ruby[つよ][強]い], [強い], [あの#ruby[ひと][人]は#ruby[つよ][強]い。],
  [#ruby[たの][楽]しい], [楽しい], [#ruby[ひと][人]と#ruby[あ][会]うのは#ruby[たの][楽]しい。],
  [#ruby[ちが][違]う], [違う、異なる], [この#ruby[いろ][色]は#ruby[ちが][違]う。],
  [#ruby[ほか][他]], [他の、別の], [#ruby[ほか][他]の#ruby[ひと][人]に#ruby[き][聞]く。],
  [#ruby[あたら][新]しい], [新しい], [#ruby[あたら][新]しい#ruby[ほん][本]を#ruby[か][買]う。],
  [#ruby[はや][速]い], [速い], [あの#ruby[どうぶつ][動物]は#ruby[はや][速]い。],
  [#ruby[おお][多]い], [多い、たくさん], [ここは#ruby[ひと][人]が#ruby[おお][多]い。],
  [#ruby[ほんとう][本当]], [本当の、真実の], [#ruby[ほんとう][本当]か？],
  [#ruby[ちい][小]さい], [小さい], [この#ruby[いし][石]は#ruby[ちい][小]さい。],
  [#ruby[おな][同]じ], [同じ、同一], [#ruby[わたし][私]とあなたは#ruby[おな][同]じ#ruby[もの][物]を#ruby[た][食]べた。],
)]

== #ruby[いろ][色] (色)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[いろ][色]], [色], [この#ruby[そら][空]の#ruby[いろ][色]はきれいだ。],
  [#ruby[しろ][白]], [白], [この#ruby[いし][石]は#ruby[しろ][白]い。],
  [#ruby[くろ][黒]], [黒], [その#ruby[そら][空]は#ruby[くろ][黒]い。],
  [#ruby[あか][赤]], [赤], [#ruby[ひ][火]は#ruby[あか][赤]い。],
  [#ruby[あお][青]], [青], [#ruby[そら][空]は#ruby[あお][青]い。],
  [#ruby[きいろ][黄色]], [黄色], [この#ruby[ひかり][光]は#ruby[きいろ][黄色]い。],
  [#ruby[みどり][緑]], [緑], [#ruby[くさ][草]は#ruby[みどり][緑]だ。],
  [#ruby[あか][明]るい], [明るい], [#ruby[そと][外]は#ruby[あか][明]るい。],
)]

== #ruby[こころ][心]と#ruby[かん][感]じ (心と感覚)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[し][知]る], [知る、理解する], [その#ruby[なまえ][名前]を#ruby[し][知]っている。],
  [#ruby[かん][感]じる], [感じる], [#ruby[かぜ][風]を#ruby[かん][感]じる。],
  [#ruby[み][見]る], [見る], [#ruby[そら][空]を#ruby[み][見]る。],
  [#ruby[き][聞]く], [聞く], [#ruby[おと][音]を#ruby[き][聞]く。],
  [#ruby[おも][思]う], [思う], [それは#ruby[よ][良]いと#ruby[おも][思]う。],
  [#ruby[ほ][欲]しい], [欲しい], [#ruby[あたら][新]しい#ruby[ほん][本]が#ruby[ほ][欲]しい。],
  [#ruby[ひつよう][必要]], [必要な], [#ruby[みず][水]は#ruby[ひつよう][必要]だ。],
  [#ruby[す][好]き], [好き], [#ruby[どうぶつ][動物]が#ruby[す][好]きだ。],
  [#ruby[こわ][怖]い], [怖い], [その#ruby[はなし][話]は#ruby[こわ][怖]い。],
  [#ruby[かな][悲]しい], [悲しい], [その#ruby[はなし][話]は#ruby[かな][悲]しい。],
  [#ruby[おこ][怒]る], [怒る], [#ruby[ちち][父]が#ruby[おこ][怒]る。],
)]

== #ruby[い][言]う#ruby[こと][事] (伝達)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[ことば][言葉]], [言葉], [この#ruby[ことば][言葉]が#ruby[わ][分]からない。],
  [#ruby[なまえ][名前]], [名前], [あなたの#ruby[なまえ][名前]を#ruby[おし][教]えてください。],
  [#ruby[おと][音]], [音], [#ruby[へん][変]な#ruby[おと][音]を#ruby[き][聞]く。],
)]

== #ruby[とき][時] (時間)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[とき][時]], [時、時間], [#ruby[た][食]べる#ruby[とき][時]、#ruby[て][手]を#ruby[つか][使]う。],
  [#ruby[いま][今]], [今], [#ruby[いま][今]、#ruby[た][食]べる。],
  [#ruby[まえ][前]], [前、以前], [#ruby[た][食]べる#ruby[まえ][前]に#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[あと][後]], [後、後で], [#ruby[た][食]べた#ruby[あと][後]、#ruby[いえ][家]に#ruby[い][行]く。],
  [#ruby[まい][毎]], [毎〜、いつも], [#ruby[まい][毎]#ruby[にち][日]#ruby[みず][水]を#ruby[の][飲]む。],
  [#ruby[にち][日]], [日], [#ruby[よ][良]い#ruby[にち][日]だ。],
  [#ruby[とし][年]], [年], [#ruby[あたら][新]しい#ruby[とし][年]が#ruby[はじ][始]まる。],
  [#ruby[よる][夜]], [夜], [#ruby[よる][夜]、#ruby[そら][空]に#ruby[つき][月]が#ruby[み][見]える。],
)]

== #ruby[ところ][所]と#ruby[うえ][上]#ruby[した][下] (場所と空間)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[くに][国]], [国], [この#ruby[くに][国]は#ruby[おお][大]きい。],
  [#ruby[ところ][所]], [場所], [いい#ruby[ところ][所]を#ruby[さが][探]す。],
  [#ruby[いえ][家]], [家、住まい], [#ruby[わたし][私]の#ruby[いえ][家]は#ruby[おお][大]きい。],
  [#ruby[みち][道]], [道、通り道], [#ruby[みち][道]を#ruby[い][行]く。],
  [#ruby[なか][中]], [中、内側], [#ruby[いえ][家]の#ruby[なか][中]に#ruby[もの][物]がある。],
  [#ruby[そと][外]], [外、外側], [#ruby[そと][外]に#ruby[い][行]く。],
  [#ruby[うえ][上]], [上], [#ruby[やま][山]の#ruby[うえ][上]に#ruby[ひと][人]がいる。],
  [#ruby[した][下]], [下], [#ruby[き][木]の#ruby[した][下]に#ruby[なに][何]かある。],
  [#ruby[みぎ][右]], [右], [#ruby[みぎ][右]に#ruby[おお][大]きい#ruby[いえ][家]がある。],
  [#ruby[ひだり][左]], [左], [#ruby[ひだり][左]に#ruby[やま][山]がある。],
  [#ruby[ちか][近]い], [近い], [#ruby[やま][山]は#ruby[いえ][家]から#ruby[ちか][近]い。],
  [#ruby[とお][遠]い], [遠い], [#ruby[うみ][海]は#ruby[とお][遠]い。],
  [ここ], [ここ], [ここに#ruby[すわ][座]ってください。],
  [そこ], [そこ、あそこ], [そこに#ruby[なに][何]がある？],
  [どこ], [どこ], [#ruby[うみ][海]はどこ？],
)]

== #ruby[ひと][一]つにする#ruby[こと][言]#ruby[ば][葉] (接続詞)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[ぜんぶ][全部]], [全部、すべて], [#ruby[ぜんぶ][全部]#ruby[た][食]べた。],
  [と], [と、そして], [#ruby[みず][水]と#ruby[た][食]べ#ruby[もの][物]をください。],
  [または], [または、か], [#ruby[みず][水]または#ruby[の][飲]み#ruby[もの][物]をください。],
  [でも], [でも、しかし], [#ruby[ちい][小]さい。でも#ruby[つよ][強]い。],
  [から], [から], [#ruby[さむ][寒]いから、#ruby[いえ][家]にいる。],
  [まで], [まで], [#ruby[よる][夜]まで#ruby[ま][待]つ。],
  [なら], [もし], [#ruby[とき][時]があるなら、#ruby[そと][外]に#ruby[い][行]く。],
  [だけ], [だけ], [#ruby[みず][水]だけ#ruby[の][飲]む。],
  [も], [も], [#ruby[わたし][私]も#ruby[い][行]く。],
  [もっと], [もっと], [もっと#ruby[た][食]べたい。],
  [もう], [もう], [もう#ruby[た][食]べた。],
  [まだ], [まだ], [まだ#ruby[た][食]べていない。],
  [とても], [とても], [この#ruby[た][食]べ#ruby[もの][物]はとても#ruby[よ][良]い。],
  [#ruby[すこ][少]し], [少し], [#ruby[すこ][少]し#ruby[ま][待]ってください。],
  [#ruby[かた][方]], [方法、やり方], [#ruby[た][食]べ#ruby[かた][方]を#ruby[おし][教]えてください。],
  [たぶん], [多分、おそらく], [たぶん#ruby[あめ][雨]が#ruby[く][来]る。],
)]

== はいといいえ (応答と疑問)

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [すみません], [すみません], [すみません、#ruby[みち][道]を#ruby[おし][教]えてください。],
  [ありがとう], [ありがとう], [ありがとう。#ruby[たす][助]かった。],
  [ください], [ください], [#ruby[みず][水]をください。],
  [はい], [はい], [はい、#ruby[わ][分]かった。],
  [ない], [ない], [お#ruby[かね][金]がない。],
  [どう], [どう、どのように], [これはどう#ruby[つか][使]う？],
  [いいえ], [いいえ], [いいえ、#ruby[ほ][欲]しくない。],
  [いつ], [いつ], [いつ#ruby[く][来]る？],
  [なぜ], [なぜ], [なぜ#ruby[い][行]かない？],
  [これ], [これ], [これは#ruby[なん][何]だ？],
  [それ], [あれ、それ], [それをください。],
  [この], [この], [この#ruby[ほん][本]は#ruby[よ][良]い。],
  [その], [あの、その], [その#ruby[た][食]べ#ruby[もの][物]は#ruby[なん][何]だ？],
)]

== いくつ (数)

#note-block[一部の数字には二通りの読み方がある。4=し/よん、7=しち/なな、9=く/きゅう。日常会話ではよん・なな・きゅうが無難。大きい数は掛け算で作る: 二十=20、三百=300。]

#rounded-table[#table(
  columns: (1fr, 1fr, 1.5fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*][*例文*],
  [#ruby[いち][一]], [一], [#ruby[ひと][一]りで#ruby[やま][山]に#ruby[い][行]った。],
  [#ruby[に][二]], [二], [#ruby[て][手]は#ruby[ふた][二]つある。],
  [#ruby[さん][三]], [三], [#ruby[さん][三]#ruby[にん][人]の#ruby[こども][子供]がいる。],
  [#ruby[よん][四]], [四], [#ruby[いぬ][犬]の#ruby[あし][足]は#ruby[よん][四]つだ。],
  [#ruby[ご][五]], [五], [#ruby[ご][五]#ruby[にん][人]の#ruby[ひと][人]が#ruby[き][来]た。],
  [#ruby[ろく][六]], [六], [#ruby[ろく][六]#ruby[がつ][月]は#ruby[あめ][雨]が#ruby[おお][多]い。],
  [#ruby[なな][七]], [七], [#ruby[なな][七]つの#ruby[いろ][色]が#ruby[そら][空]に#ruby[で][出]た。],
  [#ruby[はち][八]], [八], [#ruby[はち][八]#ruby[がつ][月]はとても#ruby[あつ][暑]い。],
  [#ruby[きゅう][九]], [九], [#ruby[く][九]#ruby[じ][時]に#ruby[ね][寝]る。],
  [#ruby[じゅう][十]], [十], [#ruby[じゅう][十]#ruby[にん][人]で#ruby[た][食]べた。],
  [#ruby[ひゃく][百]], [百], [#ruby[みず][水]は#ruby[ひゃく][百]#ruby[ご][五]#ruby[じゅう][十]だ。],
)]

#pagebreak(weak: true)

= 文法

== #ruby[こと][言]#ruby[ば][葉]の#ruby[かたち][形] (文の構造)

#grammar-card[#ruby[こと][言]#ruby[ば][葉]の#ruby[く][来]る#ruby[ところ][所]][場を設定してから動作。[誰が] [いつ] [どこで] [何を] → [動詞]。動詞は常に最後。助詞が各語の役割を示す。映画のように、まず場面を作り、それから動く。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ほん][本]を #ruby[よ][読]む。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ひと][人]だ。]]

#grammar-card[#ruby[い][言]わない#ruby[こと][事]][既知の情報は省略する。主語・目的語など、文脈から分かるものは言わなくてよい。これが日本語の基本。][#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[なに][何]を #ruby[の][飲]む？」「#ruby[みず][水]。」]]

#grammar-card[ある / いる][存在がそのまま所有を表す。「have」に当たる動詞は不要。生き物には「いる」、それ以外は「ある」を使う。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[どうぶつ][動物]がいる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ほん][本]がある。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[ほん][本]がある。]]

== する#ruby[こと][事]の#ruby[かたち][形] (動詞の活用)

#grammar-card[#ruby[よっ][四]つの#ruby[かた][方]][動詞に四つのフィルター: る（現在・未来）/ た（完了）/ ない（否定）/ なかった（過去否定）。写真のフィルターのように動詞はそのまま、周りを変える。すべてこの四つの上に構築する。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べる → #ruby[た][食]べた → #ruby[た][食]べない → #ruby[た][食]べなかった]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]く → #ruby[い][行]った → #ruby[い][行]かない → #ruby[い][行]かなかった]
#block(inset: (top: 0.2em, bottom: 0.2em))[する → した → しない → しなかった]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[く][来]る → #ruby[き][来]た → #ruby[こ][来]ない → #ruby[こ][来]なかった]]

#grammar-card[ての#ruby[かた][方]][動作を実際の順に連結する。「to」「by」「with」は不要。動詞を順に並べるだけ。書いて読んで寝た。時制は文末のみ。活用: く→いて、む→んで、つ→って、る→て。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]く → #ruby[か][書]いて]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[の][飲]む → #ruby[の][飲]んで]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ま][待]つ → #ruby[ま][待]って]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べる → #ruby[た][食]べて]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]いて #ruby[よ][読]んで #ruby[ね][寝]た。]]

#grammar-card[て + もっと][て形にさらに付け足す。依頼（+ください）、進行（+いる）、許可（+もいい）、禁止（+はいけない）。同じて形、違う語尾。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ま][待]ってください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いま][今] #ruby[よ][読]んでいる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[すわ][座]ってもいい？]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[はい][入]ってはいけない。]]

#grammar-card[られる / える][可能を表す。一段動詞: る を取って られる を付ける。五段動詞: え段 + る。する → できる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][書]く → #ruby[か][書]ける]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[み][見]る → #ruby[み][見]られる]
#block(inset: (top: 0.2em, bottom: 0.2em))[する → できる]]

#grammar-card[ないでください][否定の依頼。動詞のない形 + で + ください。入らないでください = 入らないようにお願いする。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[はい][入]らないでください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[て][手]で#ruby[も][持]たないでください。]]

== ますとです (丁寧形)

#grammar-card[ます / です][よく知らない人と話す時はます形を使う。動詞の連用形 + ます。だ → です。常に規則的: ます / ました / ません / ませんでした。普通形より簡単 - 音便変化なし。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]みます。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]に#ruby[い][行]きました。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さかな][魚]を#ruby[た][食]べません。]
#block(inset: (top: 0.2em, bottom: 0.2em))[この#ruby[ほん][本]は#ruby[よ][良]いです。]]

#grammar-card[いつますを#ruby[つか][使]うか][ます/です形は知らない人・店員・医師・先生・同僚に使う。普通形は親しい友人・家族に使う。ます形を使わないと幼稚・失礼に聞こえる。です はい形容詞にも付く: 寒い → 寒いです。だ → です（名詞・な形容詞）。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[か][買]う#ruby[ところ][所]で: これをください。いくらですか。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[す][好]きな#ruby[ひと][人]に: これ、いくら？]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]いです。]]

== #ruby[ひと][一]つにする#ruby[こと][言]#ruby[ば][葉] (助詞)

#grammar-card[は (wa)][場を設定する:「〜については...」。文の枠の[誰]の位置を埋める。この文が何についてかを示す。][#block(inset: (top: 0.2em, bottom: 0.2em))[この #ruby[ほん][本]は #ruby[よ][良]い。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]は #ruby[め][目]が #ruby[よ][良]い。]]

#grammar-card[が (ga)][動作の主体を示す。誰がそれをするか。新しい情報を表す。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]が #ruby[く][来]る？]]

#grammar-card[を (o)][文の枠の[何]の位置を埋める。動作の対象を示す。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を #ruby[の][飲]む。]]

#grammar-card[に (ni)][文の枠の[いつ]と[どこ]の位置を埋める。行き先・時間・存在の場所を表す。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]に #ruby[い][行]く。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よる][夜]に #ruby[ね][寝]る。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]に #ruby[どうぶつ][動物]がいる。]]

#grammar-card[で (de)][動作の場所・手段を表す。「に」は存在の場所、「で」は動作の場所。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]で #ruby[よ][読]む。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[て][手]で #ruby[か][書]く。]]

#grammar-card[の (no)][名詞と名詞をつなぐ。動詞を名詞化する用法もある（第5章参照）。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]の #ruby[ほん][本]。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]の #ruby[うえ][上]。]]

#grammar-card[と (to)][並列・共同・引用を表す。発言・思考・音・名前など、あらゆるものを引用できる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]と #ruby[ほん][本]を #ruby[か][買]った。]
#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[い][行]く」と #ruby[い][言]った。]]

#grammar-card[も (mo)][「〜も」で同様であることを示す。は・が・を の代わりに使う。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ちち][父]は #ruby[ほん][本]を #ruby[よ][読]む。#ruby[はは][母]も #ruby[よ][読]む。]]

#grammar-card[から / まで][起点（から）と終点（まで）を表す。「から」は理由も表せる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[いえ][家]から #ruby[やま][山]まで #ruby[い][行]く。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よる][夜]まで #ruby[ま][待]つ。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]いから、#ruby[いえ][家]にいる。]]

#grammar-card[より][「Xより」で「Xよりも」の意味。この助詞一つであらゆる比較を表せる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]より #ruby[おお][大]きい。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]より #ruby[た][食]べ#ruby[もの][物]が #ruby[す][好]きだ。]]

== どんな (修飾)

#grammar-card[い の#ruby[こと][言]#ruby[ば][葉]][動詞と同様に活用する。「寒い」だけで文が成立する。活用: くない・かった・くて。「だ」は不要。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]い。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]くない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]かった。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]くて #ruby[かな][悲]しい。]]

#grammar-card[な の#ruby[こと][言]#ruby[ば][葉]][名詞の前に「な」を付ける。否定は「じゃない」、過去は「だった」。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]な #ruby[もの][物]。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]じゃない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]だった。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]で #ruby[よ][良]い。]]

#grammar-card[〜くなる / 〜になる][状態の変化を表す。あらゆる変化をこの一つの型で表現できる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あつ][暑]い → #ruby[あつ][暑]くなる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要] → #ruby[ひつよう][必要]になる。]]

#grammar-card[する#ruby[こと][事] + #ruby[もの][物]][動詞や文を名詞の前に置いて修飾する。語彙を作り出す力の源。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[やま][山]で #ruby[うご][動]く #ruby[こども][子供]。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[わたし][私]が #ruby[か][買]った #ruby[もの][物]。]]

== #ruby[もの][物]にする (名詞化)

#grammar-card[の][くだけた名詞化。「食べるのが好き」。疑問文にも使う:「何しているの？」][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べるのが #ruby[す][好]きだ。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なに][何]しているの？]]

#grammar-card[こと][動作を抽象的な概念にする。「走ること」は走るという考え。「飲むもの」は物理的な物。「こと」は抽象、「もの」は具体。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[うご][動]くことは#ruby[よ][良]い。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]くことができる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]なことを#ruby[い][言]う。]]

#grammar-card[もの][触れたり指せたりする物理的なもの。「飲むもの」= 飲める何か。「こと」は抽象的な概念、「もの」は具体的な物。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[の][飲]むもの。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][読]むもの。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ひつよう][必要]なものを#ruby[も][持]っている。]]

#grammar-card[#ruby[かた][方]][やり方を表す。動詞の連用形に付ける。食べ方 = 食べる方法。使い方 = 使う方法。こと（概念）+ もの（物）+ 方（方法）で何でも表現できる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べ#ruby[かた][方]を#ruby[おし][教]えてください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[この#ruby[こと][言]#ruby[ば][葉]の#ruby[つか][使]い#ruby[かた][方]が#ruby[し][知]りたい。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[き][聞]き#ruby[かた][方]が#ruby[ひつよう][必要]だ。]]

== #ruby[おも][思]うと「もし」 (意志と条件)

#grammar-card[たい / #ruby[ほ][欲]しい][動作の希望（動詞の連用形 + たい）。物の希望（欲しい）。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]きたい。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あたら][新]しい #ruby[いえ][家]が #ruby[ほ][欲]しい。]]

#grammar-card[たら / なら / ければ][たら = もしその事態が起こったら（動詞のた形 + ら）。なら = もしそうであるなら。ければ = い形容詞の条件形（い → ければ）。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[あめ][雨]が #ruby[き][来]たら、#ruby[い][行]かない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[とき][時]があるなら、#ruby[き][来]てください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さむ][寒]ければ、#ruby[いえ][家]にいる。]]

#grammar-card[と#ruby[おも][思]う / と#ruby[い][言]う][「と」で何でも引用できる。思考・発言・音。「という」は「〜と呼ばれる」の意味。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][良]いと #ruby[おも][思]う。]
#block(inset: (top: 0.2em, bottom: 0.2em))[「#ruby[い][行]く」と #ruby[い][言]った。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[おお][大]きい#ruby[やま][山]という #ruby[ところ][所]]]

#grammar-card[ために][目的と受益者を表す。動詞+ために、または名詞+のために。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[し][知]るために #ruby[よ][読]む。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[こども][子供]のために。]]

#grammar-card[う / よう / ましょう][一緒にすることを提案する。行こう / 行きましょう = 一緒に行く。食べよう / 食べましょう = 一緒に食べる。動詞の連用形 + ましょう（丁寧）。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[た][食]べましょう。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[ふた][二]りで#ruby[い][行]きましょう。]]

#grammar-card[なくてはいけない / なきゃ][義務を表す。動詞のない形 → なくてはいけない（しなければならない）。話し言葉では「なきゃ」だけで十分。行かなきゃ = 行かなければならない。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]まなきゃ。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[まい][毎]#ruby[にち][日]#ruby[ある][歩]かなくてはいけない。]]

#grammar-card[ほうがいい][助言を表す。動詞のた形 + ほうがいい = した方がよい。動詞のない形 + ほうがいい = しない方がよい。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[みず][水]を#ruby[の][飲]んだほうがいい。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]かないほうがいい。]]

== #ruby[き][聞]き#ruby[かた][方] (疑問と終助詞)

#grammar-card[か / ね / よ][疑問（か）/ 同意の確認（ね）/ 主張（よ）。くだけた会話では「か」を省略して語尾を上げるだけのことも多い。][#block(inset: (top: 0.2em, bottom: 0.2em))[これは #ruby[みず][水]か？]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[よ][良]い #ruby[にち][日]だね。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[い][行]くよ。]]

#grammar-card[#ruby[なに][何]・#ruby[だれ][誰]・どこ・いつ・なぜ + も/でも][疑問詞は答えの位置に置く。+も（否定）= 何もない・誰もいない。+でも = 何でも・誰でも。疑問詞5つ + 助詞2つ = 20語の代名詞が作れる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なに][何]を #ruby[た][食]べる？→ #ruby[なに][何]も #ruby[た][食]べない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[なん][何]でも #ruby[つく][作]れる。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]もいない。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[だれ][誰]でもできる。]]

== いくつ (数と数え方)

#grammar-card[つ (いくつ)][物を数える時に「つ」を使う。読みがすべて変わる: 1=ひとつ 2=ふたつ 3=みっつ 4=よっつ 5=いつつ 6=むっつ 7=ななつ 8=やっつ 9=ここのつ。10=とお（つ なし!）。10より上は数字のみ。何にでも使える万能助数詞。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]を#ruby[みっ][三]つください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[さかな][魚]を#ruby[ふた][二]つと#ruby[たまご][卵]を#ruby[いつ][五]つください。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]を#ruby[やっ][八]つ#ruby[か][買]った。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[たまご][卵]が#ruby[とお][十]ある。#ruby[ぜんぶ][全部]#ruby[た][食]べた。]]

#grammar-card[いくつの#ruby[つく][作]り#ruby[かた][方]][数字を十・百の前に置く。二十 = 20。三百 = 300。連結: 三百五十二 = 352。パターン: [数字]百[数字]十[数字]。百の前で音変化: 300=さんびゃく、600=ろっぴゃく、800=はっぴゃく。コツ: まず値段から覚える。買い物のたびに数字が聞こえる。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[に][二]#ruby[じゅう][十]#ruby[にん][人]の#ruby[ひと][人]が#ruby[き][来]た。]
#block(inset: (top: 0.2em, bottom: 0.2em))[これは#ruby[さん][三]#ruby[びゃく][百]#ruby[ご][五]#ruby[じゅう][十]#ruby[に][二]です。]]

#grammar-card[いくつの#ruby[よ][読]み#ruby[かた][方]][読みが常に同じ8つ: いち(1) に(2) さん(3) ご(5) ろく(6) はち(8) じゅう(10) ひゃく(100)。二通りの読みがある3つだけ: し/よん(4) しち/なな(7) く/きゅう(9)。迷ったらよん・なな・きゅうを使う。日常会話ではこちらが一般的。し は死と紛らわしいのでよんが無難。][#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[し][四]#ruby[がつ][月]に#ruby[あめ][雨]が#ruby[く][来]る。#ruby[よ][四]#ruby[じ][時]に#ruby[あ][会]う。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[しち][七]#ruby[がつ][月]は#ruby[あつ][暑]い。#ruby[なな][七]つの#ruby[やま][山]が#ruby[み][見]える。]
#block(inset: (top: 0.2em, bottom: 0.2em))[#ruby[く][九]#ruby[がつ][月]から#ruby[さむ][寒]くなる。#ruby[きゅう][九]#ruby[じ][時]に#ruby[ね][寝]る。]
#block(inset: (top: 0.2em, bottom: 0.2em))[これは#ruby[さん][三]#ruby[びゃく][百]。それは#ruby[ろっ][六]#ruby[ぴゃく][百]。あれは#ruby[はっ][八]#ruby[ぴゃく][百]。]]

#pagebreak(weak: true)

= 造語

== よく#ruby[つか][使]う#ruby[こと][言]#ruby[ば][葉] (よく使う言葉)

#text(size: 9pt, fill: rgb("#666666"))[よく使う日本語を206の基本語だけで表現する。]

=== #ruby[ひと][人] (人)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[す][好]きな#ruby[ひと][人]], [友達],
  [#ruby[ちち][父]と#ruby[はは][母]と#ruby[こども][子供]], [家族],
  [#ruby[おし][教]える#ruby[ひと][人]], [先生],
  [#ruby[おし][教]えてもらう#ruby[ひと][人]], [生徒],
  [#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]], [医者],
  [#ruby[こころ][心]を#ruby[たす][助]ける#ruby[ひと][人]], [セラピスト],
  [#ruby[まも][守]る#ruby[ひと][人]], [警察],
  [#ruby[たたか][戦]う#ruby[ひと][人]], [兵士],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ひと][人]], [農家],
  [#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ひと][人]], [料理人],
  [#ruby[ほん][本]を#ruby[か][書]く#ruby[ひと][人]], [作家],
  [よく#ruby[し][知]る#ruby[ひと][人]], [専門家],
  [#ruby[うえ][上]の#ruby[ひと][人]], [上司],
  [#ruby[たす][助]ける#ruby[ひと][人]], [助手],
  [#ruby[もの][物]を#ruby[も][持]って#ruby[い][行]く#ruby[ひと][人]], [泥棒],
  [#ruby[いえ][家]が#ruby[ちか][近]い#ruby[ひと][人]], [隣人],
  [#ruby[ちち][父]の#ruby[ちち][父]], [祖父],
  [#ruby[はは][母]の#ruby[はは][母]], [祖母],
  [#ruby[あたら][新]しい#ruby[こども][子供]], [赤ちゃん],
  [#ruby[とし][年]が#ruby[おお][多]い#ruby[ひと][人]], [老人],
)]

=== #ruby[どうぶつ][動物] (動物)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [とても#ruby[ちい][小]さい#ruby[どうぶつ][動物]], [虫],
  [#ruby[ちい][小]さい#ruby[いえ][家]の#ruby[どうぶつ][動物]], [猫],
  [#ruby[はや][速]い#ruby[おお][大]きい#ruby[どうぶつ][動物]], [馬],
  [#ruby[なが][長]い#ruby[どうぶつ][動物]], [蛇],
  [#ruby[うみ][海]のとても#ruby[おお][大]きい#ruby[どうぶつ][動物]], [鯨],
  [#ruby[やま][山]の#ruby[つよ][強]い#ruby[どうぶつ][動物]], [熊],
  [#ruby[き][木]の#ruby[どうぶつ][動物]], [猿],
  [#ruby[みず][水]と#ruby[つち][土]の#ruby[どうぶつ][動物]], [蛙],
  [#ruby[よる][夜]の#ruby[どうぶつ][動物]], [狼],
  [#ruby[つよ][強]い#ruby[どうぶつ][動物]], [ライオン],
  [とても#ruby[おお][大]きい#ruby[どうぶつ][動物]], [象],
  [きれいな#ruby[ちい][小]さい#ruby[どうぶつ][動物]], [蝶],
)]

=== #ruby[そと][外]の#ruby[もの][物] (自然)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[そら][空]の#ruby[こと][事]], [天気],
  [#ruby[そら][空]の#ruby[しろ][白]], [雲],
  [#ruby[よる][夜]の#ruby[ひかり][光]], [星],
  [#ruby[つき][月]の#ruby[ひかり][光]], [月光],
  [#ruby[そら][空]の#ruby[ひ][火]], [稲妻],
  [#ruby[しろ][白]い#ruby[あめ][雨]], [雪],
  [#ruby[さむ][寒]い#ruby[みず][水]], [氷],
  [#ruby[しろ][白]い#ruby[かぜ][風]], [霧],
  [#ruby[つよ][強]い#ruby[かぜ][風]と#ruby[あめ][雨]], [嵐],
  [#ruby[あめ][雨]の#ruby[あと][後]の#ruby[いろ][色]], [虹],
  [#ruby[つち][土]が#ruby[うご][動]く#ruby[こと][事]], [地震],
  [#ruby[みず][水]が#ruby[おお][多]すぎる#ruby[こと][事]], [洪水],
  [#ruby[なが][長]い#ruby[みず][水]], [川],
  [#ruby[おお][大]きい#ruby[みず][水]], [湖],
  [#ruby[うみ][海]の#ruby[なか][中]の#ruby[つち][土]], [島],
  [#ruby[き][木]が#ruby[おお][多]い#ruby[ところ][所]], [森],
  [#ruby[みず][水]がない#ruby[あつ][暑]い#ruby[ところ][所]], [砂漠],
  [#ruby[ひ][火]の#ruby[やま][山]], [火山],
  [#ruby[みず][水]が#ruby[した][下]に#ruby[い][行]く#ruby[ところ][所]], [滝],
  [#ruby[たいよう][太陽]が#ruby[で][出]る#ruby[とき][時]], [日の出],
  [#ruby[たいよう][太陽]が#ruby[はい][入]る#ruby[とき][時]], [日の入り],
)]

=== #ruby[ところ][所] (場所)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[いえ][家]の#ruby[なか][中]], [部屋],
  [#ruby[おし][教]える#ruby[ところ][所]], [学校],
  [#ruby[か][買]う#ruby[ところ][所]], [店],
  [#ruby[た][食]べる#ruby[ところ][所]], [レストラン],
  [#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ところ][所]], [病院],
  [#ruby[ほん][本]が#ruby[おお][多]い#ruby[ところ][所]], [図書館],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]], [台所],
  [#ruby[くさ][草]がある#ruby[ところ][所]], [庭],
  [#ruby[そと][外]の#ruby[ところ][所]], [公園],
  [#ruby[ひと][人]が#ruby[おお][多]い#ruby[ところ][所]], [都市],
  [#ruby[みず][水]の#ruby[うえ][上]の#ruby[みち][道]], [橋],
  [#ruby[たか][高]い#ruby[ところ][所]], [塔],
  [#ruby[で][出]られない#ruby[ところ][所]], [刑務所],
  [#ruby[そら][空]に#ruby[い][行]く#ruby[ところ][所]], [空港],
)]

=== #ruby[もの][物] (物)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[つか][使]う#ruby[もの][物]], [道具],
  [#ruby[なか][中]に#ruby[い][入]れる#ruby[もの][物]], [箱],
  [#ruby[か][書]く#ruby[もの][物]], [紙],
  [#ruby[き][切]る#ruby[もの][物]], [ナイフ],
  [#ruby[あ][開]ける#ruby[もの][物]], [鍵],
  [#ruby[もの][物]を#ruby[も][持]つ#ruby[もの][物]], [鞄],
  [#ruby[あめ][雨]の#ruby[もの][物]], [傘],
  [#ruby[ね][寝]る#ruby[ところ][所]], [ベッド],
  [#ruby[すわ][座]る#ruby[もの][物]], [椅子],
  [#ruby[はい][入]る#ruby[ところ][所]], [ドア],
  [#ruby[そと][外]を#ruby[み][見]る#ruby[ところ][所]], [窓],
  [#ruby[とき][時]を#ruby[み][見]る#ruby[もの][物]], [時計],
  [#ruby[わたし][私]を#ruby[み][見]る#ruby[もの][物]], [鏡],
  [#ruby[ひ][火]の#ruby[ひかり][光]], [蝋燭],
  [#ruby[なが][長]い#ruby[つよ][強]い#ruby[もの][物]], [縄],
  [#ruby[かんが][考]える#ruby[もの][物]], [コンピューター],
  [#ruby[おと][音]で#ruby[い][言]う#ruby[もの][物]], [電話],
  [#ruby[はや][速]く#ruby[い][行]く#ruby[もの][物]], [車],
  [#ruby[みず][水]の#ruby[うえ][上]の#ruby[もの][物]], [船],
  [#ruby[そら][空]を#ruby[い][行]く#ruby[もの][物]], [飛行機],
)]

=== #ruby[た][食]べ#ruby[もの][物]と#ruby[からだ][体] (食べ物と体)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[き][木]の#ruby[た][食]べ#ruby[もの][物]], [果物],
  [#ruby[くさ][草]の#ruby[た][食]べ#ruby[もの][物]], [野菜],
  [#ruby[しろ][白]い#ruby[どうぶつ][動物]の#ruby[みず][水]], [牛乳],
  [#ruby[からだ][体]を#ruby[よ][良]くする#ruby[もの][物]], [薬],
  [#ruby[からだ][体]を#ruby[わる][悪]くする#ruby[もの][物]], [毒],
  [#ruby[め][目]と#ruby[くち][口]がある#ruby[ところ][所]], [顔],
  [#ruby[からだ][体]の#ruby[なか][中]の#ruby[あか][赤]い#ruby[みず][水]], [血],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[こと][事]], [病気],
  [#ruby[からだ][体]が#ruby[あつ][暑]い], [熱],
  [#ruby[わる][悪]い#ruby[かん][感]じ], [痛み],
  [#ruby[ね][寝]る#ruby[とき][時]に#ruby[み][見]る#ruby[こと][事]], [夢],
  [#ruby[た][食]べ#ruby[もの][物]が#ruby[ほ][欲]しい], [空腹],
  [#ruby[からだ][体]が#ruby[おも][重]い], [疲労],
)]

=== #ruby[とき][時] (時間)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[まえ][前]の#ruby[にち][日]], [昨日],
  [#ruby[あと][後]の#ruby[にち][日]], [明日],
  [#ruby[にち][日]の#ruby[なか][中]], [正午],
  [#ruby[よる][夜]の#ruby[なか][中]], [真夜中],
  [#ruby[いま][今]の#ruby[よる][夜]], [今夜],
  [#ruby[あつ][暑]くなる#ruby[とき][時]], [春],
  [#ruby[あつ][暑]い#ruby[とき][時]], [夏],
  [#ruby[さむ][寒]くなる#ruby[とき][時]], [秋],
  [#ruby[さむ][寒]い#ruby[とき][時]], [冬],
  [#ruby[お][終]わらない#ruby[とき][時]], [永遠],
  [とても#ruby[まえ][前]の#ruby[とき][時]], [古代],
  [#ruby[あと][後]の#ruby[とき][時]], [未来],
  [する#ruby[こと][事]がない#ruby[にち][日]], [休日],
)]

=== どんな - 「ない」で#ruby[か][変]わる (性質（反対で作る）)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[なが][長]くない], [短い],
  [#ruby[たか][高]くない], [低い],
  [#ruby[おも][重]くない], [軽い],
  [#ruby[つよ][強]くない], [弱い],
  [#ruby[はや][速]くない], [遅い],
  [#ruby[あたら][新]しくない], [古い],
  [きれいじゃない], [汚い],
  [#ruby[あか][明]るくない], [暗い],
  [#ruby[おと][音]がない], [静か],
  [#ruby[よ][良]くない], [悪い],
  [#ruby[ひつよう][必要]じゃない], [不要],
  [できない], [不可能],
  [#ruby[し][知]らない], [未知],
  [#ruby[み][見]えない], [見えない],
  [#ruby[なか][中]に#ruby[なに][何]もない], [空っぽ],
  [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こらない], [安全],
  [#ruby[たの][楽]しくない], [退屈],
)]

=== する#ruby[こと][事] (動作)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[はや][速]く#ruby[あし][足]で#ruby[うご][動]く], [走る],
  [#ruby[みず][水]の#ruby[なか][中]を#ruby[うご][動]く], [泳ぐ],
  [#ruby[うえ][上]に#ruby[い][行]く], [登る],
  [#ruby[はや][速]く#ruby[うえ][上]に#ruby[うご][動]く], [跳ぶ],
  [#ruby[した][下]に#ruby[い][行]く], [落ちる],
  [#ruby[いえ][家]に#ruby[い][行]く], [帰る],
  [#ruby[なに][何]もしない], [休む],
  [#ruby[たの][楽]しい#ruby[こと][事]をする], [遊ぶ],
  [#ruby[あたら][新]しく#ruby[し][知]る], [学ぶ],
  [#ruby[し][知]らなくなる], [忘れる],
  [#ruby[み][見]えない#ruby[ところ][所]に#ruby[い][行]く], [隠れる],
  [#ruby[おと][音]を#ruby[つく][作]る], [歌う],
  [#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る], [料理する],
  [#ruby[ひと][人]の#ruby[もの][物]を#ruby[も][持]って#ruby[い][行]く], [盗む],
  [#ruby[みず][水]できれいにする], [洗う],
  [#ruby[わる][悪]くなった#ruby[もの][物]を#ruby[よ][良]くする], [修理する],
  [#ruby[くさ][草]を#ruby[つち][土]に#ruby[い][入]れる], [植える],
  [#ruby[いろ][色]で#ruby[もの][物]を#ruby[つく][作]る], [描く],
)]

=== #ruby[こころ][心]と#ruby[かんが][考]え (抽象)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[い][生]きる#ruby[こと][事]], [命],
  [#ruby[し][死]ぬ#ruby[こと][事]], [死],
  [#ruby[こころ][心]がとても#ruby[す][好]きな#ruby[こと][事]], [愛],
  [#ruby[おこ][怒]る#ruby[こと][事]], [怒り],
  [#ruby[こわ][怖]いと#ruby[かん][感]じる#ruby[こと][事]], [恐怖],
  [#ruby[よ][良]い#ruby[こと][事]を#ruby[ま][待]つ#ruby[こと][事]], [希望],
  [#ruby[たたか][戦]わない#ruby[こと][事]], [平和],
  [#ruby[くに][国]と#ruby[くに][国]が#ruby[たたか][戦]う#ruby[こと][事]], [戦争],
  [#ruby[す][好]きにできる#ruby[こと][事]], [自由],
  [#ruby[ほんとう][本当]の#ruby[こと][事]], [真実],
  [#ruby[ほんとう][本当]じゃない#ruby[こと][事]], [嘘],
  [#ruby[あたら][新]しい#ruby[かんが][考]え], [アイデア],
  [#ruby[よ][良]い#ruby[こと][事]が#ruby[お][起]こる#ruby[こと][事]], [幸運],
  [#ruby[ほか][他]の#ruby[ひと][人]が#ruby[し][知]らない#ruby[こと][事]], [秘密],
  [きれいな#ruby[おと][音]], [音楽],
  [#ruby[なが][長]い#ruby[ことば][言葉]], [物語],
  [#ruby[おと][音]と#ruby[ことば][言葉]], [歌],
  [#ruby[か][書]いた#ruby[ことば][言葉]], [手紙],
  [#ruby[あた][与]える#ruby[もの][物]], [贈り物],
  [#ruby[くに][国]の#ruby[ことば][言葉]], [言語],
  [#ruby[わる][悪]くした#ruby[こと][事]], [間違い],
  [#ruby[こころ][心]が#ruby[よ][良]い#ruby[こと][事]], [幸福],
  [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こる], [危険],
)]

=== なくなった#ruby[こと][言]#ruby[ば][葉] (除外語を熟語で)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[たいよう][太陽]が#ruby[で][出]る#ruby[とき][時]], [朝],
  [#ruby[いま][今]の#ruby[にち][日]], [今日],
  [する#ruby[こと][事]], [仕事],
  [#ruby[わる][悪]い#ruby[こと][事]], [問題],
  [#ruby[ことば][言葉]の#ruby[こと][事]], [意味],
  [とても#ruby[ひつよう][必要]], [重要],
  [#ruby[わる][悪]い#ruby[こと][事]が#ruby[お][起]こる], [危険],
  [#ruby[ぜんぶ][全部]の#ruby[ところ][所]], [世界],
  [#ruby[て][手]で#ruby[かん][感]じる], [触る],
)]

=== #ruby[まい][毎]#ruby[にち][日]の#ruby[こと][事] (日常生活)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[まい][毎]#ruby[にち][日]する#ruby[こと][事]], [生活],
  [#ruby[そと][外]にいる#ruby[ひと][人]と#ruby[ことば][言葉]を#ruby[つか][使]う#ruby[もの][物]], [電話],
  [#ruby[み][見]た#ruby[もの][物]を#ruby[か][書]いた#ruby[もの][物]], [写真],
  [#ruby[ひと][人]が#ruby[うご][動]く#ruby[こと][事]を#ruby[み][見]る#ruby[もの][物]], [映画],
  [きれいな#ruby[おと][音]], [音楽],
  [#ruby[まい][毎]#ruby[にち][日]#ruby[か][書]く#ruby[ほん][本]], [新聞],
  [#ruby[おお][多]い#ruby[こと][事]を#ruby[か][書]いた#ruby[ほん][本]], [雑誌],
  [#ruby[ひと][人]に#ruby[か][書]く#ruby[ことば][言葉]], [手紙],
  [#ruby[も][持]つ#ruby[もの][物]], [荷物],
  [#ruby[いえ][家]を#ruby[あ][開]ける#ruby[もの][物]], [鍵],
  [#ruby[いえ][家]の#ruby[なか][中]に#ruby[そと][外]の#ruby[ひかり][光]が#ruby[はい][入]る#ruby[ところ][所]], [窓],
  [#ruby[いえ][家]の#ruby[みぎ][右]と#ruby[ひだり][左]にある#ruby[もの][物]], [壁],
  [#ruby[いえ][家]の#ruby[なか][中]の#ruby[した][下]], [床],
  [#ruby[いえ][家]の#ruby[うえ][上]にある#ruby[もの][物]], [屋根],
  [#ruby[た][食]べる#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]], [台所],
  [#ruby[からだ][体]を#ruby[みず][水]できれいにする#ruby[ところ][所]], [風呂],
  [#ruby[いえ][家]の#ruby[なか][中]の#ruby[ところ][所]], [部屋],
  [#ruby[ところ][所]をきれいにする#ruby[こと][事]], [掃除],
  [#ruby[ふく][服]を#ruby[みず][水]できれいにする#ruby[こと][事]], [洗濯],
  [#ruby[た][食]べる#ruby[もの][物]を#ruby[つく][作]る#ruby[こと][事]], [料理],
  [#ruby[もの][物]を#ruby[か][買]う#ruby[こと][事]], [買い物],
  [#ruby[そと][外]を#ruby[うご][動]いていく#ruby[こと][事]], [散歩],
  [#ruby[まえ][前]にする#ruby[こと][事]], [支度],
  [#ruby[はじ][始]まる#ruby[まえ][前]にする#ruby[こと][事]], [準備],
  [#ruby[ひと][人]に「する」と#ruby[い][言]う#ruby[こと][事]], [約束],
  [#ruby[あと][後]にする#ruby[こと][事]], [予定],
  [#ruby[す][好]きでする#ruby[こと][事]], [趣味],
  [#ruby[よ][良]くなるために#ruby[なに][何]かを#ruby[おお][多]くする#ruby[こと][事]], [練習],
  [#ruby[し][知]るために#ruby[よ][読]んだり#ruby[き][聞]いたりする#ruby[こと][事]], [勉強],
  [#ruby[いえ][家]で#ruby[よ][読]んだり#ruby[か][書]いたりする#ruby[こと][事]], [宿題],
  [#ruby[し][知]りたい#ruby[こと][事]を#ruby[き][聞]く#ruby[ことば][言葉]], [質問],
  [#ruby[き][聞]かれた#ruby[こと][事]を#ruby[い][言]う#ruby[こと][事]], [答え],
  [#ruby[ひと][人]の#ruby[ことば][言葉]に#ruby[い][言]う#ruby[こと][事]], [返事],
  [#ruby[あ][会]った#ruby[とき][時]に#ruby[い][言]う#ruby[ことば][言葉]], [挨拶],
  [#ruby[ひと][人]に#ruby[し][知]らせる#ruby[こと][事]], [連絡],
  [#ruby[ひと][人]と#ruby[かんが][考]える#ruby[こと][事]], [相談],
  [#ruby[ひと][人]や#ruby[もの][物]の#ruby[こと][事]を#ruby[ほか][他]の#ruby[ひと][人]に#ruby[おし][教]える#ruby[こと][事]], [紹介],
  [#ruby[ひと][人]に「#ruby[き][来]てください」と#ruby[い][言]う#ruby[こと][事]], [招待],
  [#ruby[まえ][前]にした#ruby[こと][事]], [経験],
  [#ruby[あと][後]にする#ruby[こと][事]を#ruby[かんが][考]える#ruby[こと][事]], [計画],
  [よく#ruby[み][見]てほしい#ruby[こと][事]], [注意],
  [「これをください」と#ruby[い][言]う#ruby[こと][事]], [注文],
  [#ruby[もの][物]を#ruby[か][買]うお#ruby[おかね][金]], [値段],
  [お#ruby[おかね][金]が#ruby[すこ][少]しで#ruby[よ][良]くなる#ruby[こと][事]], [割引],
  [お#ruby[おかね][金]がない#ruby[こと][事]], [無料],
  [#ruby[へん][変]ではない], [普通],
  [#ruby[ほか][他]と#ruby[ちが][違]う#ruby[よ][良]い#ruby[こと][事]], [特別],
  [とても#ruby[ひつよう][必要]な], [大切],
  [だれでもできる], [簡単],
  [#ruby[おお][多]くの#ruby[こと][事]が#ruby[なか][中]にある], [複雑],
  [よく#ruby[つか][使]える#ruby[よ][良]い], [便利],
  [よく#ruby[つか][使]えない#ruby[わる][悪]い], [不便],
  [#ruby[ひと][人]に#ruby[よ][良]い#ruby[ことば][言葉]を#ruby[つか][使]う], [丁寧],
  [その#ruby[とき][時]に#ruby[よ][良]い], [適当],
  [したい#ruby[こと][事]ができる], [自由],
  [#ruby[ほか][他]の#ruby[くに][国]や#ruby[ところ][所]に#ruby[い][行]く#ruby[こと][事]], [旅行],
  [#ruby[そら][空]の#ruby[いま][今]の#ruby[こと][事]], [天気],
  [#ruby[とし][年]の#ruby[なか][中]の#ruby[とき][時]], [季節],
)]

=== する#ruby[こと][事]と#ruby[し][知]る#ruby[こと][事] (仕事と学校)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [する#ruby[こと][事]], [仕事],
  [する#ruby[こと][事]をする#ruby[ところ][所]], [会社],
  [する#ruby[こと][事]の#ruby[ところ][所]で#ruby[ひと][一]つだけ#ruby[うえ][上]の#ruby[ひと][人]], [社長],
  [する#ruby[こと][事]の#ruby[ところ][所]でする#ruby[こと][事]をする#ruby[ひと][人]], [社員],
  [する#ruby[こと][事]の#ruby[ところ][所]の#ruby[なか][中]の#ruby[おお][大]きい#ruby[ところ][所]の#ruby[うえ][上]の#ruby[ひと][人]], [部長],
  [する#ruby[こと][事]で#ruby[うえ][上]にいる#ruby[ひと][人]], [上司],
  [する#ruby[こと][事]で#ruby[した][下]にいる#ruby[ひと][人]], [部下],
  [する#ruby[こと][事]の#ruby[ところ][所]でする#ruby[こと][事]をする#ruby[ほか][他]の#ruby[ひと][人]], [同僚],
  [#ruby[く][来]る#ruby[ひと][人]], [客],
  [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[き][来]て#ruby[かんが][考]える#ruby[こと][事]], [会議],
  [する#ruby[こと][事]に#ruby[つか][使]う#ruby[か][書]いた#ruby[もの][物]], [資料],
  [した#ruby[こと][事]を#ruby[うえ][上]の#ruby[ひと][人]に#ruby[い][言]う#ruby[こと][事]], [報告],
  [#ruby[し][知]らない#ruby[ひと][人]に#ruby[ことば][言葉]で#ruby[おし][教]える#ruby[こと][事]], [説明],
  [#ruby[ひと][人]と#ruby[ちが][違]う#ruby[かんが][考]えを#ruby[い][言]う#ruby[こと][事]], [議論],
  [#ruby[ひと][人]と「する」と#ruby[か][書]いた#ruby[もの][物]], [契約],
  [する#ruby[こと][事]をしてもらうお#ruby[かね][金]], [給料],
  [#ruby[とき][時]が#ruby[お][終]わった#ruby[あと][後]もする#ruby[こと][事]], [残業],
  [する#ruby[こと][事]で#ruby[ほか][他]の#ruby[ところ][所]に#ruby[い][行]く#ruby[こと][事]], [出張],
  [する#ruby[こと][事]を#ruby[ちが][違]う#ruby[もの][物]に#ruby[か][変]える#ruby[こと][事]], [転職],
  [する#ruby[こと][事]を#ruby[お][終]わらせる#ruby[こと][事]], [退職],
  [はじめてする#ruby[こと][事]を#ruby[はじ][始]める#ruby[こと][事]], [就職],
  [する#ruby[こと][事]のために#ruby[あ][会]って#ruby[ことば][言葉]を#ruby[つか][使]う#ruby[こと][事]], [面接],
  [#ruby[し][知]っているかを#ruby[み][見]る#ruby[こと][事]], [試験],
  [#ruby[し][知]っている#ruby[こと][事]を#ruby[み][見]た#ruby[とき][時]の#ruby[よ][良]さ], [成績],
  [#ruby[おし][教]える#ruby[ところ][所]が#ruby[お][終]わる#ruby[こと][事]], [卒業],
  [#ruby[おし][教]える#ruby[ところ][所]に#ruby[はい][入]る#ruby[こと][事]], [入学],
  [#ruby[おし][教]える#ruby[ところ][所]で#ruby[おし][教]えてもらう#ruby[こと][事]], [授業],
  [#ruby[おし][教]える#ruby[ところ][所]], [教室],
  [#ruby[おし][教]える#ruby[ところ][所]], [学校],
  [#ruby[おお][大]きい#ruby[おし][教]える#ruby[ところ][所]], [大学],
  [まだ#ruby[し][知]らない#ruby[こと][事]を#ruby[さが][探]す#ruby[こと][事]], [研究],
  [#ruby[し][知]るために#ruby[もの][物]を#ruby[つか][使]ってみる#ruby[こと][事]], [実験],
  [#ruby[もの][物]を#ruby[つく][作]ったり#ruby[つか][使]ったりできる#ruby[こと][事]], [技術],
  [できる#ruby[こと][事]], [能力],
  [#ruby[よ][良]くなるためにとても#ruby[つよ][強]くする#ruby[こと][事]], [努力],
  [したい#ruby[こと][事]ができた#ruby[こと][事]], [成功],
  [したい#ruby[こと][事]ができなかった#ruby[こと][事]], [失敗],
  [した#ruby[あと][後]に#ruby[お][起]こる#ruby[こと][事]], [結果],
  [したい#ruby[こと][事]の#ruby[ところ][所]], [目標],
  [なぜかの#ruby[こと][事]], [理由],
  [どうするかの#ruby[こと][事]], [方法],
  [#ruby[よ][良]くない#ruby[こと][事]が#ruby[お][起]こっている], [問題],
  [#ruby[わる][悪]い#ruby[こと][事]を#ruby[よ][良]くする#ruby[こと][事]], [解決],
  [しなければならない#ruby[こと][事]], [責任],
  [しなければならない#ruby[こと][事]と、してはいけない#ruby[こと][事]], [規則],
  [「していい」と#ruby[い][言]う#ruby[こと][事]], [許可],
  [しなければならない#ruby[こと][事]], [課題],
  [#ruby[よ][良]いか#ruby[わる][悪]いかを#ruby[み][見]る#ruby[こと][事]], [評価],
  [#ruby[おお][多]くの#ruby[ひと][人]に#ruby[い][言]う#ruby[こと][事]], [発表],
  [#ruby[わたし][私]が#ruby[おも][思]う#ruby[こと][事]], [意見],
  [#ruby[おし][教]える#ruby[ひと][人]], [先生],
  [#ruby[おし][教]える#ruby[ところ][所]で#ruby[おし][教]えてもらう#ruby[こども][子供]], [生徒],
)]

=== いくつと#ruby[い][言]い#ruby[かた][方] (数と数え方)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[じゅう][十]が#ruby[じゅう][十]], [百],
  [#ruby[じゅう][十]の#ruby[じゅう][十]が#ruby[じゅう][十]], [千],
  [#ruby[じゅう][十]の#ruby[じゅう][十]の#ruby[じゅう][十]が#ruby[じゅう][十]], [万],
  [#ruby[ひと][一]つの#ruby[もの][物]を#ruby[ふた][二]つに#ruby[き][切]った#ruby[ひと][一]つ], [半分],
  [もう#ruby[ひと][一]つ#ruby[おお][多]い#ruby[こと][事]], [倍],
  [その#ruby[もの][物]の#ruby[なまえ][名前]になる#ruby[おお][多]さ], [番号],
  [いくつあるかを#ruby[い][言]う#ruby[もの][物]], [数],
  [#ruby[なに][何]かをした#ruby[おお][多]さ], [回],
  [#ruby[なに][何]かが#ruby[お][起]こった#ruby[おお][多]さ], [度],
  [#ruby[ほん][本]の#ruby[なか][中]のような#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [枚],
  [#ruby[なが][長]い#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [本],
  [#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [個],
  [#ruby[どうぶつ][動物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [匹],
  [#ruby[うご][動]く#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [台],
  [#ruby[の][飲]む#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [杯],
  [#ruby[ほん][本]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [冊],
  [#ruby[あし][足]に#ruby[き][着]る#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [足],
  [#ruby[からだ][体]に#ruby[き][着]る#ruby[もの][物]の#ruby[おお][多]さを#ruby[い][言]う#ruby[ことば][言葉]], [着],
  [#ruby[じゅう][十]の#ruby[なか][中]の#ruby[ひと][一]つ], [割],
  [#ruby[まえ][前]からいくつ#ruby[め][目]かを#ruby[い][言]う#ruby[ことば][言葉]], [番],
  [#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[まえ][前]], [第一],
  [#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[まえ][前]の#ruby[とき][時]], [最初],
  [#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[あと][後]の#ruby[とき][時]], [最後],
  [#ruby[ぜんぶ][全部]の#ruby[おお][多]さ], [合計],
  [#ruby[ぜんぶ][全部]を#ruby[ひと][一]つにした#ruby[おお][多]さ], [平均],
)]

=== #ruby[ひと][人]と#ruby[ひと][人] (人と関係)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[いえ][家]の#ruby[ひと][人]たち], [家族],
  [#ruby[おとこ][男]の#ruby[うえ][上]の#ruby[こども][子供]], [兄],
  [#ruby[おとこ][男]の#ruby[した][下]の#ruby[こども][子供]], [弟],
  [#ruby[おんな][女]の#ruby[うえ][上]の#ruby[こども][子供]], [姉],
  [#ruby[おんな][女]の#ruby[した][下]の#ruby[こども][子供]], [妹],
  [#ruby[おんな][女]の#ruby[ひと][人]の#ruby[おとこ][男]], [夫],
  [#ruby[おとこ][男]の#ruby[ひと][人]の#ruby[おんな][女]], [妻],
  [#ruby[わたし][私]の#ruby[おとこ][男]の#ruby[こども][子供]], [息子],
  [#ruby[わたし][私]の#ruby[おんな][女]の#ruby[こども][子供]], [娘],
  [#ruby[こども][子供]の#ruby[ちち][父]または#ruby[はは][母]], [親],
  [#ruby[ちち][父]の#ruby[ちち][父]], [祖父],
  [#ruby[ちち][父]の#ruby[はは][母]], [祖母],
  [#ruby[こども][子供]の#ruby[こども][子供]], [孫],
  [よく#ruby[あ][会]う#ruby[す][好]きな#ruby[ひと][人]], [友達],
  [とても#ruby[す][好]きな#ruby[ひと][人]], [恋人],
  [あの#ruby[おとこ][男]の#ruby[ひと][人]], [彼],
  [あの#ruby[おんな][女]の#ruby[ひと][人]], [彼女],
  [#ruby[まえ][前]からいる#ruby[ひと][人]], [先輩],
  [#ruby[あと][後]から#ruby[き][来]た#ruby[ひと][人]], [後輩],
  [よく#ruby[あ][会]う#ruby[ひと][人]たち], [仲間],
  [#ruby[ちか][近]くにいる#ruby[ひと][人]], [隣人],
  [#ruby[あ][会]っている#ruby[ひと][人]], [相手],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]], [皆],
  [まだ#ruby[おお][大]きくなっていない#ruby[こども][子供]], [赤ちゃん],
  [#ruby[とし][年]が#ruby[すこ][少]しの#ruby[ひと][人]], [若者],
  [#ruby[とし][年]が#ruby[おお][多]い#ruby[ひと][人]], [老人],
  [#ruby[おお][大]きくなった#ruby[ひと][人]], [大人],
  [#ruby[おし][教]える#ruby[ひと][人]], [先生],
  [#ruby[からだ][体]を#ruby[たす][助]ける#ruby[ひと][人]], [医者],
  [#ruby[わる][悪]いことをする#ruby[ひと][人]を#ruby[と][止]める#ruby[ひと][人]], [警察],
  [#ruby[たたか][戦]う#ruby[ひと][人]], [兵士],
  [#ruby[くに][国]で#ruby[たか][高]い#ruby[ひと][人]], [王],
  [とても#ruby[つよ][強]い#ruby[うえ][上]にいる#ruby[ひと][人]], [神],
  [その#ruby[くに][国]にいる#ruby[ひと][人]], [市民],
  [その#ruby[くに][国]の#ruby[ぜんぶ][全部]の#ruby[ひと][人]], [国民],
  [#ruby[たたか][戦]う#ruby[わる][悪]い#ruby[ひと][人]], [敵],
  [よく#ruby[たす][助]けてくれる#ruby[ひと][人]], [味方],
  [#ruby[わる][悪]いことをされた#ruby[ひと][人]], [被害者],
  [#ruby[わる][悪]いことをした#ruby[ひと][人]], [犯人],
  [#ruby[そと][外]の#ruby[くに][国]から#ruby[き][来]た#ruby[ひと][人]], [外国人],
  [その#ruby[ところ][所]を#ruby[み][見]に#ruby[き][来]た#ruby[ひと][人]], [観光客],
  [#ruby[うご][動]く#ruby[もの][物]の#ruby[なか][中]にいる#ruby[ひと][人]], [乗客],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[ひと][人]], [患者],
  [#ruby[えら][選]ばれた#ruby[ひと][人]], [選手],
  [#ruby[くち][口]から#ruby[おと][音]を#ruby[だ][出]す#ruby[ひと][人]], [歌手],
  [#ruby[ほん][本]を#ruby[つく][作]る#ruby[ひと][人]], [作家],
  [きれいな#ruby[もの][物]を#ruby[つく][作]る#ruby[ひと][人]], [画家],
  [#ruby[うえ][上]にいる#ruby[ひと][人]], [上司],
  [#ruby[した][下]にいる#ruby[ひと][人]], [部下],
  [#ruby[き][来]た#ruby[ひと][人]], [客],
)]

=== #ruby[こころ][心]の#ruby[かん][感]じ (感情と性格)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[よ][良]いことがあった#ruby[こころ][心]], [嬉しい],
  [#ruby[ひと][一]りで#ruby[かな][悲]しい], [寂しい],
  [#ruby[ひと][人]に#ruby[み][見]られたくない#ruby[こころ][心]], [恥ずかしい],
  [#ruby[からだ][体]も#ruby[こころ][心]もとても#ruby[わる][悪]い], [苦しい],
  [とても#ruby[かな][悲]しくて#ruby[わる][悪]い], [辛い],
  [#ruby[ひと][人]に#ruby[よ][良]くする#ruby[こころ][心]がある], [優しい],
  [とても#ruby[つよ][強]くて#ruby[わる][悪]いことを#ruby[と][止]める], [厳しい],
  [#ruby[へん][変]なことをしない#ruby[よ][良]い#ruby[こころ][心]], [素直],
  [#ruby[よ][良]くしようと#ruby[かんが][考]える#ruby[ひと][人]], [真面目],
  [#ruby[からだ][体]も#ruby[こころ][心]も#ruby[よ][良]い], [元気],
  [#ruby[よ][良]いことが#ruby[おお][多]くある#ruby[こころ][心]], [幸せ],
  [これから#ruby[わる][悪]いことが#ruby[く][来]るかもしれないと#ruby[おも][思]う#ruby[こころ][心]], [不安],
  [#ruby[わる][悪]いことが#ruby[お][起]こるかもと#ruby[かんが][考]える], [心配],
  [#ruby[こわ][怖]くて#ruby[からだ][体]が#ruby[うご][動]きにくい], [緊張],
  [#ruby[こころ][心]が#ruby[おお][大]きく#ruby[うご][動]く], [感動],
  [ありがとうと#ruby[おも][思]う#ruby[こころ][心]], [感謝],
  [#ruby[まえ][前]にしたことが#ruby[わる][悪]かったと#ruby[おも][思]う], [後悔],
  [#ruby[わたし][私]は#ruby[よ][良]いと#ruby[おも][思]う#ruby[つよ][強]い#ruby[こころ][心]], [自信],
  [#ruby[よ][良]いことが#ruby[く][来]ると#ruby[おも][思]って#ruby[ま][待]つ], [期待],
  [#ruby[よ][良]いことが#ruby[お][起]こってほしいと#ruby[おも][思]う], [希望],
  [#ruby[よ][良]いことはないと#ruby[おも][思]う], [絶望],
  [もっと#ruby[し][知]りたいと#ruby[おも][思]う#ruby[こころ][心]], [興味],
  [#ruby[たの][楽]しいことが#ruby[なに][何]もない], [退屈],
  [#ruby[し][知]らなかったことが#ruby[お][起]こって#ruby[かん][感]じる], [驚く],
  [どうすればいいか#ruby[おも][思]えなくて#ruby[わる][悪]い], [困る],
  [どれを#ruby[えら][選]ぶかと#ruby[かんが][考]えて#ruby[と][止]まる], [迷う],
  [#ruby[はや][速]くしなければと#ruby[おも][思]って#ruby[こわ][怖]い], [焦る],
  [#ruby[わる][悪]くても#ruby[と][止]まらずにいること], [我慢],
  [#ruby[わる][悪]いことをした#ruby[ひと][人]を#ruby[よ][良]いと#ruby[い][言]う], [許す],
  [#ruby[ほんとう][本当]だと#ruby[おも][思]う], [信じる],
  [#ruby[ほんとう][本当]かどうかと#ruby[おも][思]う], [疑う],
  [とても#ruby[よ][良]い#ruby[ひと][人]だと#ruby[おも][思]う], [尊敬],
  [とても#ruby[わる][悪]い#ruby[ひと][人]だと#ruby[おも][思]う], [軽蔑],
  [#ruby[かな][悲]しい#ruby[ひと][人]の#ruby[こころ][心]を#ruby[かん][感]じる], [同情],
  [#ruby[ほか][他]の#ruby[ひと][人]が#ruby[も][持]っているものを#ruby[ほ][欲]しいと#ruby[おも][思]う], [嫉妬],
  [#ruby[わる][悪]いことをされてまだ#ruby[おこ][怒]る], [恨む],
  [あの#ruby[ひと][人]のようになりたいと#ruby[おも][思]う], [憧れる],
  [もう#ruby[よ][良]いと#ruby[かん][感]じる], [満足],
  [まだ#ruby[よ][良]くないと#ruby[おも][思]う], [不満],
  [#ruby[ひと][一]りしかいなくて#ruby[かな][悲]しい], [孤独],
  [#ruby[こわ][怖]くても#ruby[まえ][前]に#ruby[い][行]く#ruby[つよ][強]い#ruby[こころ][心]], [勇気],
  [#ruby[わたし][私]は#ruby[よ][良]いと#ruby[かん][感]じる#ruby[つよ][強]い#ruby[こころ][心]], [誇り],
  [ある#ruby[ひと][人]がとても#ruby[す][好]きになる#ruby[こころ][心]], [恋],
  [ある#ruby[ひと][人]をとても#ruby[よ][良]くしたい#ruby[つよ][強]い#ruby[こころ][心]], [愛],
  [#ruby[わる][悪]いことが#ruby[お][起]こって#ruby[おこ][怒]る#ruby[こころ][心]], [怒り],
  [#ruby[よ][良]いことが#ruby[お][起]こって#ruby[わら][笑]いたい#ruby[こころ][心]], [喜び],
  [#ruby[し][知]らなかったことを#ruby[み][見]たり#ruby[き][聞]いたりした#ruby[こころ][心]], [驚き],
  [とても#ruby[こわ][怖]い#ruby[こころ][心]], [恐怖],
  [#ruby[おこ][怒]らないで#ruby[よ][良]く#ruby[かんが][考]える], [冷静],
  [#ruby[ほか][他]の#ruby[ひと][人]の#ruby[よ][良]いものを#ruby[ほ][欲]しいと#ruby[おも][思]う], [羨む],
)]

=== #ruby[ひと][人]の#ruby[なか][中] (社会と文化)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[ひと][人]たちがいる#ruby[ところ][所]], [社会],
  [#ruby[くに][国]をどうするかを#ruby[えら][選]ぶこと], [政治],
  [お#ruby[おかね][金]と#ruby[もの][物]の#ruby[うご][動]き], [経済],
  [#ruby[くに][国]の#ruby[ひと][人]がしなければならないこと], [法律],
  [#ruby[ひと][人]がしてもいいこと], [権利],
  [#ruby[ひと][人]がしなければならないこと], [義務],
  [したいことができること], [自由],
  [#ruby[たたか][戦]いがない#ruby[よ][良]い#ruby[とき][時]], [平和],
  [#ruby[くに][国]と#ruby[くに][国]が#ruby[たたか][戦]うこと], [戦争],
  [#ruby[くに][国]のために#ruby[たたか][戦]う#ruby[ひと][人]たち], [軍隊],
  [#ruby[くに][国]を#ruby[うご][動]かす#ruby[ひと][人]たち], [政府],
  [#ruby[くに][国]を#ruby[うご][動]かす#ruby[ひと][人]を#ruby[えら][選]ぶこと], [選挙],
  [#ruby[くに][国]に#ruby[あた][与]えるお#ruby[おかね][金]], [税金],
  [#ruby[まえ][前]に#ruby[お][起]こったこと], [歴史],
  [その#ruby[くに][国]の#ruby[ひと][人]たちがすること], [文化],
  [#ruby[ひと][人]の#ruby[うえ][上]にいる#ruby[つよ][強]い#ruby[もの][物]を#ruby[おも][思]うこと], [宗教],
  [#ruby[ひと][人]に#ruby[おし][教]えること], [教育],
  [#ruby[もの][物]がどうなっているかを#ruby[し][知]ること], [科学],
  [きれいな#ruby[もの][物]を#ruby[つく][作]ること], [芸術],
  [#ruby[ことば][言葉]で#ruby[つく][作]った#ruby[ほん][本]], [文学],
  [なぜ#ruby[い][生]きるかを#ruby[かんが][考]えること], [哲学],
  [#ruby[まえ][前]からある#ruby[こと][事]], [伝統],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]で#ruby[たの][楽]しくする#ruby[にち][日]], [祭り],
  [#ruby[ひと][人]たちが#ruby[まえ][前]からする#ruby[こと][事]], [儀式],
  [#ruby[おとこ][男]と#ruby[おんな][女]が#ruby[いえ][家]の#ruby[ひと][人]になること], [結婚],
  [#ruby[し][死]んだ#ruby[ひと][人]のためにする#ruby[こと][事]], [葬式],
  [#ruby[わる][悪]いことが#ruby[お][起]こった#ruby[こと][事]], [事件],
  [#ruby[おも][思]わないで#ruby[わる][悪]いことが#ruby[お][起]こること], [事故],
  [#ruby[ひと][人]がしてはいけない#ruby[わる][悪]いこと], [犯罪],
  [#ruby[わる][悪]いことをしたかどうかを#ruby[ひと][人]が#ruby[い][言]うこと], [裁判],
  [#ruby[わる][悪]いことをした#ruby[ひと][人]に#ruby[あた][与]える#ruby[わる][悪]いこと], [刑罰],
  [#ruby[まい][毎]#ruby[にち][日]の#ruby[こと][事]が#ruby[か][書]いてある#ruby[ほん][本]], [新聞],
  [#ruby[おお][多]くの#ruby[ひと][人]に#ruby[おと][音]や#ruby[ひかり][光]で#ruby[ことば][言葉]を#ruby[だ][出]すこと], [放送],
  [#ruby[もの][物]を#ruby[か][買]ってほしいと#ruby[い][言]うこと], [広告],
  [#ruby[ひと][人]に#ruby[し][知]らせること], [情報],
  [#ruby[ひと][人]に#ruby[ことば][言葉]を#ruby[だ][出]すこと], [通信],
  [#ruby[もの][物]を#ruby[つく][作]るための#ruby[し][知]ること], [技術],
  [#ruby[おお][多]くの#ruby[もの][物]を#ruby[つく][作]ること], [産業],
  [#ruby[くに][国]と#ruby[くに][国]で#ruby[もの][物]を#ruby[か][買]ったり#ruby[あた][与]えたりすること], [貿易],
  [#ruby[ひと][人]の#ruby[そと][外]にある#ruby[みず][水]や#ruby[かぜ][風]や#ruby[つち][土]], [環境],
  [#ruby[みず][水]や#ruby[かぜ][風]が#ruby[わる][悪]くなること], [汚染],
  [#ruby[ひと][人]が#ruby[つか][使]える#ruby[もの][物]], [資源],
  [その#ruby[ところ][所]にいる#ruby[ひと][人]の#ruby[おお][多]さ], [人口],
  [ある#ruby[ひと][人]を#ruby[ほか][他]の#ruby[ひと][人]より#ruby[わる][悪]くすること], [差別],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]が#ruby[よ][良]いとすること], [平等],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]が#ruby[くに][国]のことを#ruby[えら][選]べること], [民主主義],
  [#ruby[くに][国]のやることを#ruby[おお][大]きく#ruby[か][変]えること], [革命],
  [#ruby[ほか][他]の#ruby[くに][国]が#ruby[も][持]っている#ruby[ところ][所]], [植民地],
  [#ruby[ほか][他]の#ruby[くに][国]に#ruby[い][行]ってそこにいる#ruby[ひと][人]], [移民],
  [#ruby[こわ][怖]いので#ruby[くに][国]から#ruby[で][出]た#ruby[ひと][人]], [難民],
)]

=== #ruby[ところ][所]と#ruby[おお][大]きい#ruby[もの][物] (場所と建物)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[おお][多]くの#ruby[ひと][人]がいる#ruby[ところ][所]], [町],
  [とても#ruby[おお][多]くの#ruby[ひと][人]がいる#ruby[おお][大]きい#ruby[ところ][所]], [市],
  [#ruby[ひと][人]が#ruby[すこ][少]しだけいる#ruby[ところ][所]], [村],
  [#ruby[ひと][人]が#ruby[く][来]る#ruby[もの][物]を#ruby[ま][待]つ#ruby[ところ][所]], [駅],
  [#ruby[もの][物]を#ruby[か][買]う#ruby[ところ][所]], [店],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[ひと][人]を#ruby[たす][助]ける#ruby[ところ][所]], [病院],
  [お#ruby[おかね][金]を#ruby[まも][守]る#ruby[ところ][所]], [銀行],
  [#ruby[か][書]いた#ruby[もの][物]を#ruby[ほか][他]の#ruby[ひと][人]に#ruby[あた][与]える#ruby[ところ][所]], [郵便局],
  [#ruby[ほん][本]を#ruby[よ][読]む#ruby[ところ][所]], [図書館],
  [きれいな#ruby[もの][物]を#ruby[み][見]る#ruby[ところ][所]], [美術館],
  [#ruby[くに][国]の#ruby[もの][物]を#ruby[み][見]る#ruby[ところ][所]], [博物館],
  [#ruby[ひと][人]が#ruby[み][見]せる#ruby[こと][事]をする#ruby[ところ][所]], [劇場],
  [#ruby[おお][大]きい#ruby[ひかり][光]の#ruby[もの][物]を#ruby[み][見]る#ruby[ところ][所]], [映画館],
  [#ruby[そと][外]で#ruby[たの][楽]しくいられる#ruby[ところ][所]], [公園],
  [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[く][来]る#ruby[そと][外]の#ruby[ところ][所]], [広場],
  [#ruby[みず][水]の#ruby[うえ][上]を#ruby[い][行]く#ruby[みち][道]], [橋],
  [#ruby[たか][高]くて#ruby[なが][長]い#ruby[もの][物]], [塔],
  [#ruby[つよ][強]い#ruby[ひと][人]が#ruby[まも][守]る#ruby[おお][大]きい#ruby[いえ][家]], [城],
  [#ruby[ひと][人]が#ruby[こころ][心]の#ruby[こと][事]を#ruby[かんが][考]える#ruby[ところ][所]], [寺],
  [この#ruby[くに][国]の#ruby[こころ][心]に#ruby[い][言]う#ruby[ところ][所]], [神社],
  [#ruby[ひと][人]が#ruby[こころ][心]に#ruby[よ][良]いことを#ruby[き][聞]く#ruby[ところ][所]], [教会],
  [#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]], [工場],
  [#ruby[もの][物]を#ruby[なか][中]に#ruby[い][入]れて#ruby[まも][守]る#ruby[ところ][所]], [倉庫],
  [#ruby[うみ][海]を#ruby[うご][動]く#ruby[もの][物]が#ruby[く][来]る#ruby[ところ][所]], [港],
  [#ruby[そら][空]を#ruby[うご][動]く#ruby[もの][物]が#ruby[で][出]る#ruby[ところ][所]], [空港],
  [#ruby[もの][物]が#ruby[はや][速]く#ruby[うご][動]く#ruby[みち][道]], [道路],
  [#ruby[みち][道]と#ruby[みち][道]が#ruby[あ][会]う#ruby[ところ][所]], [交差点],
  [#ruby[あか][赤]と#ruby[あお][青]の#ruby[ひかり][光]で#ruby[うご][動]くのを#ruby[と][止]める#ruby[もの][物]], [信号],
  [#ruby[うえ][上]に#ruby[い][行]くための#ruby[みち][道]], [階段],
  [#ruby[なか][中]に#ruby[はい][入]るための#ruby[ところ][所]], [入口],
  [#ruby[そと][外]に#ruby[で][出]るための#ruby[ところ][所]], [出口],
  [#ruby[いえ][家]にあって#ruby[そと][外]が#ruby[み][見]えるもの], [窓],
  [#ruby[あ][開]いたり#ruby[し][閉]めたりする#ruby[もの][物]], [扉],
  [#ruby[そと][外]と#ruby[なか][中]の#ruby[い][入]り#ruby[ぐち][口]にある#ruby[おお][大]きい#ruby[もの][物]], [門],
  [#ruby[いえ][家]の#ruby[いち][一]ばん#ruby[うえ][上]にある#ruby[もの][物]], [屋根],
  [#ruby[いえ][家]の#ruby[そと][外]にある#ruby[いし][石]や#ruby[き][木]でできた#ruby[もの][物]], [壁],
  [#ruby[いえ][家]の#ruby[なか][中]で#ruby[あし][足]が#ruby[うえ][上]にある#ruby[した][下]の#ruby[もの][物]], [床],
  [#ruby[いえ][家]の#ruby[なか][中]の#ruby[いち][一]ばん#ruby[うえ][上]], [天井],
  [#ruby[いえ][家]の#ruby[そと][外]にある#ruby[くさ][草]の#ruby[ところ][所]], [庭],
  [#ruby[いえ][家]の#ruby[なか][中]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]], [台所],
  [#ruby[いえ][家]の#ruby[なか][中]で#ruby[ひと][人]が#ruby[たの][楽]しくいる#ruby[ところ][所]], [居間],
  [#ruby[いえ][家]の#ruby[なか][中]で#ruby[ね][寝]る#ruby[ところ][所]], [寝室],
  [#ruby[つち][土]の#ruby[した][下]], [地下],
  [#ruby[つち][土]の#ruby[うえ][上]], [地上],
  [#ruby[うみ][海]の#ruby[なか][中]にある#ruby[つち][土]の#ruby[ところ][所]], [島],
  [#ruby[みず][水]がなくて#ruby[あつ][暑]い#ruby[ところ][所]], [砂漠],
  [#ruby[き][木]が#ruby[おお][多]くある#ruby[ところ][所]], [森],
  [#ruby[やま][山]と#ruby[やま][山]の#ruby[した][下]にある#ruby[ところ][所]], [谷],
  [#ruby[やま][山]から#ruby[うみ][海]へ#ruby[みず][水]が#ruby[うご][動]く#ruby[みち][道]], [川],
)]

=== #ruby[うご][動]く#ruby[もの][物]と#ruby[い][行]く#ruby[こと][事] (移動と旅行)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[みち][道]を#ruby[はや][速]く#ruby[うご][動]く#ruby[もの][物]], [車],
  [#ruby[みち][道]の#ruby[うえ][上]を#ruby[うご][動]く#ruby[なが][長]い#ruby[もの][物]], [電車],
  [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[なか][中]に#ruby[はい][入]る#ruby[おお][大]きい#ruby[もの][物]], [バス],
  [#ruby[そら][空]を#ruby[うご][動]く#ruby[もの][物]], [飛行機],
  [#ruby[うみ][海]を#ruby[うご][動]く#ruby[もの][物]], [船],
  [#ruby[あし][足]を#ruby[つか][使]って#ruby[うご][動]かす#ruby[もの][物]], [自転車],
  [お#ruby[おかね][金]を#ruby[あた][与]えて#ruby[なか][中]に#ruby[はい][入]る#ruby[もの][物]], [タクシー],
  [#ruby[おも][重]い#ruby[もの][物]を#ruby[も][持]って#ruby[うご][動]く#ruby[おお][大]きい#ruby[もの][物]], [トラック],
  [#ruby[はや][速]く#ruby[うご][動]ける#ruby[おお][大]きい#ruby[みち][道]], [高速道路],
  [#ruby[なが][長]い#ruby[もの][物]が#ruby[うご][動]く#ruby[みち][道]], [鉄道],
  [#ruby[なが][長]い#ruby[もの][物]が#ruby[うえ][上]を#ruby[うご][動]く#ruby[みち][道]], [線路],
  [#ruby[もの][物]を#ruby[うご][動]かすこと], [運転],
  [#ruby[ところ][所]を#ruby[で][出]ること], [出発],
  [#ruby[ところ][所]に#ruby[く][来]ること], [到着],
  [#ruby[ほか][他]の#ruby[ところ][所]に#ruby[い][行]くこと], [旅行],
  [#ruby[ほか][他]の#ruby[ところ][所]を#ruby[み][見]ること], [観光],
  [#ruby[みち][道]や#ruby[ところ][所]を#ruby[おし][教]えること], [案内],
  [#ruby[ところ][所]を#ruby[か][書]いた#ruby[もの][物]], [地図],
  [#ruby[なか][中]に#ruby[はい][入]るために#ruby[か][買]う#ruby[もの][物]], [切符],
  [#ruby[ほか][他]の#ruby[くに][国]に#ruby[い][行]くときに#ruby[ひつよう][必要]な#ruby[ほん][本]], [パスポート],
  [#ruby[い][行]く#ruby[とき][時]に#ruby[も][持]って#ruby[い][行]く#ruby[もの][物]], [荷物],
  [#ruby[すわ][座]る#ruby[ところ][所]], [座席],
  [どのくらい#ruby[はや][速]いかということ], [速度],
  [#ruby[ふた][二]つの#ruby[ところ][所]がどのくらい#ruby[とお][遠]いか], [距離],
  [どちらに#ruby[い][行]くかということ], [方向],
  [#ruby[みち][道]を#ruby[ひと][人]や#ruby[もの][物]が#ruby[うご][動]くこと], [交通],
  [#ruby[もの][物]が#ruby[うご][動]けなくなること], [渋滞],
  [#ruby[わる][悪]いことが#ruby[お][起]こること], [事故],
  [#ruby[なか][中]に#ruby[はい][入]るために#ruby[あた][与]えるお#ruby[おかね][金]], [運賃],
  [#ruby[い][行]くだけで#ruby[こ][来]ない#ruby[みち][道]], [片道],
  [#ruby[い][行]って#ruby[く][来]ること], [往復],
  [#ruby[い][行]きたい#ruby[ところ][所]], [目的地],
  [#ruby[ほか][他]の#ruby[くに][国]], [外国],
  [もとの#ruby[くに][国]に#ruby[く][来]ること], [帰国],
  [#ruby[みち][道]が#ruby[み][見]えなくなった#ruby[こども][子供]], [迷子],
  [#ruby[はじ][始]まりと#ruby[お][終]わりの#ruby[まえ][前]], [途中],
  [#ruby[もの][物]の#ruby[なか][中]に#ruby[はい][入]る#ruby[ひと][人]], [乗客],
  [#ruby[もの][物]を#ruby[うご][動]かす#ruby[ひと][人]], [運転手],
  [#ruby[うご][動]く#ruby[もの][物]が#ruby[と][止]まって#ruby[お][終]わる#ruby[ところ][所]], [終点],
)]

=== #ruby[そと][外]と#ruby[そら][空] (自然と天気)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[そら][空]から#ruby[しろ][白]くて#ruby[さむ][寒]い#ruby[みず][水]が#ruby[く][来]ること], [雪],
  [#ruby[さむ][寒]くなった#ruby[みず][水]], [氷],
  [#ruby[しろ][白]い#ruby[かぜ][風]で#ruby[なに][何]も#ruby[み][見]えなくなること], [霧],
  [#ruby[あめ][雨]の#ruby[あと][後]に#ruby[そら][空]に#ruby[で][出]る#ruby[いろ][色]の#ruby[ひかり][光]], [虹],
  [#ruby[そら][空]で#ruby[おお][大]きい#ruby[おと][音]と#ruby[ひかり][光]が#ruby[お][起]こること], [雷],
  [#ruby[つよ][強]い#ruby[かぜ][風]と#ruby[あめ][雨]が#ruby[く][来]ること], [台風],
  [#ruby[つち][土]が#ruby[うご][動]くこと], [地震],
  [#ruby[みず][水]が#ruby[おお][多]くなって#ruby[ところ][所]が#ruby[みず][水]の#ruby[なか][中]に#ruby[はい][入]ること], [洪水],
  [#ruby[そと][外]で#ruby[お][起]こる#ruby[わる][悪]いこと], [災害],
  [#ruby[やま][山]や#ruby[つち][土]の#ruby[なか][中]にある#ruby[おお][大]きい#ruby[みず][水]], [湖],
  [#ruby[やま][山]や#ruby[つち][土]の#ruby[なか][中]にある#ruby[みず][水]], [池],
  [#ruby[たか][高]い#ruby[ところ][所]から#ruby[みず][水]が#ruby[した][下]に#ruby[で][出]てくること], [滝],
  [#ruby[つち][土]の#ruby[なか][中]から#ruby[みず][水]が#ruby[で][出]てくる#ruby[ところ][所]], [泉],
  [#ruby[き][木]が#ruby[おお][多]くある#ruby[ところ][所]], [林],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[つち][土]の#ruby[ところ][所]], [畑],
  [#ruby[みず][水]を#ruby[つか][使]って#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[ところ][所]], [田んぼ],
  [#ruby[うみ][海]や#ruby[やま][山]にある#ruby[いし][石]でできた#ruby[もの][物]], [砂],
  [#ruby[くさ][草]や#ruby[き][木]にある#ruby[いろ][色]のある#ruby[もの][物]], [花],
  [#ruby[しろ][白]や#ruby[あか][赤]の#ruby[いろ][色]の#ruby[き][木]の#ruby[もの][物]], [桜],
  [#ruby[き][木]の#ruby[みどり][緑]の#ruby[もの][物]], [葉],
  [#ruby[き][木]や#ruby[くさ][草]の#ruby[つち][土]の#ruby[なか][中]にある#ruby[もの][物]], [根],
  [#ruby[くさ][草]や#ruby[き][木]になる#ruby[まえ][前]の#ruby[もの][物]], [種],
  [#ruby[き][木]にある#ruby[た][食]べられる#ruby[もの][物]], [実],
  [#ruby[あし][足]が#ruby[おお][多]い#ruby[どうぶつ][動物]], [虫],
  [#ruby[いえ][家]にいる#ruby[どうぶつ][動物]], [猫],
  [#ruby[おお][大]きくて#ruby[つよ][強]い#ruby[どうぶつ][動物]で#ruby[ひと][人]が#ruby[うえ][上]に#ruby[すわ][座]るもの], [馬],
  [#ruby[しろ][白]と#ruby[くろ][黒]の#ruby[おお][大]きい#ruby[どうぶつ][動物]], [牛],
  [#ruby[あし][足]がなくて#ruby[なが][長]い#ruby[どうぶつ][動物]], [蛇],
  [#ruby[おお][大]きくて#ruby[つよ][強]くて#ruby[こわ][怖]い#ruby[どうぶつ][動物]], [熊],
  [#ruby[そら][空]を#ruby[うご][動]く#ruby[どうぶつ][動物]が#ruby[つか][使]う#ruby[もの][物]], [羽],
  [#ruby[とし][年]の#ruby[なか][中]で#ruby[あつ][暑]さや#ruby[さむ][寒]さが#ruby[か][変]わる#ruby[とき][時]], [季節],
  [#ruby[さむ][寒]い#ruby[とき][時]の#ruby[あと][後]で#ruby[あつ][暑]くなる#ruby[まえ][前]の#ruby[とき][時]], [春],
  [#ruby[とし][年]で#ruby[いち][一]ばん#ruby[あつ][暑]い#ruby[とき][時]], [夏],
  [#ruby[あつ][暑]い#ruby[とき][時]の#ruby[あと][後]で#ruby[さむ][寒]くなる#ruby[まえ][前]の#ruby[とき][時]], [秋],
  [#ruby[とし][年]で#ruby[いち][一]ばん#ruby[さむ][寒]い#ruby[とき][時]], [冬],
  [#ruby[たいよう][太陽]が#ruby[そら][空]に#ruby[で][出]てくること], [日の出],
  [#ruby[たいよう][太陽]が#ruby[した][下]に#ruby[はい][入]ること], [日の入り],
  [#ruby[たいよう][太陽]が#ruby[で][出]てきた#ruby[あと][後]の#ruby[とき][時]], [朝],
  [#ruby[うみ][海]の#ruby[みず][水]が#ruby[うえ][上]に#ruby[く][来]たり#ruby[した][下]に#ruby[い][行]ったりすること], [潮],
  [#ruby[うみ][海]の#ruby[みず][水]が#ruby[うご][動]くこと], [波],
)]

=== #ruby[た][食]べ#ruby[もの][物]と#ruby[の][飲]み#ruby[もの][物] (食べ物と飲み物)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[ひ][火]で#ruby[つく][作]った#ruby[た][食]べ#ruby[もの][物]], [料理],
  [#ruby[た][食]べる#ruby[こと][事]], [食事],
  [#ruby[にち][日]の#ruby[はじ][始]まりに#ruby[た][食]べる#ruby[もの][物]], [朝食],
  [#ruby[にち][日]の#ruby[なか][中]の#ruby[とき][時]に#ruby[た][食]べる#ruby[もの][物]], [昼食],
  [#ruby[よる][夜]に#ruby[た][食]べる#ruby[もの][物]], [夕食],
  [#ruby[そと][外]で#ruby[た][食]べるために#ruby[つく][作]った#ruby[た][食]べ#ruby[もの][物]], [弁当],
  [#ruby[こども][子供]が#ruby[す][好]きな#ruby[た][食]べ#ruby[もの][物]], [お菓子],
  [#ruby[くさ][草]から#ruby[つく][作]った#ruby[しろ][白]い#ruby[た][食]べ#ruby[もの][物]], [パン],
  [#ruby[に][日]ほんで#ruby[おお][多]く#ruby[た][食]べる#ruby[しろ][白]い#ruby[た][食]べ#ruby[もの][物]], [米],
  [#ruby[みず][水]で#ruby[つく][作]った#ruby[しろ][白]い#ruby[くさ][草]の#ruby[た][食]べ#ruby[もの][物]], [ご飯],
  [#ruby[つち][土]から#ruby[で][出]る#ruby[た][食]べる#ruby[くさ][草]], [野菜],
  [#ruby[き][木]からもらう#ruby[た][食]べ#ruby[もの][物]], [果物],
  [#ruby[うみ][海]の#ruby[みず][水]から#ruby[つく][作]る#ruby[しろ][白]い#ruby[もの][物]], [塩],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[よ][良]い#ruby[かん][感]じにする#ruby[しろ][白]い#ruby[もの][物]], [砂糖],
  [#ruby[くろ][黒]い#ruby[いろ][色]の#ruby[た][食]べ#ruby[もの][物]に#ruby[つか][使]う#ruby[みず][水]], [醤油],
  [#ruby[くち][口]で#ruby[かん][感]じる#ruby[こと][事]], [味],
  [#ruby[はな][鼻]で#ruby[かん][感]じる#ruby[こと][事]], [匂い],
  [#ruby[の][飲]むと#ruby[からだ][体]が#ruby[へん][変]になる#ruby[みず][水]], [酒],
  [#ruby[くさ][草]から#ruby[つく][作]った#ruby[の][飲]み#ruby[もの][物]], [お茶],
  [#ruby[き][木]の#ruby[た][食]べ#ruby[もの][物]から#ruby[で][出]る#ruby[みず][水]], [ジュース],
  [#ruby[どう][動]#ruby[ぶつ][物]の#ruby[からだ][体]から#ruby[で][出]る#ruby[しろ][白]い#ruby[の][飲]み#ruby[もの][物]], [牛乳],
  [#ruby[くろ][黒]い#ruby[の][飲]み#ruby[もの][物]], [コーヒー],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[うえ][上]に#ruby[い][入]れる#ruby[もの][物]], [皿],
  [#ruby[た][食]べる#ruby[とき][時]に#ruby[つか][使]う#ruby[に][二]#ruby[ほん][本]の#ruby[き][木]], [箸],
  [#ruby[の][飲]み#ruby[もの][物]を#ruby[い][入]れる#ruby[もの][物]], [コップ],
  [#ruby[みず][水]や#ruby[の][飲]み#ruby[もの][物]を#ruby[い][入]れる#ruby[もの][物]], [瓶],
  [#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る#ruby[もの][物]], [鍋],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[き][切]る#ruby[もの][物]], [包丁],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[さむ][寒]くして#ruby[い][入]れる#ruby[もの][物]], [冷蔵庫],
  [とても#ruby[さむ][寒]くなった#ruby[みず][水]], [氷],
  [#ruby[た][食]べ#ruby[もの][物]を#ruby[ひ][火]で#ruby[つく][作]る#ruby[とき][時]に#ruby[つか][使]う#ruby[もの][物]], [油],
  [#ruby[みず][水]で#ruby[つく][作]った#ruby[あつ][暑]い#ruby[た][食]べ#ruby[もの][物]], [スープ],
  [#ruby[き][切]った#ruby[くさ][草]の#ruby[た][食]べ#ruby[もの][物]], [サラダ],
  [#ruby[た][食]べて#ruby[くち][口]で#ruby[よ][良]い#ruby[かん][感]じ], [甘い],
  [#ruby[た][食]べて#ruby[くち][口]で#ruby[わる][悪]い#ruby[かん][感]じ], [苦い],
  [#ruby[くち][口]に#ruby[つよ][強]い#ruby[かん][感]じがする#ruby[た][食]べ#ruby[もの][物]の#ruby[こと][事]], [辛い],
  [#ruby[くち][口]がとても#ruby[へん][変]に#ruby[かん][感]じる#ruby[た][食]べ#ruby[もの][物]の#ruby[こと][事]], [酸っぱい],
  [#ruby[た][食]べ#ruby[もの][物]が#ruby[くち][口]で#ruby[よ][良]い#ruby[かん][感]じがする], [美味しい],
  [#ruby[た][食]べ#ruby[もの][物]の#ruby[くち][口]の#ruby[かん][感]じが#ruby[わる][悪]い], [まずい],
  [#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る], [焼く],
  [#ruby[みず][水]と#ruby[ひ][火]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る], [煮る],
  [#ruby[あつ][暑]い#ruby[みず][水]のような#ruby[もの][物]で#ruby[た][食]べ#ruby[もの][物]を#ruby[つく][作]る], [揚げる],
  [#ruby[た][食]べ#ruby[もの][物]が#ruby[ほ][欲]しくなる], [腹が減る],
  [#ruby[の][飲]み#ruby[もの][物]が#ruby[ほ][欲]しくなる], [喉が渇く],
)]

=== #ruby[からだ][体]と#ruby[よ][良]い#ruby[からだ][体] (体と健康)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[とき][時]], [病気],
  [#ruby[からだ][体]を#ruby[よ][良]くするために#ruby[の][飲]む#ruby[もの][物]], [薬],
  [#ruby[からだ][体]が#ruby[わる][悪]くなった#ruby[こと][事]], [怪我],
  [#ruby[からだ][体]が#ruby[わる][悪]く#ruby[かん][感]じる], [痛い],
  [#ruby[からだ][体]がとても#ruby[あつ][暑]くなる#ruby[こと][事]], [熱],
  [#ruby[からだ][体]が#ruby[わる][悪]くて#ruby[あつ][暑]くなる#ruby[こと][事]], [風邪],
  [#ruby[くち][口]から#ruby[つよ][強]く#ruby[くう][空]#ruby[き][気]が#ruby[で][出]る#ruby[こと][事]], [咳],
  [#ruby[からだ][体]を#ruby[うご][動]かす#ruby[もの][物]], [筋肉],
  [#ruby[くち][口]の#ruby[なか][中]で#ruby[た][食]べ#ruby[もの][物]を#ruby[き][切]る#ruby[しろ][白]い#ruby[もの][物]], [歯],
  [#ruby[て][手]や#ruby[あし][足]の#ruby[お][終]わりの#ruby[なが][長]い#ruby[ところ][所]], [指],
  [#ruby[あたま][頭]の#ruby[した][下]、#ruby[て][手]の#ruby[うえ][上]にある#ruby[からだ][体]の#ruby[ところ][所]], [肩],
  [#ruby[からだ][体]の#ruby[なか][中]ほどにある#ruby[ところ][所]], [腰],
  [#ruby[からだ][体]の#ruby[うし][後]ろにある#ruby[ところ][所]], [背中],
  [#ruby[あたま][頭]と#ruby[からだ][体]の#ruby[なか][中]の#ruby[ところ][所]], [首],
  [#ruby[からだ][体]の#ruby[まえ][前]の#ruby[うえ][上]の#ruby[ところ][所]], [胸],
  [#ruby[からだ][体]の#ruby[まえ][前]の#ruby[なか][中]ほどの#ruby[ところ][所]], [腹],
  [#ruby[あたま][頭]の#ruby[まえ][前]の#ruby[ところ][所]], [顔],
  [#ruby[て][手]や#ruby[あし][足]の#ruby[お][終]わりにある#ruby[つよ][強]い#ruby[もの][物]], [爪],
  [#ruby[くち][口]の#ruby[そと][外]の#ruby[あか][赤]い#ruby[ところ][所]], [唇],
  [#ruby[くち][口]の#ruby[なか][中]で#ruby[た][食]べ#ruby[もの][物]を#ruby[かん][感]じる#ruby[もの][物]], [舌],
  [#ruby[かな][悲]しい#ruby[とき][時]に#ruby[め][目]から#ruby[で][出]る#ruby[みず][水]], [涙],
  [#ruby[あつ][暑]い#ruby[とき][時]に#ruby[からだ][体]から#ruby[で][出]る#ruby[みず][水]], [汗],
  [#ruby[くち][口]から#ruby[で][出]る#ruby[おと][音]], [声],
  [#ruby[くち][口]や#ruby[はな][鼻]から#ruby[で][出]る#ruby[くう][空]#ruby[き][気]], [息],
  [#ruby[くう][空]#ruby[き][気]を#ruby[からだ][体]の#ruby[なか][中]に#ruby[い][入]れたり#ruby[だ][出]したりする#ruby[こと][事]], [呼吸],
  [#ruby[からだ][体]の#ruby[なか][中]の#ruby[あか][赤]い#ruby[みず][水]が#ruby[うご][動]く#ruby[おと][音]], [脈],
  [#ruby[からだ][体]が#ruby[よ][良]い#ruby[とき][時]], [健康],
  [#ruby[からだ][体]も#ruby[こころ][心]も#ruby[よ][良]い#ruby[とき][時]], [元気],
  [#ruby[からだ][体]や#ruby[こころ][心]が#ruby[うご][動]けなくなる], [疲れる],
  [#ruby[ね][寝]たいと#ruby[かん][感]じる], [眠い],
  [#ruby[ね][寝]ている#ruby[とき][時]から#ruby[で][出]る], [起きる],
  [#ruby[からだ][体]の#ruby[わる][悪]い#ruby[ひと][人]を#ruby[たす][助]ける#ruby[ひと][人]], [医者],
  [#ruby[からだ][体]の#ruby[わる][悪]い#ruby[ひと][人]を#ruby[たす][助]ける#ruby[ひと][人]], [看護師],
  [#ruby[からだ][体]を#ruby[き][切]って#ruby[なか][中]を#ruby[よ][良]くする#ruby[こと][事]], [手術],
  [#ruby[からだ][体]の#ruby[なか][中]に#ruby[もの][物]を#ruby[い][入]れる#ruby[こと][事]], [注射],
  [#ruby[からだ][体]がとても#ruby[わる][悪]くて#ruby[いえ][家]を#ruby[で][出]てどこかに#ruby[はい][入]る#ruby[こと][事]], [入院],
  [#ruby[からだ][体]が#ruby[よ][良]くなって#ruby[で][出]る#ruby[こと][事]], [退院],
  [#ruby[からだ][体]の#ruby[なか][中]を#ruby[み][見]る#ruby[こと][事]], [検査],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[とき][時]に#ruby[で][出]る#ruby[へん][変]な#ruby[こと][事]], [症状],
  [#ruby[からだ][体]が#ruby[わる][悪]い#ruby[とき][時]から#ruby[よ][良]くなる], [治る],
  [#ruby[からだ][体]を#ruby[よ][良]くする#ruby[こと][事]], [治す],
  [#ruby[からだ][体]が#ruby[おお][大]きく#ruby[おも][重]くなる], [太る],
  [#ruby[からだ][体]が#ruby[おも][重]くなくなる], [痩せる],
  [#ruby[おんな][女]の#ruby[からだ][体]の#ruby[なか][中]に#ruby[こども][子供]がいる#ruby[とき][時]], [妊娠],
  [#ruby[からだ][体]から#ruby[こ][子]#ruby[ども][供]が#ruby[で][出]る#ruby[こと][事]], [出産],
  [ある#ruby[もの][物]に#ruby[からだ][体]が#ruby[わる][悪]く#ruby[か][変]わる#ruby[こと][事]], [アレルギー],
  [#ruby[からだ][体]が#ruby[き][切]れた#ruby[ところ][所]], [傷],
)]

=== #ruby[とき][時]の#ruby[こと][言]#ruby[ば][葉] (時間の表現)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[で][出]てくる#ruby[とき][時]], [朝],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[うえ][上]にある#ruby[とき][時]], [昼],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[した][下]に#ruby[はい][入]る#ruby[とき][時]], [夕方],
  [#ruby[いま][今]の#ruby[にち][日]の#ruby[はじ][始]まりの#ruby[とき][時]], [今朝],
  [#ruby[いま][今]#ruby[にち][日]の#ruby[よる][夜]], [今夜],
  [#ruby[あす][明]の#ruby[あと][後]の#ruby[にち][日]], [明後日],
  [#ruby[まえ][前]の#ruby[まえ][前]の#ruby[にち][日]], [一昨日],
  [#ruby[いま][今]より#ruby[すこ][少]し#ruby[まえ][前]の#ruby[とき][時]], [先週],
  [#ruby[いま][今]の#ruby[ちか][近]くの#ruby[にち][日]の#ruby[とき][時]], [今週],
  [#ruby[いま][今]より#ruby[すこ][少]し#ruby[あと][後]の#ruby[とき][時]], [来週],
  [#ruby[いま][今]の#ruby[つき][月]の#ruby[まえ][前]の#ruby[つき][月]], [先月],
  [#ruby[いま][今]の#ruby[つき][月]], [今月],
  [#ruby[いま][今]の#ruby[つき][月]の#ruby[あと][後]の#ruby[つき][月]], [来月],
  [#ruby[いま][今]の#ruby[とし][年]の#ruby[まえ][前]の#ruby[とし][年]], [去年],
  [#ruby[いま][今]の#ruby[とし][年]], [今年],
  [#ruby[いま][今]の#ruby[とし][年]の#ruby[あと][後]の#ruby[とし][年]], [来年],
  [#ruby[にち][日]のまとまりの#ruby[お][終]わりの#ruby[にち][日]], [週末],
  [#ruby[まい][毎]#ruby[にち][日]のいつもの#ruby[にち][日]], [平日],
  [#ruby[いま][今]から#ruby[まえ][前]や#ruby[あと][後]まで#ruby[と][止]まらない#ruby[もの][物]], [時間],
  [#ruby[いち][一]の#ruby[とき][時]を#ruby[おお][多]く#ruby[き][切]った#ruby[ひと][一]つ], [分],
  [とても#ruby[すこ][少]しの#ruby[とき][時]], [秒],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[たか][高]くなる#ruby[まえ][前]の#ruby[とき][時]], [午前],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[たか][高]くなった#ruby[あと][後]の#ruby[とき][時]], [午後],
  [#ruby[たい][太]#ruby[よう][陽]が#ruby[ひと][一]つだけ#ruby[たか][高]い#ruby[とき][時]], [正午],
  [#ruby[たい][太]#ruby[よう][陽]の#ruby[にち][日]], [日曜日],
  [#ruby[つき][月]の#ruby[にち][日]], [月曜日],
  [#ruby[なに][何]もしなくていい#ruby[にち][日]], [休日],
  [#ruby[くに][国]が#ruby[えら][選]んだ#ruby[なに][何]もしない#ruby[にち][日]], [祝日],
  [#ruby[とし][年]の#ruby[なか][中]で#ruby[そら][空]が#ruby[か][変]わる#ruby[とき][時]], [季節],
  [#ruby[ひと][人]が#ruby[い][生]きる#ruby[こと][事]が#ruby[はじ][始]まった#ruby[にち][日]], [誕生日],
  [よく#ruby[おも][思]い#ruby[だ][出]す#ruby[ひつよう][必要]な#ruby[にち][日]], [記念日],
  [とても#ruby[すこ][少]しの#ruby[とき][時]], [瞬間],
  [#ruby[はじ][始]まりから#ruby[お][終]わりまでの#ruby[とき][時]], [期間],
  [その#ruby[こと][事]が#ruby[お][終]わらなければならない#ruby[とき][時]], [期限],
  [これより#ruby[あと][後]はできないという#ruby[とき][時]], [締め切り],
  [#ruby[いま][今]から#ruby[すこ][少]し#ruby[まえ][前]の#ruby[とき][時]], [最近],
  [とても#ruby[すこ][少]しの#ruby[とき][時]の#ruby[あと][後]に], [すぐ],
  [#ruby[すこ][少]し#ruby[あと][後]の#ruby[とき][時]に], [やがて],
  [#ruby[お][終]わらない#ruby[とき][時]], [永遠],
  [#ruby[い][生]きている#ruby[ぜん][全]#ruby[ぶ][部]の#ruby[とき][時]], [一生],
  [#ruby[じゅう][十]の#ruby[じゅう][十]の#ruby[とし][年]の#ruby[とき][時]], [世紀],
  [ある#ruby[なが][長]い#ruby[とき][時]の#ruby[こと][事]が#ruby[お][起]こった#ruby[とき][時]], [時代],
  [とても#ruby[なが][長]い#ruby[とき][時]の#ruby[あと][後]に], [ついに],
  [#ruby[おも][思]っていなかった#ruby[とき][時]に#ruby[お][起]こる], [突然],
  [#ruby[なが][長]い#ruby[とき][時]が#ruby[お][終]わって#ruby[あ][会]う], [久しぶり],
)]

=== する#ruby[こと][事] (基本外の動詞)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[はや][速]く#ruby[あし][足]で#ruby[うご][動]く], [走る],
  [#ruby[みず][水]の#ruby[なか][中]で#ruby[うご][動]く], [泳ぐ],
  [#ruby[うえ][上]へ#ruby[い][行]く], [登る],
  [#ruby[した][下]へ#ruby[うご][動]く], [落ちる],
  [#ruby[した][下]へ#ruby[で][出]る], [降りる],
  [#ruby[うえ][上]に#ruby[はい][入]る], [乗る],
  [#ruby[も][持]って#ruby[い][行]く], [運ぶ],
  [ある#ruby[ところ][所]へ#ruby[い][行]かせる], [送る],
  [#ruby[も][持]って#ruby[き][来]て#ruby[あた][与]える], [届ける],
  [#ruby[き][来]て#ruby[て][手]に#ruby[はい][入]る], [届く],
  [#ruby[も][持]って#ruby[あた][与]える], [渡す],
  [#ruby[みぎ][右]か#ruby[ひだり][左]の#ruby[そと][外]へ#ruby[い][行]く], [渡る],
  [#ruby[て][手]で#ruby[かん][感]じる], [触る],
  [#ruby[て][手]で#ruby[うご][動]かす], [押す],
  [#ruby[て][手]で#ruby[ちか][近]くへ#ruby[うご][動]かす], [引く],
  [#ruby[て][手]で#ruby[そら][空]へ#ruby[で][出]す], [投げる],
  [#ruby[した][下]にある#ruby[もの][物]を#ruby[て][手]で#ruby[も][持]つ], [拾う],
  [ある#ruby[ところ][所]に#ruby[と][止]める], [置く],
  [#ruby[うえ][上]から#ruby[もの][物]を#ruby[と][止]める], [掛ける],
  [お#ruby[おかね][金]を#ruby[あた][与]える], [払う],
  [お#ruby[おかね][金]をもらって#ruby[もの][物]を#ruby[あた][与]える], [売る],
  [また#ruby[も][持]って#ruby[く][来]るために#ruby[あた][与]える], [貸す],
  [#ruby[あと][後]で#ruby[あた][与]えるためにもらう], [借りる],
  [もらった#ruby[ひと][人]に#ruby[あた][与]える], [返す],
  [いらない#ruby[もの][物]を#ruby[で][出]す], [捨てる],
  [#ruby[おお][多]く#ruby[も][持]ってくる], [集める],
  [#ruby[ひと][一]つの#ruby[もの][物]を#ruby[ふた][二]つより#ruby[おお][多]くにする], [分ける],
  [#ruby[ふた][二]つより#ruby[おお][多]くの#ruby[もの][物]を#ruby[ひと][一]つにする], [混ぜる],
  [#ruby[ひと][一]つ#ruby[ひと][一]つ#ruby[まえ][前]と#ruby[あと][後]に#ruby[た][立]つ], [並ぶ],
  [#ruby[お][終]わらずに#ruby[お][起]こる], [続く],
  [#ruby[お][終]わらせずにする], [続ける],
  [#ruby[ひと][一]つを#ruby[えら][選]ぶ], [決める],
  [#ruby[ひと][一]つに#ruby[えら][選]ばれる], [決まる],
  [#ruby[ふた][二]つの#ruby[もの][物]が#ruby[ちが][違]うか#ruby[み][見]る], [比べる],
  [いくつあるか#ruby[し][知]る], [数える],
  [#ruby[よ][良]いか#ruby[み][見]るためにする], [試す],
  [ほんとうかどうか#ruby[み][見]る], [確かめる],
  [#ruby[し][知]るために#ruby[み][見]る], [調べる],
  [#ruby[き][聞]かれたことを#ruby[い][言]う], [答える],
  [してほしいと#ruby[い][言]う], [頼む],
  [しないと#ruby[い][言]う], [断る],
  [#ruby[き][来]てほしいと#ruby[い][言]う], [招く],
  [#ruby[ことば][言葉]で#ruby[し][知]らせる], [伝える],
  [とても#ruby[おお][大]きな#ruby[おと][音]で#ruby[くち][口]から#ruby[い][言]う], [叫ぶ],
  [#ruby[なまえ][名前]を#ruby[い][言]って#ruby[く][来]るように#ruby[い][言]う], [呼ぶ],
  [#ruby[おと][音]のある#ruby[ことば][言葉]を#ruby[くち][口]から#ruby[で][出]す], [歌う],
  [#ruby[おと][音]で#ruby[からだ][体]を#ruby[うご][動]かす], [踊る],
  [#ruby[たの][楽]しいことをする], [遊ぶ],
  [お#ruby[おかね][金]のためにする], [働く],
  [ある#ruby[とき][時]まで#ruby[と][止]める], [休む],
  [#ruby[ね][寝]るのを#ruby[と][止]めて#ruby[た][立]つ], [起きる],
  [ある#ruby[ところ][所]に#ruby[まい][毎]#ruby[にち][日]いる], [住む],
  [#ruby[わたし][私]の#ruby[いえ][家]へ#ruby[い][行]く], [帰る],
  [ある#ruby[ところ][所]の#ruby[なか][中]を#ruby[い][行]く], [通る],
  [その#ruby[ところ][所]を#ruby[で][出]る], [過ぎる],
  [とても#ruby[はや][速]くする], [急ぐ],
  [#ruby[こわ][怖]いものから#ruby[そと][外]へ#ruby[い][行]く], [逃げる],
  [ある#ruby[ひと][人]・#ruby[もの][物]の#ruby[あと][後]から#ruby[い][行]く], [追う],
  [#ruby[うご][動]けないようにする], [捕まえる],
  [#ruby[み][見]えないようにする], [隠す],
  [#ruby[み][見]えるようになる], [現れる],
  [#ruby[み][見]えなくなる], [消える],
  [もっと#ruby[おお][多]くなる], [増える],
  [より#ruby[すこ][少]しになる], [減る],
  [#ruby[うえ][上]へ#ruby[うご][動]く], [上がる],
  [#ruby[した][下]へ#ruby[うご][動]く], [下がる],
  [ある#ruby[もの][物]の#ruby[そと][外]を#ruby[うご][動]く], [回る],
  [#ruby[みち][道]が#ruby[みぎ][右]か#ruby[ひだり][左]へ#ruby[か][変]わる], [曲がる],
  [#ruby[からだ][体]が#ruby[はや][速]く#ruby[すこ][少]し#ruby[うご][動]く], [震える],
  [#ruby[みぎ][右]と#ruby[ひだり][左]に#ruby[はや][速]くなく#ruby[うご][動]く], [揺れる],
  [#ruby[ひかり][光]を#ruby[で][出]す], [光る],
  [#ruby[ひ][火]になる], [燃える],
  [#ruby[みず][水]のようになる], [溶ける],
  [#ruby[みず][水]がなくなる], [乾く],
  [#ruby[みず][水]がつく], [濡れる],
  [#ruby[わる][悪]いものがつく], [汚れる],
  [きれいになるようにする], [磨く],
  [#ruby[もの][物]の#ruby[そと][外]を#ruby[ぜんぶ][全部]#ruby[み][見]えないようにする], [包む],
  [#ruby[ふた][二]つの#ruby[もの][物]を#ruby[ひと][一]つに#ruby[と][止]める], [結ぶ],
  [#ruby[て][手]で#ruby[め][目]に#ruby[み][見]えるものを#ruby[つく][作]る], [描く],
)]

=== どんな (基本外の形容詞)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [#ruby[なが][長]くない], [短い],
  [#ruby[たか][高]くない], [低い],
  [#ruby[おも][重]くない], [軽い],
  [#ruby[つよ][強]くない], [弱い],
  [#ruby[はや][速]くない], [遅い],
  [#ruby[あたら][新]しくない], [古い],
  [#ruby[とし][年]が#ruby[すこ][少]ない], [若い],
  [#ruby[おお][大]きな#ruby[ところ][所]だ], [広い],
  [#ruby[ところ][所]が#ruby[ちい][小]さい], [狭い],
  [#ruby[した][下]まで#ruby[なが][長]い], [深い],
  [#ruby[した][下]まで#ruby[なが][長]くない], [浅い],
  [#ruby[なか][中]まで#ruby[なが][長]い], [厚い],
  [#ruby[なか][中]まで#ruby[なが][長]くない], [薄い],
  [#ruby[そと][外]が#ruby[おお][大]きい], [太い],
  [#ruby[そと][外]が#ruby[ちい][小]さい], [細い],
  [#ruby[つき][月]や#ruby[たいよう][太陽]のような#ruby[もの][物]だ], [丸い],
  [#ruby[て][手]で#ruby[か][変]えられない], [固い],
  [#ruby[て][手]で#ruby[か][変]えられる], [柔らかい],
  [#ruby[た][食]べると#ruby[よ][良]いと#ruby[かん][感]じる], [甘い],
  [#ruby[た][食]べると#ruby[す][好]きではないと#ruby[かん][感]じる], [苦い],
  [#ruby[た][食]べると#ruby[ひ][火]のように#ruby[かん][感]じる], [辛い],
  [#ruby[た][食]べると#ruby[へん][変]に#ruby[かん][感]じる], [酸っぱい],
  [#ruby[おと][音]が#ruby[おお][大]きすぎる], [うるさい],
  [#ruby[おと][音]がない], [静か],
  [#ruby[よ][良]いと#ruby[い][言]える], [正しい],
  [できない#ruby[こと][事]が#ruby[おお][多]い], [難しい],
  [すぐにできる], [易しい],
  [することが#ruby[おお][多]すぎる], [忙しい],
  [することがない], [暇],
  [とてもきれいだ], [美しい],
  [きれいではない], [醜い],
  [#ruby[わる][悪]いものがある], [汚い],
  [#ruby[わる][悪]い#ruby[かぜ][風]がある], [臭い],
  [#ruby[からだ][体]が#ruby[わる][悪]く#ruby[かん][感]じる], [痛い],
  [#ruby[ね][寝]たいと#ruby[かん][感]じる], [眠い],
  [#ruby[ほか][他]の#ruby[ひと][人]に#ruby[み][見]られたくないと#ruby[かん][感]じる], [恥ずかしい],
  [あまり#ruby[み][見]ない#ruby[もの][物]だ], [珍しい],
  [#ruby[まえ][前]のことを#ruby[おも][思]って#ruby[よ][良]いと#ruby[かん][感]じる], [懐かしい],
  [とても#ruby[よ][良]い], [素晴らしい],
  [#ruby[よ][良]い#ruby[もの][物]が#ruby[おお][多]い], [豊か],
  [お#ruby[おかね][金]がとても#ruby[すこ][少]ない], [貧しい],
  [#ruby[おお][多]くの#ruby[ひと][人]が#ruby[し][知]っている], [有名],
  [#ruby[おお][多]くのことがある], [複雑],
  [ことが#ruby[すこ][少]ない], [単純],
  [#ruby[こわ][怖]いことがない], [安全],
  [#ruby[わる][悪]いことが#ruby[お][起]こるかもしれない], [危険],
  [できる], [可能],
  [できない], [不可能],
  [#ruby[へん][変]ではない], [普通],
  [ほかと#ruby[ちが][違]う], [特別],
  [#ruby[ぜんぶ][全部]で#ruby[ひと][一]つだけ#ruby[よ][良]い], [最高],
  [#ruby[ぜんぶ][全部]で#ruby[ひと][一]つだけ#ruby[わる][悪]い], [最低],
  [もっと#ruby[ひつよう][必要]ではない], [十分],
  [この#ruby[こと][事]に#ruby[よ][良]い], [適当],
)]

=== #ruby[かんが][考]えの#ruby[こと][事] (抽象概念)

#rounded-table[#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*ミニ本語*][*意味*],
  [その#ruby[ことば][言葉]が#ruby[い][言]うこと], [意味],
  [なぜそうなったかということ], [理由],
  [どうするかということ], [方法],
  [なぜするかということ], [目的],
  [したあとに#ruby[お][起]こること], [結果],
  [それが#ruby[お][起]こる#ruby[まえ][前]にあったもの], [原因],
  [あることが#ruby[ほか][他]のことを#ruby[か][変]えること], [影響],
  [#ruby[ふた][二]つの#ruby[もの][物]や#ruby[ひと][人]が#ruby[ひと][一]つのことに#ruby[はい][入]っていること], [関係],
  [そうなるために#ruby[ひつよう][必要]なこと], [条件],
  [#ruby[いま][今]どうなっているかということ], [状態],
  [どのくらいかということ], [程度],
  [どんな#ruby[もの][物]かということ], [種類],
  [#ruby[わる][悪]いことで#ruby[かんが][考]えなければならないこと], [問題],
  [#ruby[き][聞]かれたことへの#ruby[ことば][言葉]], [答え],
  [#ruby[し][知]りたいことを#ruby[き][聞]くこと], [質問],
  [こういう#ruby[もの][物]だということを#ruby[み][見]せるもの], [例],
  [ある#ruby[とき][時]に#ruby[お][起]こること], [場合],
  [できる#ruby[とき][時]があること], [機会],
  [#ruby[お][起]こるかもしれないということ], [可能性],
  [したことがあるということ], [経験],
  [#ruby[まえ][前]のことを#ruby[こころ][心]に#ruby[も][持]っていること], [記憶],
  [#ruby[み][見]えないものを#ruby[あたま][頭]の#ruby[なか][中]で#ruby[つく][作]ること], [想像],
  [#ruby[み][見]た#ruby[とき][時]に#ruby[かん][感]じたこと], [印象],
  [あることについて#ruby[おも][思]うこと], [意見],
  [#ruby[あたま][頭]の#ruby[なか][中]にあること], [考え],
  [#ruby[こころ][心]で#ruby[かん][感]じること], [気持ち],
  [#ruby[ひと][人]に#ruby[み][見]せる#ruby[からだ][体]と#ruby[ことば][言葉]の#ruby[うご][動]き], [態度],
  [すること], [行動],
  [#ruby[つよ][強]くしようとすること], [努力],
  [しようとしたことができたこと], [成功],
  [しようとしたことができなかったこと], [失敗],
  [#ruby[か][変]わること], [変化],
  [より#ruby[よ][良]くなること], [進歩],
  [もっと#ruby[おお][大]きくなること], [発展],
  [#ruby[い][生]きていること], [命],
  [これから#ruby[お][起]こる#ruby[こと][事]が#ruby[まえ][前]に#ruby[えら][選]ばれているという#ruby[かんが][考]え], [運命],
  [#ruby[つよ][強]く#ruby[うご][動]かすことができること], [力],
  [できることがあること], [能力],
  [とても#ruby[よ][良]くできること], [才能],
  [#ruby[し][知]っていること], [知識],
  [#ruby[ぜんぶ][全部]の#ruby[ひと][人]が#ruby[し][知]っていること], [常識],
  [#ruby[まい][毎]#ruby[にち][日]すること], [習慣],
  [#ruby[ほか][他]の#ruby[ひと][人]に#ruby[い][言]わないこと], [秘密],
  [すると#ruby[い][言]ったこと], [約束],
  [しなければならないと#ruby[おも][思]うこと], [責任],
  [しなければならないこと], [義務],
  [してもいいと#ruby[い][言]われていること], [権利],
  [#ruby[よ][良]いことをするという#ruby[かんが][考]え], [正義],
  [どのくらい#ruby[よ][良]いかということ], [価値],
  [するという#ruby[つよ][強]い#ruby[こころ][心]], [意志],
)]

== #ruby[か][書]いた#ruby[もの][物]を#ruby[ひと][一]つにする (漢字熟語)

#text(size: 9pt, fill: rgb("#666666"))[206語の漢字だけで構成された実在の日本語。]

#note-block[漢字には複数の読み方がある。同じ字でも言葉によって読みが変わる。熟語を丸ごと覚えること。]

=== #ruby[ひと][人] (人と関係)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[おとな][大人]], [大人],
  [#ruby[ひとり][一人]], [一人],
  [#ruby[ふたり][二人]], [二人],
  [#ruby[だんじょ][男女]], [男女],
  [#ruby[だんし][男子]], [男子],
  [#ruby[じょし][女子]], [女子],
  [#ruby[ふぼ][父母]], [父母],
  [#ruby[ふし][父子]], [父子],
  [#ruby[ぼし][母子]], [母子],
  [#ruby[ちょうなん][長男]], [長男],
  [#ruby[ちょうじょ][長女]], [長女],
  [#ruby[しんじん][新人]], [新人],
  [#ruby[ほんにん][本人]], [本人],
  [#ruby[たにん][他人]], [他人],
  [#ruby[ちじん][知人]], [知人],
  [#ruby[めいじん][名人]], [名人],
  [#ruby[あくにん][悪人]], [悪人],
  [#ruby[へんじん][変人]], [変人],
  [#ruby[せいねん][青年]], [青年],
  [#ruby[じんせい][人生]], [人生],
  [#ruby[じんぶつ][人物]], [人物],
  [#ruby[じんこう][人口]], [人口],
  [#ruby[ひとで][人手]], [人手],
  [#ruby[ひとめ][人目]], [人目],
  [#ruby[にほんじん][日本人]], [日本人],
  [#ruby[がいこくじん][外国人]], [外国人],
  [#ruby[こつにく][骨肉]], [骨肉],
  [#ruby[ふくしん][腹心]], [腹心],
)]

=== #ruby[そと][外]の#ruby[もの][物] (自然と地理)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[おおぞら][大空]], [大空],
  [#ruby[あおぞら][青空]], [青空],
  [#ruby[たいぼく][大木]], [大木],
  [#ruby[こだち][木立]], [木立],
  [#ruby[かざん][火山]], [火山],
  [#ruby[こうざん][高山]], [高山],
  [#ruby[やまみち][山道]], [山道],
  [#ruby[さんちゅう][山中]], [山中],
  [#ruby[やまぐち][山口]], [山口],
  [#ruby[ちかみち][近道]], [近道],
  [#ruby[こくどう][国道]], [国道],
  [#ruby[すいどう][水道]], [水道],
  [#ruby[すいちゅう][水中]], [水中],
  [#ruby[かいすい][海水]], [海水],
  [#ruby[かいじょう][海上]], [海上],
  [#ruby[たいかい][大海]], [大海],
  [#ruby[おおあめ][大雨]], [大雨],
  [#ruby[おおみず][大水]], [大水],
  [#ruby[たいか][大火]], [大火],
  [#ruby[かこう][火口]], [火口],
  [#ruby[きょうふう][強風]], [強風],
  [#ruby[きんざん][金山]], [金山],
  [#ruby[えんそく][遠足]], [遠足],
  [#ruby[ほどう][歩道]], [歩道],
  [#ruby[はくちょう][白鳥]], [白鳥],
  [#ruby[こいぬ][小犬]], [子犬],
  [#ruby[こざかな][小魚]], [小魚],
  [#ruby[あまぐも][雨雲]], [雨雲],
  [#ruby[みずどり][水鳥]], [水鳥],
)]

=== #ruby[そら][空]と#ruby[とき][時] (空と時間)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[にっこう][日光]], [日光],
  [#ruby[げっこう][月光]], [月光],
  [#ruby[つきよ][月夜]], [月夜],
  [#ruby[しんげつ][新月]], [新月],
  [#ruby[つきひ][月日]], [月日],
  [#ruby[きょう][今日]], [今日],
  [#ruby[あした][明日]], [明日],
  [#ruby[ぜんじつ][前日]], [前日],
  [#ruby[ごじつ][後日]], [後日],
  [#ruby[まいにち][毎日]], [毎日],
  [#ruby[まいつき][毎月]], [毎月],
  [#ruby[まいとし][毎年]], [毎年],
  [#ruby[しんねん][新年]], [新年],
  [#ruby[ながねん][長年]], [長年],
  [#ruby[ねんじゅう][年中]], [年中],
  [#ruby[としうえ][年上]], [年上],
  [#ruby[としした][年下]], [年下],
  [#ruby[ねんきん][年金]], [年金],
  [#ruby[にっちゅう][日中]], [日中],
  [#ruby[いちにち][一日]], [一日],
  [#ruby[どうじ][同時]], [同時],
  [#ruby[ひゃくねん][百年]], [百年],
  [#ruby[ひゃくにち][百日]], [百日],
)]

=== #ruby[からだ][体] (体)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[てあし][手足]], [手足],
  [#ruby[みぎて][右手]], [右手],
  [#ruby[ひだりて][左手]], [左手],
  [#ruby[みぎあし][右足]], [右足],
  [#ruby[ひだりあし][左足]], [左足],
  [#ruby[じもく][耳目]], [耳目],
  [#ruby[めうえ][目上]], [目上],
  [#ruby[めした][目下]], [目下],
  [#ruby[もくぜん][目前]], [目前],
  [#ruby[あしおと][足音]], [足音],
  [#ruby[ぜんたい][全体]], [全体],
  [#ruby[だいたい][大体]], [大体],
  [#ruby[いったい][一体]], [一体],
  [#ruby[しゅっけつ][出血]], [出血],
  [#ruby[ひにく][皮肉]], [皮肉],
  [#ruby[しらが][白髪]], [白髪],
  [#ruby[けんし][犬歯]], [犬歯],
)]

=== #ruby[もの][物] (物)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[ほんもの][本物]], [本物],
  [#ruby[こうぶつ][好物]], [好物],
  [#ruby[めいぶつ][名物]], [名物],
  [#ruby[しょもつ][書物]], [書物],
  [#ruby[しょくもつ][食物]], [食物],
  [#ruby[さくもつ][作物]], [作物],
  [#ruby[せいぶつ][生物]], [生物],
  [#ruby[ふうぶつ][風物]], [風物],
  [#ruby[かなもの][金物]], [金物],
  [#ruby[きもの][着物]], [着物],
  [#ruby[のみもの][飲み物]], [飲み物],
  [#ruby[かいもの][買い物]], [買い物],
  [#ruby[よみもの][読み物]], [読み物],
  [#ruby[もちもの][持ち物]], [持ち物],
  [#ruby[ものおと][物音]], [物音],
  [#ruby[けんぶつ][見物]], [見物],
  [#ruby[きんぎょ][金魚]], [金魚],
  [#ruby[とりにく][鳥肉]], [鳥肉],
  [#ruby[ぎょにく][魚肉]], [魚肉],
  [#ruby[にくしょく][肉食]], [肉食],
  [#ruby[なまたまご][生卵]], [生卵],
)]

=== #ruby[て][手] (手の熟語)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[てほん][手本]], [手本],
  [#ruby[てまえ][手前]], [手前],
  [#ruby[じょうず][上手]], [上手],
  [#ruby[へた][下手]], [下手],
  [#ruby[きって][切手]], [切手],
  [#ruby[にゅうしゅ][入手]], [入手],
  [#ruby[せんしゅ][選手]], [選手],
  [#ruby[じょしゅ][助手]], [助手],
  [#ruby[ちゃくしゅ][着手]], [着手],
)]

=== #ruby[はい][入]ると#ruby[で][出]る (入と出)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[いりぐち][入口]], [入口],
  [#ruby[でぐち][出口]], [出口],
  [#ruby[でいり][出入]], [出入],
  [#ruby[にゅうきん][入金]], [入金],
  [#ruby[しゅっきん][出金]], [出金],
  [#ruby[がいしゅつ][外出]], [外出],
  [#ruby[しんにゅう][新入]], [新入],
  [#ruby[たちいり][立入]], [立入],
)]

=== #ruby[ほん][本]と#ruby[か][書]く (本と書)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[にほん][日本]], [日本],
  [#ruby[ほんみょう][本名]], [本名],
  [#ruby[ほんしん][本心]], [本心],
  [#ruby[みほん][見本]], [見本],
  [#ruby[きょうほん][教本]], [教本],
  [#ruby[とくほん][読本]], [読本],
  [#ruby[どくしょ][読書]], [読書],
  [#ruby[おんどく][音読]], [音読],
  [#ruby[しんぶん][新聞]], [新聞],
  [#ruby[かいわ][会話]], [会話],
)]

=== #ruby[くに][国] (国と政治)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[がいこく][外国]], [外国],
  [#ruby[たいこく][大国]], [大国],
  [#ruby[ぜんこく][全国]], [全国],
  [#ruby[こくりつ][国立]], [国立],
  [#ruby[こくがい][国外]], [国外],
  [#ruby[こくめい][国名]], [国名],
  [#ruby[かいがい][海外]], [海外],
)]

=== #ruby[こころ][心]と#ruby[かん][感]じ (心と感情)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[ちゅうしん][中心]], [中心],
  [#ruby[かんしん][感心]], [感心],
  [#ruby[かんどう][感動]], [感動],
  [#ruby[きもち][気持ち]], [気持ち],
  [#ruby[おもいで][思い出]], [思い出],
  [#ruby[どうかん][同感]], [同感],
)]

=== #ruby[うご][動]くと#ruby[か][変]わる (動きと変化)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[どうさ][動作]], [動作],
  [#ruby[へんどう][変動]], [変動],
  [#ruby[かいし][開始]], [開始],
  [#ruby[かいへい][開閉]], [開閉],
  [#ruby[しじゅう][始終]], [始終],
  [#ruby[せいし][生死]], [生死],
  [#ruby[できごと][出来事]], [出来事],
  [#ruby[ひこう][飛行]], [飛行],
  [#ruby[どうこう][同行]], [同行],
)]

=== #ruby[おお][大]きい (大きい熟語)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[だいじ][大事]], [大事],
  [#ruby[たいせつ][大切]], [大切],
  [#ruby[たいへん][大変]], [大変],
  [#ruby[たいきん][大金]], [大金],
  [#ruby[おおや][大家]], [大家],
  [#ruby[たいし][大使]], [大使],
)]

=== #ruby[ほか][他] (その他)

#rounded-table[#table(
  columns: (1fr, 2fr),
  stroke: none,
  inset: (x: 8pt, y: 6pt),
  fill: (_, row) => if calc.even(row) { rgb("#F7F7F7") },
  table.header[*言葉*][*意味*],
  [#ruby[しょくじ][食事]], [食事],
  [#ruby[かじ][火事]], [火事],
  [#ruby[ちじ][知事]], [知事],
  [#ruby[きんいろ][金色]], [金色],
  [#ruby[みずいろ][水色]], [水色],
  [#ruby[ねいろ][音色]], [音色],
  [#ruby[もくめ][木目]], [木目],
  [#ruby[めいもく][名目]], [名目],
  [#ruby[めいはく][明白]], [明白],
  [#ruby[たしょう][多少]], [多少],
  [#ruby[がいけん][外見]], [外見],
  [#ruby[うわぎ][上着]], [上着],
  [#ruby[したぎ][下着]], [下着],
  [#ruby[あまおと][雨音]], [雨音],
  [#ruby[いっしょう][一生]], [一生],
  [#ruby[せいぜん][生前]], [生前],
  [#ruby[ひとめ][一目]], [一目],
  [#ruby[ひとこと][一言]], [一言],
  [#ruby[あたまきん][頭金]], [頭金],
  [#ruby[ことり][小鳥]], [小鳥],
  [#ruby[こいし][小石]], [小石],
  [#ruby[こみち][小道]], [小道],
  [#ruby[こさめ][小雨]], [小雨],
  [#ruby[うんかい][雲海]], [雲海],
  [#ruby[ひゃくにん][百人]], [百人],
  [#ruby[こびと][小人]], [小人],
  [#ruby[すいぶん][水分]], [水分],
  [#ruby[たぶん][多分]], [多分],
  [#ruby[じゅうぶん][十分]], [十分],
)]

#pagebreak(weak: true)

= 読み物

== #ruby[はな][話]し (対話)

=== #ruby[まい][毎]#ruby[にち][日]の#ruby[はな][話]し (日常の対話)

#dialog-block[#ruby[か][買]う#ruby[ところ][所]で (店で)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。この#ruby[た][食]べ#ruby[もの][物]は#ruby[なに][何]ですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* これは#ruby[よ][良]い#ruby[た][食]べ#ruby[もの][物]です。#ruby[みず][水]と#ruby[くさ][草]で#ruby[つく][作]りました。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* これをください。#ruby[ほか][他]の#ruby[もの][物]もありますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。そこに#ruby[あたら][新]しい#ruby[もの][物]があります。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それも#ruby[み][見]てもいいですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。#ruby[て][手]で#ruby[も][持]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* これを#ruby[か][買]います。ありがとう。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* ありがとう。また#ruby[き][来]てください。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* すみません。この食べ物は何ですか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* これはおいしい食べ物です。水と野菜で作りました。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* これをください。他の物もありますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* はい。あちらに新しい品物があります。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* それも見てもいいですか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* はい。手に取ってご覧ください。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* これを買います。ありがとうございます。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* ありがとうございます。またお越しください。]]

#dialog-block[#ruby[みち][道]で#ruby[ひと][人]と#ruby[あ][会]う (道で友人に会う)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* あ！どこに#ruby[い][行]きますか？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[いま][今]は#ruby[うみ][海]に#ruby[い][行]きます。あなたは？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]は#ruby[いえ][家]に#ruby[く][来]る。#ruby[からだ][体]が#ruby[すこ][少]し#ruby[わる][悪]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[からだ][体]が#ruby[わる][悪]いですか？#ruby[みず][水]を#ruby[の][飲]んで、#ruby[ね][寝]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとう。#ruby[うみ][海]の#ruby[かぜ][風]はとても#ruby[よ][良]いね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そうだね。でも#ruby[いま][今]は#ruby[かぜ][風]が#ruby[つよ][強]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[よ][良]く#ruby[まも][守]ってください。また#ruby[あ][会]おう！]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、また#ruby[あ][会]おう！]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* あ！どこに行くんですか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 今から海に行くところです。あなたは？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 私は家に帰ります。体の調子が少し悪いんです。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 体調が悪いんですか？水を飲んで、休んでください。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* ありがとうございます。海の空気はとても気持ちいいですよね。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* そうですね。でも今日は風が強いです。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* お気をつけて。また会いましょう！]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* はい、また会いましょう！]]

#dialog-block[#ruby[いえ][家]の#ruby[よる][夜]の#ruby[た][食]べ#ruby[もの][物] (家族の夕食)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[すわ][座]ってください。#ruby[た][食]べ#ruby[もの][物]ができた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[いま][今]は#ruby[なに][何]を#ruby[た][食]べる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[くさ][草]と#ruby[みず][水]で#ruby[つく][作]った。#ruby[からだ][体]に#ruby[よ][良]い。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* とても#ruby[よ][良]い#ruby[もの][物]だね。#ruby[いま][今]まで#ruby[からだ][体]がとても#ruby[おも][重]かった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[ちち][父]、#ruby[いま][今]の#ruby[にち][日]は#ruby[たの][楽]しかったか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* まあまあだった。でも#ruby[いえ][家]に#ruby[く][来]ることがもっと#ruby[す][好]きだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* この#ruby[もの][物]を#ruby[ぜんぶ][全部]#ruby[た][食]べてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい！とても#ruby[よ][良]い。ありがとう、#ruby[はは][母]。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*母:* 座ってください。ご飯ができましたよ。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* 今日は何を食べるの？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*母:* 野菜と水で作りました。体にいいですよ。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*父:* とてもおいしそうですね。最近ずっと体が重かったんです。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* お父さん、今日は楽しかった？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*父:* まあまあだったよ。でも家に帰るのが一番好きだ。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*母:* これを全部食べてくださいね。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* うん！とてもおいしい。ありがとう、お母さん。]]

#dialog-block[#ruby[みち][道]を#ruby[き][聞]く (道を尋ねる)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* すみません。#ruby[おお][大]きい#ruby[おお][大]きい#ruby[いえ][家]はどこですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* ここから#ruby[とお][遠]いです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* どう#ruby[い][行]ったらいいですか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* この#ruby[みち][道]を#ruby[い][行]ってください。#ruby[おお][大]きい#ruby[き][木]の#ruby[まえ][前]で#ruby[みぎ][右]に#ruby[はい][入]ってください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[き][木]の#ruby[まえ][前]で#ruby[みぎ][右]だね。その#ruby[あと][後]は？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[おお][大]きい#ruby[いえ][家]を#ruby[み][見]ることができます。それです。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ある][歩]いて#ruby[い][行]けますか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、#ruby[ある][歩]いて#ruby[い][行]けます。#ruby[とお][遠]いですが、#ruby[よ][良]い#ruby[みち][道]だ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* ありがとう！]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* すみません。大きい建物はどこですか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* ここからは近くないですよ。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* どう行ったらいいですか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* この道をまっすぐ行ってください。大きな木のところで右に曲がってください。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 木のところで右ですね。その後は？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 建物が見えます。それです。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 歩いて行けますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* はい、歩いて行けます。近くはないですが、いい道ですよ。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* ありがとうございます！]]

#dialog-block[#ruby[にち][日]の#ruby[はじ][始]まり (朝の日課)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* もう#ruby[た][立]ってください！#ruby[にち][日]が#ruby[で][出]ている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* まだ#ruby[め][目]が#ruby[おも][重]い。もう#ruby[すこ][少]し#ruby[ね][寝]たい。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* いけない。#ruby[はや][速]く#ruby[ふく][服]を#ruby[き][着]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい。でも#ruby[いま][今]は#ruby[そら][空]が#ruby[あか][明]るくない。#ruby[あめ][雨]が#ruby[く][来]るか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* そうだね。#ruby[そと][外]は#ruby[すこ][少]し#ruby[さむ][寒]いから、#ruby[よ][良]い#ruby[ふく][服]を#ruby[き][着]てください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[いま][今]は#ruby[なに][何]を#ruby[た][食]べる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[はは][母]:* #ruby[みず][水]と#ruby[た][食]べ#ruby[もの][物]がある。#ruby[ぜんぶ][全部]#ruby[た][食]べてください。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* はい、#ruby[はは][母]。#ruby[いま][今]の#ruby[にち][日]も#ruby[たの][楽]しいと#ruby[おも][思]う！]][#block(inset: (top: 0.05em, bottom: 0.05em))[*母:* もう起きなさい！日が出ていますよ。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* まだ眠いよ。もう少し寝たい。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*母:* だめです。早く服を着なさい。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* はい。でも今日は空が暗いね。雨が降るかな。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*母:* そうね。外は少し寒いから、暖かい服を着てね。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* 今朝は何を食べるの？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*母:* お水とご飯があるよ。全部食べてね。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* はい、お母さん。今日も楽しい日になると思う！]]

=== #ruby[かんが][考]える#ruby[はな][話]し (思索の対話)

#dialog-block[#ruby[い][生]きるとは#ruby[なに][何]か (生きるとは何か)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[いし][石]は#ruby[うご][動]かない。#ruby[くさ][草]は#ruby[うご][動]く。#ruby[なに][何]が#ruby[い][生]き#ruby[もの][物]を#ruby[い][生]きている#ruby[もの][物]にする？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[うご][動]くだけじゃない。#ruby[みず][水]も#ruby[うご][動]く。#ruby[ひ][火]も#ruby[うご][動]く。でもそれは#ruby[い][生]きていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* じゃあ#ruby[なに][何]だ？#ruby[い][生]き#ruby[もの][物]には#ruby[なに][何]があって#ruby[いし][石]にはない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[い][生]きる#ruby[かぜ][風]だ。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]が#ruby[い][生]き#ruby[もの][物]に#ruby[い][生]きる#ruby[かぜ][風]を#ruby[あた][与]えた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[い][生]きる#ruby[かぜ][風]？#ruby[わたし][私]たちが#ruby[の][飲]む#ruby[かぜ][風]と#ruby[おな][同]じ？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* でも#ruby[ちが][違]う#ruby[かぜ][風]だ。それがないと#ruby[からだ][体]は#ruby[つち][土]と#ruby[みず][水]だけだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ぜんぶ][全部]の#ruby[い][生]き#ruby[もの][物]に#ruby[い][生]きる#ruby[かぜ][風]がある。でも#ruby[ひと][人]は#ruby[ほか][他]の#ruby[い][生]き#ruby[もの][物]と#ruby[ちが][違]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]は#ruby[ひと][人]をその#ruby[ひと][人]に#ruby[ちか][近]く#ruby[つく][作]った。だから#ruby[ひと][人]は#ruby[ぜんぶ][全部]の#ruby[い][生]き#ruby[もの][物]の#ruby[なか][中]でもっとも#ruby[おお][大]きい。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 石は動かない。草は動く。何が生き物を生かしているんだろう？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 動くだけではない。水も動く。火も動く。でもそれは生きていない。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* では何だろう？生き物には何があって石にはないのか？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 命の息だ。すべてを造った方が生き物に命の息を与えた。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 命の息？私たちが吸う空気と同じ？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* しかし特別な息だ。それがなければ体はただの土と水にすぎない。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* すべての生き物に命の息がある。しかし人間は他の生き物と違うのか？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* そう。すべてを造った方は人間を御自身に近く造った。だから人間はすべての生き物の中でもっとも尊い。]]

#dialog-block[#ruby[よる][夜]の#ruby[ひかり][光] (夜の光)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[よる][夜]の#ruby[そら][空]の#ruby[ひかり][光]は#ruby[なん][何]だと#ruby[おも][思]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* あの#ruby[ひかり][光]は#ruby[ぜんぶ][全部]の#ruby[はじ][始]まりの#ruby[とき][時]に#ruby[そら][空]に#ruby[あた][与]えられた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[はじ][始]まりの#ruby[とき][時]に？#ruby[ひと][人]より#ruby[まえ][前]に？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]が#ruby[そら][空]と#ruby[つち][土]を#ruby[つく][作]った#ruby[あと][後]に#ruby[そら][空]に#ruby[ひかり][光]を#ruby[あた][与]えた。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* じゃああの#ruby[ひかり][光]は#ruby[ひかり][光]だけじゃない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[み][見]#ruby[まも][守]る#ruby[もの][物]だ。#ruby[そら][空]に#ruby[あた][与]えられた#ruby[つか][使]いだ。#ruby[うえ][上]から#ruby[わたし][私]たちを#ruby[み][見]#ruby[まも][守]っている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[うえ][上]からの#ruby[つか][使]い？#ruby[はじ][始]まりの#ruby[とき][時]からそこにいる？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そう。#ruby[つち][土]と#ruby[うみ][海]が#ruby[つく][作]られた#ruby[とき][時]から#ruby[か][変]わっていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* だから#ruby[まい][毎]#ruby[よる][夜]#ruby[か][変]わらない#ruby[ひかり][光]がある。いつも#ruby[うえ][上]から#ruby[み][見]#ruby[まも][守]っている。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 夜空の光は何だと思う？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* あの光はすべての始まりの時に空に置かれたものだ。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 始まりの時に？人よりも前に？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* そう。すべてを造った方が天と地を造った後に空に光を置いた。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* ではあの光はただの光ではないのか？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 見守る者だ。天に遣わされた使いだ。上から私たちを見守っている。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 天からの使い？始まりの時からそこにいるのか？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* そう。大地と海が造られた時から変わっていない。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* だから毎晩変わらない光がある。いつも上から見守っている。]]

#dialog-block[なぜ#ruby[ひと][人]は#ruby[たたか][戦]うの？ (なぜ人は戦うのか)][#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[ちち][父]さん、なぜ#ruby[ひと][人]は#ruby[たたか][戦]うの？#ruby[たたか][戦]うと#ruby[かな][悲]しいことが#ruby[お][起]こるのに。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* そうだね。#ruby[ひと][人]は#ruby[こわ][怖]い#ruby[とき][時]に#ruby[す][好]きな#ruby[もの][物]を#ruby[まも][守]りたくなる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* でも#ruby[たたか][戦]って#ruby[まも][守]れるの？#ruby[たたか][戦]うともっと#ruby[かな][悲]しいことが#ruby[お][起]こる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* #ruby[ほんとう][本当]にそうだ。#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[つよ][強]い#ruby[まも][守]り#ruby[かた][方]は#ruby[す][好]きでいることだ。#ruby[わたし][私]を#ruby[す][好]きなように#ruby[ほか][他]の#ruby[ひと][人]も#ruby[す][好]きでいること。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* でも#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]は？#ruby[たたか][戦]いに#ruby[く][来]る#ruby[ひと][人]は？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* その#ruby[ひと][人]たちもだ。#ruby[わたし][私]に#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]も#ruby[す][好]きでいる。それが#ruby[ひと][人]にできる#ruby[ぜんぶ][全部]の#ruby[なか][中]で#ruby[ひと][一]つだけ#ruby[つよ][強]い#ruby[こと][事]だ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[こども][子供]:* #ruby[わたし][私]に#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]を#ruby[す][好]きでいるの？それはとてもできにくいと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*#ruby[ちち][父]:* できにくい。でも#ruby[ぜんぶ][全部]を#ruby[つく][作]った#ruby[ひと][人]がそう#ruby[い][言]った。#ruby[わたし][私]を#ruby[す][好]きなように#ruby[ほか][他]の#ruby[ひと][人]を#ruby[す][好]きでいなさい。#ruby[わる][悪]い#ruby[こと][事]をする#ruby[ひと][人]も。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* お父さん、なぜ人は戦うの？戦うと悲しいことが起こるのに。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*父:* そうだね。人は怖い時に大切なものを守りたくなる。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* でも戦って守れるの？戦うともっと悲しいことが起こる。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*父:* 本当にそうだ。最も強い守り方は愛することだ。自分を愛するように他の人も愛すること。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* でも悪いことをする人は？攻めてくる人は？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*父:* その人たちもだ。自分に敵対する人をも愛する。それが人にできる最も強いことだ。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*子供:* 自分に敵対する人を愛するの？それはとても難しいと思う。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*父:* 難しい。でもすべてを造った方がそう言われた。自分を愛するように隣人を愛しなさい。敵をも。]]

#dialog-block[#ruby[ひと][人]だけが#ruby[も][持]つ#ruby[もの][物] (人だけが持つもの)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[どうぶつ][動物]も#ruby[た][食]べて、#ruby[の][飲]んで、#ruby[こども][子供]を#ruby[まも][守]る。#ruby[ひと][人]と#ruby[ほんとう][本当]に#ruby[ちが][違]う？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ひと][人]は#ruby[か][書]く。#ruby[あ][会]ったことのない#ruby[ひと][人]に#ruby[ことば][言葉]を#ruby[あた][与]える。#ruby[し][死]んだ#ruby[あと][後]も。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それは#ruby[おお][大]きい。#ruby[どうぶつ][動物]は#ruby[いま][今]に#ruby[い][生]きる。#ruby[ひと][人]は#ruby[まえ][前]と#ruby[あと][後]に#ruby[い][生]きる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ひと][人]は#ruby[うご][動]く#ruby[もの][物]も#ruby[つく][作]る。#ruby[て][手]でできないことを#ruby[うご][動]く#ruby[もの][物]でできるようにする。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* でも#ruby[いし][石]を#ruby[つか][使]う#ruby[どうぶつ][動物]もいる。#ruby[ひと][人]だけが#ruby[もの][物]を#ruby[つか][使]うのではない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[もの][物]を#ruby[つか][使]うことと、#ruby[もの][物]について#ruby[かんが][考]えることは#ruby[ちが][違]う。#ruby[ひと][人]は#ruby[み][見]えない#ruby[こと][事]を#ruby[かんが][考]える。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[み][見]えない#ruby[こと][事]？　どんな#ruby[こと][事]？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* 「なぜ#ruby[い][生]きるのか」。#ruby[どうぶつ][動物]はこれを#ruby[き][聞]かない。#ruby[ひと][人]だけが#ruby[き][聞]く。それが#ruby[よ][良]いことか#ruby[わる][悪]いことかは、まだ#ruby[し][知]らない。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 動物も食べて、飲んで、子供を守る。人間と本当に違うのか？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 人は書く。会ったことのない人に言葉を届ける。死んだ後も。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* それは大きな違いだ。動物は今を生きる。人は過去と未来を生きる。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 人は機械も作る。手ではできないことを機械で可能にする。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* でも石を使う動物もいる。人だけが道具を使うわけではない。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 道具を使うことと、道具について考えることは違う。人は目に見えないことを考える。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 見えないこと？　どんなこと？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 「なぜ生きるのか」。動物はこの問いを持たない。人だけが問う。それが良いことか悪いことかは、まだ分からない。]]

#dialog-block[#ruby[とき][時]について (時について)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[ところ][所]に#ruby[き][来]て、#ruby[おお][多]い#ruby[とし][年]が#ruby[お][終]わった。あの#ruby[き][木]は#ruby[まえ][前]に#ruby[ちい][小]さかった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[き][木]は#ruby[か][変]わった。でも#ruby[やま][山]は#ruby[か][変]わっていない。#ruby[とき][時]は#ruby[もの][物]によって#ruby[ちが][違]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]たちも#ruby[か][変]わった。#ruby[からだ][体]が#ruby[か][変]わった。でも……#ruby[こころ][心]の#ruby[なか][中]はどうだろう。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[こども][子供]の#ruby[とき][時]に#ruby[かん][感]じた#ruby[こと][事]は、まだ#ruby[こころ][心]の#ruby[なか][中]にある。#ruby[か][変]わっていない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[とき][時]は#ruby[まえ][前]に#ruby[うご][動]くだけ？　#ruby[まえ][前]に#ruby[い][行]くことはできない？]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[からだ][体]は#ruby[まえ][前]に#ruby[い][行]けない。でも#ruby[こころ][心]は#ruby[い][行]ける。#ruby[ほん][本]の#ruby[なか][中]で、#ruby[め][目]を#ruby[し][閉]めた#ruby[なか][中]で。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* それなら#ruby[とき][時]は#ruby[ふた][二]つある。#ruby[からだ][体]の#ruby[とき][時]と、#ruby[こころ][心]の#ruby[とき][時]と。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* そして#ruby[わたし][私]たちが#ruby[し][死]んだ#ruby[あと][後]も、あなたと#ruby[わたし][私]が#ruby[かん][感]じた#ruby[こと][事]は#ruby[ほか][他]の#ruby[ひと][人]の#ruby[こころ][心]の#ruby[なか][中]で#ruby[い][生]きるかもしれない。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* この場所に来てから、何年も過ぎた。あの木は昔は小さかった。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 木は変わった。でも山は変わっていない。時の流れはものによって違う。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 私たちも変わった。体が変わった。でも……心の中はどうだろう。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 子供の頃に感じたことは、まだ心の中にある。変わっていない。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 時間は前に進むだけ？　過去に戻ることはできない？]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 体は戻れない。でも心は戻れる。本の中で、目を閉じた時に。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* それなら時間は二つある。体の時間と、心の時間と。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* そして私たちが死んだ後も、あなたと私が感じたことは他の人の心の中で生き続けるかもしれない。]]

#dialog-block[#ruby[し][知]ること (知ること)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[おし][教]える#ruby[ひと][人]、#ruby[ほん][本]を#ruby[よ][読]んだら、その#ruby[こと][事]を#ruby[し][知]っていると#ruby[い][言]えるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ほん][本]の#ruby[ことば][言葉]は#ruby[し][知]ることができる。でも、#ruby[ほんとう][本当]に#ruby[し][知]ることは#ruby[ちが][違]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* どう#ruby[ちが][違]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[て][手]で#ruby[つく][作]ったり、#ruby[からだ][体]で#ruby[かん][感]じたりしたとき、#ruby[ほんとう][本当]に#ruby[し][知]る#ruby[こと][事]が#ruby[はじ][始]まる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* では、#ruby[わたし][私]はまだ#ruby[し][知]らないのか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[し][知]りたいと#ruby[おも][思]っているなら、もう#ruby[はじ][始]まっている。それで#ruby[よ][良]いと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[し][知]ることは#ruby[お][終]わるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[よ][良]い#ruby[おし][教]える#ruby[ひと][人]も、まだ#ruby[し][知]らない#ruby[こと][事]がとても#ruby[おお][多]いと#ruby[かん][感]じている。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 先生、本を読んだら、そのことを知っていると言えますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 本の言葉は知ることができます。でも、本当に知るということは違います。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* どう違いますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 手で作ったり、体で感じたりした時、本当に知ることが始まります。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* では、私はまだ知らないのですか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 知りたいと思っているなら、もう始まっています。それで十分だと思います。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 知ることに終わりはありますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 良い先生でも、まだ知らないことがとても多いと感じています。]]

#dialog-block[#ruby[うみ][海]の#ruby[そと][外] (海の向こう)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[うみ][海]はとても#ruby[おお][大]きいね。#ruby[そと][外]に#ruby[なに][何]があるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ほか][他]の#ruby[くに][国]がある。でも#ruby[め][目]では#ruby[み][見]えない。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* その#ruby[くに][国]の#ruby[ひと][人]たちも、この#ruby[みず][水]を#ruby[み][見]ていると#ruby[おも][思]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい、#ruby[ぜんぶ][全部]#ruby[ひと][一]つの#ruby[みず][水]だ。#ruby[うみ][海]は#ruby[ひと][一]つだと#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[みず][水]の#ruby[なか][中]に#ruby[なに][何]がいるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[どうぶつ][動物]が#ruby[おお][多]くいる。#ruby[わたし][私]たちが#ruby[し][知]らない#ruby[どうぶつ][動物]も、まだいると#ruby[おも][思]う。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[うみ][海]は#ruby[こわ][怖]いか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[こわ][怖]い。でも#ruby[うみ][海]の#ruby[おと][音]を#ruby[き][聞]くと、#ruby[こころ][心]が#ruby[よ][良]くなる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[わたし][私]もそう#ruby[かん][感]じる。#ruby[おお][大]きい#ruby[もの][物]の#ruby[まえ][前]に#ruby[た][立]つと、#ruby[こころ][心]が#ruby[ちい][小]さくなる。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* この海はとても大きいですね。向こうに何がありますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 他の国があります。でも目では見えません。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* その国の人たちも、この海を見ていると思いますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* はい、すべて一つの海です。海はつながっていると思います。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 海の中に何がいますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* たくさんの生き物がいます。私たちがまだ知らない生き物もいると思います。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 海は怖いですか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 怖いです。でも波の音を聞くと、心が穏やかになります。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 私もそう感じます。大きなものの前に立つと、自分が小さく感じられます。]]

#dialog-block[#ruby[あたら][新]しいものと#ruby[まえ][前]のもの (新しいものと古いもの)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* この#ruby[くに][国]はとても#ruby[か][変]わったね。#ruby[まえ][前]は#ruby[ちが][違]った。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* はい。#ruby[あたら][新]しい#ruby[おお][大]きい#ruby[いえ][家]が#ruby[おお][多]くなった。#ruby[まえ][前]からある#ruby[いえ][家]は#ruby[すく][少]なくなった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[まえ][前]からある#ruby[みち][道]も#ruby[か][変]わった。#ruby[まえ][前]は#ruby[き][木]が#ruby[おお][多]かった。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[あたら][新]しいものは#ruby[よ][良]いか、#ruby[わる][悪]いか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[あたら][新]しい#ruby[うご][動]く#ruby[もの][物]で、#ruby[ひと][人]がする#ruby[こと][事]が#ruby[はや][速]くなった。でも#ruby[まえ][前]にしていた#ruby[こと][事]を#ruby[し][知]っている#ruby[ひと][人]が#ruby[すく][少]なくなっている。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ことば][言葉]も#ruby[か][変]わる。#ruby[まえ][前]の#ruby[ひと][人]たちの#ruby[ことば][言葉]は#ruby[いま][今]もあるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ほん][本]の#ruby[なか][中]にある。でも#ruby[つか][使]う#ruby[ひと][人]は#ruby[すこ][少]しだけだ。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[か][変]わらない#ruby[こと][事]はあるか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[やま][山]と#ruby[うみ][海]はまだ#ruby[か][変]わらない。#ruby[たいよう][太陽]も#ruby[まい][毎]#ruby[にち][日]#ruby[で][出]る。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* この国はとても変わりましたね。昔とは違います。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* はい。新しい建物が増えました。昔からある家は少なくなりました。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 昔からある道も変わりました。以前は木が多かったです。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 新しいものは良いですか、悪いですか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 新しい機械のおかげで、物事が速くなりました。でも昔のやり方を知っている人が少なくなっています。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 言葉も変わります。昔の人たちの言葉は今も残っていますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 本の中にあります。でも使う人はごくわずかです。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 変わらないものはありますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 山と海はまだ変わりません。太陽も毎日昇ります。]]

#dialog-block[#ruby[おと][音]と#ruby[こころ][心] (音楽と心)][#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* あの#ruby[ひと][人]が#ruby[つく][作]った#ruby[おと][音]を#ruby[き][聞]くと、#ruby[かな][悲]しくなる。なぜか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[わたし][私]もそう#ruby[かん][感]じる。その#ruby[おと][音]は#ruby[なに][何]かを#ruby[かん][感]じさせる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[ことば][言葉]は#ruby[つか][使]っていない。でも#ruby[こころ][心]に#ruby[はい][入]る。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ことば][言葉]より#ruby[まえ][前]に、#ruby[からだ][体]が#ruby[かん][感]じると#ruby[おも][思]う。#ruby[あめ][雨]の#ruby[おと][音]や#ruby[かぜ][風]の#ruby[おと][音]も、#ruby[こころ][心]を#ruby[うご][動]かす。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* では、#ruby[ひと][人]が#ruby[つく][作]る#ruby[おと][音]と#ruby[やま][山]や#ruby[うみ][海]の#ruby[おと][音]は#ruby[ちが][違]うか。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[ちが][違]うと#ruby[おも][思]う。#ruby[ひと][人]が#ruby[つく][作]る#ruby[おと][音]の#ruby[なか][中]には、その#ruby[ひと][人]の#ruby[こころ][心]がある。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* #ruby[かな][悲]しい#ruby[おと][音]を#ruby[き][聞]いて、なぜ#ruby[たの][楽]しいと#ruby[かん][感]じるか。#ruby[へん][変]だね。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*B:* #ruby[かな][悲]しさを#ruby[かん][感]じていい、と#ruby[おも][思]えるからかもしれない。#ruby[ひと][一]りじゃないと#ruby[かん][感]じる。]
#block(inset: (top: 0.1em, bottom: 0.1em))[*A:* その#ruby[おと][音]を#ruby[つく][作]った#ruby[ひと][人]も、その#ruby[かな][悲]しさを#ruby[し][知]っていたのだね。]][#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* あの人が作った音楽を聞くと、悲しくなります。なぜでしょうか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 私もそう感じます。その音は何かを呼び起こします。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 言葉は使っていません。でも心に届きます。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 言葉より先に、体が感じるのだと思います。雨の音や風の音も、心を動かします。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* では、人が作る音と自然の音は違いますか。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 違うと思います。人が作る音の中には、その人の心が込められています。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* 悲しい音楽を聞いて、なぜ心地よいと感じるのでしょう。不思議ですね。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*B:* 悲しさを感じてもいいのだ、と思えるからかもしれません。一人じゃないと感じられるのです。]
#block(inset: (top: 0.05em, bottom: 0.05em))[*A:* その音楽を作った人も、同じ悲しみを知っていたのですね。]]

== #ruby[なが][長]くない#ruby[はな][話]し (短編)

#story-block[#ruby[やま][山] (山)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[ひと][一]りで#ruby[やま][山]に#ruby[い][行]った。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[こころ][心]の#ruby[なか][中]で、#ruby[なに][何]かが#ruby[か][変]わった。]][私は一人で山に行った。道は長く、石が多かった。足が重くなった。でも止まらなかった。上に行くと、風が強くなった。空はとても明るくて、太陽の光がすべてのものに降り注いでいた。私は座って、眼下の海を眺めた。家のことを思った。母のことを思った。去年は辛いことが多かった。でも今、山の上では、そのことが小さく感じられた。風が吹いて、私の体を通り抜けていった。私は目を閉じた。心の中で、何かが変わった。]

#story-block[#ruby[ふた][二]つの#ruby[くに][国] (二つの国)][#block(inset: (top: 0.15em, bottom: 0.15em))[ある#ruby[くに][国]の#ruby[ひと][人]は#ruby[うみ][海]の#ruby[ちか][近]くにいた。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[つき][月]が#ruby[そら][空]に#ruby[で][出]ていた。#ruby[ふた][二]つの#ruby[くに][国]から#ruby[み][見]ても、#ruby[ひと][一]つの#ruby[つき][月]だ。]][ある国の人々は海の近くに暮らしていた。もう一つの国の人々は山の中に暮らしていた。海の国の人々は水をよく知っていた。山の国の人々は土と木をよく知っていた。ある日、一人の男が山を出て、海まで歩いていった。海辺では一人の女が水のそばに座っていた。男は海を見た。怖かった。女は男の目を見て、笑った。「怖くないですよ」と女は言った。「入ってみてください。」男は少し入った。水はとても冷たかった。二人の言葉は違っていた。でも笑いは同じだった。夜、二人は火のそばに座って、一緒に食事をした。月が空に出ていた。二つの国から見ても、月は一つだった。]

#story-block[#ruby[おお][大]きい#ruby[き][木] (大きな木)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[やま][山]の#ruby[なか][中]に#ruby[ひと][一]つの#ruby[おお][大]きい#ruby[き][木]があった。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[き][木]も#ruby[なに][何]も#ruby[い][言]わなかった。でも#ruby[ふた][二]つの#ruby[こころ][心]は#ruby[ひと][一]つになった。]][山の中に一本の大きな木があった。その木はとても長い時を生きてきた。木は多くの雨を知っていた。多くの風を感じてきた。子供たちがやって来て、木の上で遊んだ。その子供たちは大きくなって、去っていった。戦いがあった。人々は木のそばで泣いた。木は動かなかった。ただ立っていた。動物たちが木の中に入って、眠った。花が毎年木のそばに咲いた。そして散った。でも木はまだここにある。ある夜、一人の女がやって来た。女は木に手を当てて、何も言わなかった。木も何も言わなかった。でも二つの心は一つになった。]

#story-block[#ruby[こども][子供]の「なぜ」 (子供の「なぜ」)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[こども][子供]はいつも「なぜ？」と#ruby[き][聞]いた。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちち][父]はその#ruby[こと][事]を#ruby[かん][感]じて、#ruby[わら][笑]った。]][子供はいつも「なぜ？」と聞いた。「なぜ空は青いの？」と父に聞いた。父は「光だよ」と言った。「なぜ光は青くなるの？」と子供は言った。父は考えた。「空気だよ」と言った。「なぜ空気はそこにあるの？」父は口を閉じた。「なぜ私は生きているの？」と子供は言った。父は子供を見つめた。夜になって、二人は外に出た。空にたくさんの光があった。子供は「きれい」と言った。今度は「なぜ」とは言わなかった。父はそれを感じて、微笑んだ。]

#story-block[#ruby[いぬ][犬]と#ruby[とり][鳥] (犬と鳥)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]の#ruby[いぬ][犬]は#ruby[まい][毎]#ruby[にち][日]#ruby[そと][外]を#ruby[ある][歩]く。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いま][今]#ruby[にち][日]も#ruby[みち][道]を#ruby[ある][歩]いていた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[そら][空]に#ruby[しろ][白]い#ruby[くも][雲]があった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[その#ruby[くも][雲]の#ruby[した][下]で、#ruby[とり][鳥]が#ruby[と][飛]んでいた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[うえ][上]を#ruby[み][見]て、#ruby[うご][動]かなくなった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[と][飛]びたいと#ruby[おも][思]った。でも#ruby[あし][足]は#ruby[つち][土]の#ruby[うえ][上]にある。]
#block(inset: (top: 0.15em, bottom: 0.15em))[その#ruby[とき][時]、#ruby[ちい][小]さい#ruby[とり][鳥]が#ruby[いち][一]つ、#ruby[き][木]の#ruby[した][下]に#ruby[き][来]た。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ちい][小]さい#ruby[とり][鳥]は#ruby[ある][歩]いていた。#ruby[と][飛]ばなかった。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]と#ruby[とり][鳥]は#ruby[おな][同]じ#ruby[みち][道]を#ruby[ある][歩]いた。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[いぬ][犬]は#ruby[わ][分]かった。#ruby[そら][空]を#ruby[と][飛]ばなくても、#ruby[おな][同]じ#ruby[ところ][所]に#ruby[い][行]ける。]
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[ふた][二]つの#ruby[どうぶつ][動物]は、#ruby[おな][同]じ#ruby[かぜ][風]を#ruby[かん][感]じていた。]][私の犬は毎日外を歩く。今日も道を歩いていた。空に白い雲があった。その雲の下で、鳥が飛んでいた。犬は上を見て、動かなくなった。犬は飛びたいと思った。でも足は地面の上にある。その時、小さい鳥が一羽、木の下に降りてきた。小さい鳥は歩いていた。飛ばなかった。犬と鳥は同じ道を歩いた。犬は分かった。空を飛ばなくても、同じ場所に行ける。二匹の動物は、同じ風を感じていた。]

#story-block[#ruby[とお][遠]い#ruby[ところ][所]の#ruby[さかな][魚] (遠い所の魚)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[わたし][私]は#ruby[はら][腹]に#ruby[た][食]べ#ruby[もの][物]がなかった。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[たぶん#ruby[あと][後]の#ruby[にち][日]も、あの#ruby[さかな][魚]を#ruby[か][買]いに#ruby[い][行]く。]][私はお腹に食べ物がなかった。外に出て、食べ物を買いに行った。「すみません。魚はありますか。」と聞いた。男の人は言った。「はい、あります。この魚は遠い海から来ました。とても良い魚です。」「肉もありますか。」「はい。肉と卵もあります。」私は魚と卵を選んだ。「全部でいくらですか。」「三百円です。」少し高いと思った。でも遠い所の魚だから。お金を渡して、家に帰った。魚と卵で料理を作った。お腹に食べ物が入って、体が温かくなった。たぶん明日も、あの魚を買いに行く。]

#story-block[#ruby[かみ][髪]を#ruby[き][切]る#ruby[ひと][人] (髪を切る人)][#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[かみ][髪]が#ruby[なが][長]くなった。#ruby[き][切]る#ruby[とき][時]が#ruby[き][来]た。]
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
#block(inset: (top: 0.15em, bottom: 0.15em))[#ruby[かみ][髪]を#ruby[き][切]る#ruby[ひと][人]と#ruby[はな][話]すのは#ruby[たの][楽]しかった。]][髪が長くなった。切る時が来た。私は歩いて、髪を切る所に行った。中に入ると、男の人が言った。「どうしますか。」「髪を切ってください。少しだけ。」男の人は私の髪を手で持って、見た。「髪がとても強いですね。」と男の人は話した。「本当ですか。」「はい。たぶん骨も強いでしょう。」私は笑った。「分かりません。でも歯は強いです。」男の人も笑った。「頭の肌は大丈夫ですか。」「いいえ、少し赤いです。日差しが強かったので。」男の人はとても上手に切った。終わった後、髪が新しくなった。髪を切る人と話すのは楽しかった。]

== #ruby[すこ][少]しの#ruby[こと][言]#ruby[ば][葉] (俳句)

=== #ruby[そと][外]の#ruby[もの][物] (自然)

#haiku-block[#ruby[やま][山]の#ruby[うえ][上] #linebreak() #ruby[かぜ][風]が#ruby[き][来]ている #linebreak() #ruby[そら][空]#ruby[あお][青]い][#none]

#haiku-block[#ruby[あめ][雨]の#ruby[おと][音] #linebreak() #ruby[そと][外]に#ruby[き][聞]こえる #linebreak() #ruby[よる][夜]の#ruby[みち][道]][#none]

#haiku-block[#ruby[うみ][海]の#ruby[みず][水] #linebreak() #ruby[おお][大]きく#ruby[うご][動]く #linebreak() #ruby[しろ][白]い#ruby[いし][石]][#none]

#haiku-block[#ruby[しろ][白]い#ruby[つき][月] #linebreak() #ruby[みず][水]の#ruby[うえ][上]#ruby[で][出]る #linebreak() #ruby[よる][夜]の#ruby[うみ][海]][#none]

#haiku-block[#ruby[くも][雲]が#ruby[く][来]る #linebreak() #ruby[とり][鳥]が#ruby[と][飛]んでる #linebreak() #ruby[あめ][雨]の#ruby[まえ][前]][#none]

#haiku-block[#ruby[さかな][魚]#ruby[い][行]く #linebreak() #ruby[みず][水]で#ruby[ひか][光]って #linebreak() #ruby[うみ][海]の#ruby[おと][音]][#none]

=== #ruby[まい][毎]#ruby[にち][日] (日常)

#haiku-block[#ruby[みず][水]を#ruby[の][飲]む #linebreak() #ruby[たいよう][太陽]が#ruby[で][出]て #linebreak() #ruby[そと][外]を#ruby[み][見]る][#none]

#haiku-block[#ruby[た][食]べ#ruby[もの][物]を #linebreak() #ruby[こども][子供]と#ruby[た][食]べる #linebreak() #ruby[いえ][家]の#ruby[なか][中]][#none]

#haiku-block[#ruby[みち][道]を#ruby[い][行]く #linebreak() #ruby[おお][大]きい#ruby[き][木]#ruby[み][見]る #linebreak() #ruby[かぜ][風]の#ruby[おと][音]][#none]

#haiku-block[#ruby[よる][夜]が#ruby[く][来]る #linebreak() #ruby[つき][月]を#ruby[み][見]ている #linebreak() #ruby[め][目]を#ruby[し][閉]める][#none]

#haiku-block[#ruby[いぬ][犬]#ruby[ある][歩]く #linebreak() #ruby[おな][同]じ#ruby[みち][道]#ruby[い][行]く #linebreak() #ruby[かぜ][風]#ruby[ちが][違]う][#none]

#haiku-block[#ruby[はら][腹]が#ruby[い][言]う #linebreak() #ruby[さかな][魚]#ruby[た][食]べたい #linebreak() #ruby[うみ][海]#ruby[とお][遠]い][#none]

=== #ruby[こころ][心] (心)

#haiku-block[#ruby[ひと][人]を#ruby[ま][待]つ #linebreak() #ruby[こころ][心]の#ruby[なか][中]に #linebreak() いつもいる][#none]

#haiku-block[#ruby[たの][楽]しくて #linebreak() #ruby[こども][子供]が#ruby[わら][笑]う #linebreak() #ruby[おと][音]を#ruby[き][聞]く][#none]

#haiku-block[#ruby[な][泣]く#ruby[こども][子供] #linebreak() #ruby[はは][母]が#ruby[て][手]を#ruby[も][持]つ #linebreak() #ruby[ひかり][光]#ruby[み][見]る][#none]

#haiku-block[#ruby[ひと][人]に#ruby[あ][会]う #linebreak() #ruby[ことば][言葉]を#ruby[すこ][少]し #linebreak() #ruby[わら][笑]う#ruby[ひと][人]][#none]

#haiku-block[#ruby[わ][分]かりたい #linebreak() #ruby[こころ][心]で#ruby[わ][分]かる #linebreak() たぶんそう][#none]

#haiku-block[#ruby[はな][話]したい #linebreak() #ruby[ことば][言葉]ない#ruby[とき][時] #linebreak() #ruby[め][目]が#ruby[はな][話]す][#none]

=== #ruby[とき][時]の#ruby[か][変]わり (季節)

#haiku-block[#ruby[くさ][草]#ruby[ひら][開]く #linebreak() #ruby[やま][山]の#ruby[かぜ][風]#ruby[く][来]る #linebreak() #ruby[くさ][草]#ruby[うご][動]く][#none]

#haiku-block[#ruby[そら][空]#ruby[あつ][暑]い #linebreak() #ruby[みず][水]を#ruby[の][飲]む#ruby[ひと][人] #linebreak() #ruby[にち][日]#ruby[お][終]わる][#none]

#haiku-block[#ruby[き][木]が#ruby[か][変]わる #linebreak() #ruby[あか][赤]くなる#ruby[やま][山] #linebreak() #ruby[かぜ][風]#ruby[さむ][寒]い][#none]

#haiku-block[#ruby[さむ][寒]い#ruby[よる][夜] #linebreak() #ruby[ひ][火]に#ruby[ちか][近]い#ruby[ひと][人] #linebreak() #ruby[おと][音]もない][#none]

=== #ruby[ひと][人]と#ruby[ひと][人] (人の間)

#haiku-block[#ruby[だれ][誰]か#ruby[く][来]る #linebreak() #ruby[し][知]らない#ruby[なまえ][名前] #linebreak() #ruby[わら][笑]う#ruby[ひと][人]][#none]

#haiku-block[また#ruby[あ][会]おう #linebreak() と#ruby[い][言]った#ruby[あと][後]に #linebreak() #ruby[みち][道]#ruby[なが][長]い][#none]

#haiku-block[あなた#ruby[ま][待]つ #linebreak() #ruby[こ][来]ないと#ruby[し][知]って #linebreak() まだここに][#none]

#haiku-block[#ruby[て][手]#ruby[あた][与]える #linebreak() もらう#ruby[ひと][人]の#ruby[め][目] #linebreak() #ruby[ひかり][光]#ruby[み][見]た][#none]

#haiku-block[いいえ#ruby[い][言]う #linebreak() #ruby[こころ][心]#ruby[かな][悲]しい #linebreak() それでいい][#none]

=== #ruby[い][生]きると#ruby[し][死]ぬ (生と死)

#haiku-block[#ruby[はじ][始]まりの #linebreak() #ruby[すこ][少]しの#ruby[からだ][体] #linebreak() #ruby[な][泣]いている][#none]

#haiku-block[#ruby[い][生]きること #linebreak() #ruby[た][食]べて#ruby[うご][動]いて #linebreak() #ruby[く][来]る#ruby[にち][日]へ][#none]

#haiku-block[#ruby[ひと][人]は#ruby[し][死]ぬ #linebreak() #ruby[つち][土]の#ruby[なか][中]#ruby[い][入]る #linebreak() #ruby[くさ][草]#ruby[い][生]きる][#none]

#haiku-block[#ruby[お][終]わる#ruby[よる][夜] #linebreak() #ruby[ひかり][光]#ruby[はじ][始]まる #linebreak() #ruby[そら][空]はある][#none]

#haiku-block[#ruby[しろ][白]い#ruby[かみ][髪] #linebreak() #ruby[ひゃく][百]#ruby[ねん][年]#ruby[い][生]きて #linebreak() #ruby[ほね][骨]#ruby[つよ][強]い][#none]

=== #ruby[ひかり][光]と#ruby[ひかり][光]がない (光と闇)

#haiku-block[#ruby[つき][月]の#ruby[よる][夜] #linebreak() #ruby[ひ][火]が#ruby[ひと][一]つある #linebreak() #ruby[だれ][誰]かいる][#none]

#haiku-block[#ruby[ひかり][光]#ruby[く][来]る #linebreak() #ruby[こわ][怖]いの#ruby[お][終]わる #linebreak() #ruby[め][目]を#ruby[ひら][開]く][#none]

#haiku-block[#ruby[ひ][火]を#ruby[と][止]めて #linebreak() #ruby[ひかり][光]なくなる #linebreak() #ruby[からだ][体]だけ][#none]

#haiku-block[#ruby[よる][夜]の#ruby[そら][空] #linebreak() #ruby[つき][月]#ruby[しろ][白]く#ruby[で][出]る #linebreak() #ruby[みち][道]#ruby[しろ][白]い][#none]

=== #ruby[こと][言]#ruby[ば][葉] (言葉)

#haiku-block[#ruby[ことば][言葉]ない #linebreak() #ruby[こころ][心]が#ruby[うご][動]く #linebreak() #ruby[ひと][人]と#ruby[ひと][人]][#none]

#haiku-block[#ruby[か][書]く#ruby[ことば][言葉] #linebreak() #ruby[だれ][誰]も#ruby[よ][読]まない #linebreak() まだそこに][#none]

#haiku-block[#ruby[き][聞]く#ruby[ことば][言葉] #linebreak() #ruby[し][知]らない#ruby[ことば][言葉] #linebreak() #ruby[みち][道]#ruby[ひら][開]く][#none]

#haiku-block[#ruby[い][言]わないで #linebreak() #ruby[て][手]を#ruby[も][持]っている #linebreak() それでいい][#none]

#back-cover("minihongo.com")
