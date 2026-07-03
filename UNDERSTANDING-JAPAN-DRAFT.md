# Understanding Real Japan (draft for review)

Status: DRAFT. Nothing here is in the CSVs yet. Review, cut, edit - then this becomes `data/comprehension.csv` under the Going Further page.

## What this is

Japan will not speak minihongo back to you. The clerk speaks keigo, the signs use kanji you were never taught, the train announces itself in full Japanese. This lesson is the other half of living in Japan: words you will **never need to say** - you only need to recognize them when Japan says them at you.

Rules of this tier:

- **Recognize only, never produce.** Your speaking vocabulary stays the 225 words.
- **Not counted.** These items are never part of the "225 words" claim.
- **Entry rule** (the receptive analog of the vocabulary stopping rule): an item enters only with a **safety**, **transaction**, or **civic** justification. Nothing enters because it is merely common or interesting.
- Every meaning is explained **in the 225 words** (the "It means" column) - the system explains real Japan; real Japan never leaks into the system.

Format note: the "It means" column uses furigana bracket notation and only base vocabulary - it is written to paste directly into `comprehension.csv` and pass `validate_vocab.py`. The Japanese column is real, unrestricted Japanese (validated only for furigana presence at integration time).

---

## 1. Signs (見る言葉) - 42 items

Justification: safety (danger, exits, fire), transactions (prices, tax, tickets), navigation.

| Japanese | Reading | English | It means (225 words) | Where you meet it |
|---|---|---|---|---|
| 立入禁止 | たちいりきんし | No entry | ここに入【はい】ってはいけない。 | Fences, construction sites, restricted doors |
| 危険 | きけん | Danger | とても悪【わる】い事【こと】が起【お】こる。入【はい】らないでください。 | Yellow signs, machinery, riverbanks |
| 注意 | ちゅうい | Caution | 良【よ】く見【み】てください。良【よ】く聞【き】いてください。 | Everywhere: platforms, wet floors, steps |
| 足元注意 | あしもとちゅうい | Watch your step | 下【した】を良【よ】く見【み】てください。 | Stairs, station platforms |
| 飲食禁止 | いんしょくきんし | No food or drink | ここで食【た】べてはいけない。飲【の】んではいけない。 | Trains, libraries, shops |
| 入口 | いりぐち | Entrance | 入【はい】る所【ところ】。 | Every building |
| 出口 | でぐち | Exit | 出【で】る所【ところ】。 | Every building, stations |
| 非常口 | ひじょうぐち | Emergency exit | 悪【わる】い事【こと】が起【お】こった時【とき】、ここから外【そと】に出【で】る。 | Green running-man sign in every building |
| 押 | おす | Push | 手【て】を前【まえ】に。そうすると開【あ】きます。 | Doors |
| 引 | ひく | Pull | 手【て】を私【わたし】の方【かた】に。そうすると開【あ】きます。 | Doors |
| 開 | ひらく | Open (button) | これは「開【あ】く」。 | Elevator buttons |
| 閉 | しめる | Close (button) | これは「閉【し】める」。 | Elevator buttons |
| 営業中 | えいぎょうちゅう | Open (for business) | 今【いま】、開【あ】いている。入【はい】る事【こと】ができる。 | Shop doors |
| 準備中 | じゅんびちゅう | Closed (preparing) | まだ開【あ】いていない。今【いま】は入【はい】る事【こと】ができない。 | Shop doors |
| 定休日 | ていきゅうび | Regular closing day | この日【にち】は、開【あ】かない日【にち】。 | Shop doors, restaurant signs |
| 営業時間 | えいぎょうじかん | Business hours | 開【あ】いている時【とき】。この時【とき】の中【なか】で来【き】てください。 | Shop doors, websites |
| 禁煙 | きんえん | No smoking | 口【くち】で火【ひ】の物【もの】を使【つか】ってはいけない。 | Restaurants, stations, streets |
| 喫煙所 | きつえんじょ | Smoking area | 口【くち】で火【ひ】の物【もの】を使【つか】う事【こと】ができる所【ところ】。 | Outside stations, office buildings |
| 使用中 | しようちゅう | In use / occupied | 今【いま】、人【ひと】が使【つか】っている。待【ま】ってください。 | Toilet doors, meeting rooms |
| 故障中 | こしょうちゅう | Out of order | この物【もの】は今【いま】、使【つか】う事【こと】ができない。悪【わる】くなっている。 | Machines, elevators, toilets |
| 売切れ・品切れ | うりきれ・しなぎれ | Sold out | もうありません。買【か】う事【こと】ができません。 | Vending machines, shops, restaurants |
| お手洗い | おてあらい | Restroom | 体【からだ】から水【みず】を出【だ】す所【ところ】。 | Stations, department stores |
| 無料 | むりょう | Free | お金【かね】は必要【ひつよう】ない。 | Services, samples, water |
| 有料 | ゆうりょう | Paid / fee required | お金【かね】が必要【ひつよう】。 | Bags, parking, toilets |
| 割引 | わりびき | Discount | 少【すく】ないお金【かね】で買【か】う事【こと】ができる。 | Supermarket stickers, ads |
| 税込 | ぜいこみ | Tax included | 国【くに】にあげるお金【かね】も中【なか】に入【はい】っている。これが全部【ぜんぶ】のお金【かね】。 | Price tags |
| 税抜 | ぜいぬき | Tax not included | 国【くに】にあげるお金【かね】は中【なか】に入【はい】っていない。もう少【すこ】し高【たか】くなる。 | Price tags |
| レジ | れじ | Checkout register | お金【かね】を出【だ】す所【ところ】。 | Every shop |
| 領収書 | りょうしゅうしょ | Receipt | 「お金【かね】を出【だ】した」と書【か】いてある物【もの】。 | Checkout, taxis |
| 駅 | えき | Station | 人【ひと】が来【く】る物【もの】を待【ま】つ所【ところ】。 | Everywhere in cities |
| 電車 | でんしゃ | Train | 道【みち】の上【うえ】を動【うご】く長【なが】い物【もの】。 | Signs, announcements |
| 改札 | かいさつ | Ticket gate | ここから中【なか】に入【はい】ります。中【なか】に入【はい】るために買【か】った物【もの】を使【つか】います。 | Station entrances |
| 切符売り場 | きっぷうりば | Ticket office | 中【なか】に入【はい】るために買【か】う物【もの】を、買【か】う所【ところ】。 | Stations |
| 精算 | せいさん | Fare adjustment | お金【かね】が少【すく】なかった時【とき】、ここでもっとお金【かね】を出【だ】す。 | Machines near ticket gates |
| バス停 | ばすてい | Bus stop | 多【おお】くの人【ひと】が中【なか】に入【はい】る大【おお】きい物【もの】を、待【ま】つ所【ところ】。 | Streets |
| 駐車場 | ちゅうしゃじょう | Parking lot | 速【はや】い動【うご】く物【もの】を止【と】める所【ところ】。 | Streets, buildings |
| 駐車禁止 | ちゅうしゃきんし | No parking | ここに速【はや】い動【うご】く物【もの】を止【と】めてはいけない。 | Streets |
| 工事中 | こうじちゅう | Under construction | 今【いま】、ここで作【つく】っている。入【はい】ってはいけない。 | Roads, buildings |
| 通行止め | つうこうどめ | Road closed | この道【みち】は今【いま】、使【つか】う事【こと】ができない。他【ほか】の道【みち】に行【い】ってください。 | Roads |
| 一方通行 | いっぽうつうこう | One way | この道【みち】は一【ひと】つの方【かた】だけ。 | Streets |
| 火気厳禁 | かきげんきん | No open flames | ここで火【ひ】を使【つか】ってはいけない。とても悪【わる】い事【こと】が起【お】こるから。 | Gas stations, storage areas |
| 土足禁止 | どそくきんし | No shoes | 外【そと】の足【あし】の服【ふく】で入【はい】ってはいけない。 | Homes, temples, some restaurants, clinics |

## 2. What the clerk says (買う所の人の言葉) - 30 items

Justification: transactions. You hear these every single day. You answer with your 225 words; you only need to understand the question.

| Japanese | Reading | English | It means (225 words) | Where you meet it |
|---|---|---|---|---|
| いらっしゃいませ | いらっしゃいませ | Welcome | 買【か】う所【ところ】の人【ひと】の「こんにちは」。何【なに】も言【い】わなくて大丈夫【だいじょうぶ】。 | Every shop, every restaurant |
| レジ袋ご利用ですか | れじぶくろごりようですか | Do you need a bag? | 「物【もの】を持【も】つ物【もの】が必要【ひつよう】ですか」と聞【き】いている。「はい」または「大丈夫【だいじょうぶ】です」と言【い】う。 | Convenience stores, supermarkets |
| 袋にお入れしますか | ふくろにおいれしますか | Shall I bag it? | 上【うえ】と同【おな】じ事【こと】。「物【もの】を持【も】つ物【もの】が必要【ひつよう】ですか」。 | Shops |
| ポイントカードはお持ちですか | ぽいんとかーどはおもちですか | Do you have a point card? | 「その買【か】う所【ところ】の小【ちい】さい物【もの】を持【も】っていますか」と聞【き】いている。ない時【とき】は「ないです」で大丈夫【だいじょうぶ】。 | Every chain store |
| 温めますか | あたためますか | Shall I heat it up? | 「食【た】べる物【もの】を暑【あつ】くしますか」と聞【き】いている。「はい、お願【ねが】いします」または「大丈夫【だいじょうぶ】です」。 | Convenience stores |
| お箸はおつけしますか | おはしはおつけしますか | Do you want chopsticks? | 「食【た】べる時【とき】に使【つか】う小【ちい】さい木【き】が必要【ひつよう】ですか」と聞【き】いている。 | Convenience stores |
| ○○円になります | ○○えんになります | That will be ○○ yen | 出【だ】すお金【かね】の言葉【ことば】。その円【えん】を出【だ】してください。 | Every checkout |
| ○○円のお返しです | ○○えんのおかえしです | Here is your change | 多【おお】く出【だ】したお金【かね】が、あなたに来【き】ます。 | Every checkout |
| 以上でよろしいですか | いじょうでよろしいですか | Will that be all? | 「もう全部【ぜんぶ】ですか」と聞【き】いている。「はい」と言【い】う。 | Checkout, ordering |
| 少々お待ちください | しょうしょうおまちください | One moment please | 「少【すこ】し待【ま】ってください」のとても良【よ】い言【い】い方【かた】。 | Everywhere |
| かしこまりました | かしこまりました | Certainly | 「分【わ】かりました」のとても良【よ】い言【い】い方【かた】。 | Restaurants, hotels, shops |
| お待たせしました | おまたせしました | Sorry to keep you waiting | 「待【ま】ってくれてありがとう」という言葉【ことば】。 | Restaurants, counters, phone |
| ありがとうございました | ありがとうございました | Thank you (polite) | 「ありがとう」のとても良【よ】い言【い】い方【かた】。 | Leaving any shop |
| またお越しくださいませ | またおこしくださいませ | Please come again | 「また来【き】てください」という言葉【ことば】。 | Leaving shops |
| お支払い方法はいかがなさいますか | おしはらいほうほうはいかがなさいますか | How would you like to pay? | 「どうお金【かね】を出【だ】しますか」と聞【き】いている。お金【かね】を見【み】せて「これで」と言【い】って大丈夫【だいじょうぶ】。 | Checkout |
| 一括でよろしいですか | いっかつでよろしいですか | Pay in one payment? | 「一【ひと】つの時【とき】で全部【ぜんぶ】出【だ】しますか」と聞【き】いている。「はい」で大丈夫【だいじょうぶ】。 | Card payments |
| お会計は○○円です | おかいけいは○○えんです | Your total is ○○ yen | 全部【ぜんぶ】のお金【かね】の言葉【ことば】。 | Restaurants, checkout |
| こちらへどうぞ | こちらへどうぞ | This way please | 「ここに来【き】てください」という言葉【ことば】。 | Restaurants, offices, clinics |
| 何名様ですか | なんめいさまですか | How many people? | 「一人【ひとり】ですか、二人【ふたり】ですか」と聞【き】いている。手【て】で一【いち】、二【に】を見【み】せて大丈夫【だいじょうぶ】。 | Restaurant entrances |
| ご注文はお決まりですか | ごちゅうもんはおきまりですか | Ready to order? | 「もう選【えら】びましたか」と聞【き】いている。まだなら「まだです」。 | Restaurants |
| お飲み物はいかがですか | おのみものはいかがですか | Would you like a drink? | 「飲【の】む物【もの】も欲【ほ】しいですか」と聞【き】いている。 | Restaurants |
| 店内でお召し上がりですか、お持ち帰りですか | てんないでおめしあがりですか、おもちかえりですか | For here or to go? | 「ここで食【た】べますか、外【そと】に持【も】って行【い】きますか」と聞【き】いている。 | Fast food, cafes |
| お会計はご一緒でよろしいですか | おかいけいはごいっしょでよろしいですか | Pay together? | 「お金【かね】を一【ひと】つで出【だ】しますか、一人【ひとり】一人【ひとり】で出【だ】しますか」と聞【き】いている。 | Restaurants |
| 申し訳ございません | もうしわけございません | We are very sorry | 「すみません」のとても強【つよ】い言【い】い方【かた】。 | Apologies anywhere |
| 恐れ入りますが | おそれいりますが | Excuse me, but... | 「すみませんが…」。この後【あと】の言葉【ことば】を良【よ】く聞【き】いてください。 | Polite requests |
| 在庫を確認してまいります | ざいこをかくにんしてまいります | I will check our stock | 「その物【もの】がまだあるか、見【み】て来【き】ます」という事【こと】。少【すこ】し待【ま】ってください。 | Shops |
| お大事に | おだいじに | Take care / get well | 「体【からだ】を良【よ】くしてください」という言葉【ことば】。「ありがとう」と言【い】う。 | Pharmacies, clinics |
| 保険証はお持ちですか | ほけんしょうはおもちですか | Do you have your insurance card? | 「体【からだ】のための、国【くに】の小【ちい】さい物【もの】を持【も】っていますか」と聞【き】いている。 | Clinics, hospitals |
| 診察券はお持ちですか | しんさつけんはおもちですか | Do you have your patient card? | 「この体【からだ】を助【たす】ける所【ところ】の小【ちい】さい物【もの】を持【も】っていますか」と聞【き】いている。始【はじ】めて来【き】た時【とき】は「ないです」と言【い】う。 | Clinics, hospitals |
| お呼びしますので、おかけになってお待ちください | およびしますので、おかけになっておまちください | Please sit and wait to be called | 「名前【なまえ】を言【い】うまで、座【すわ】って待【ま】ってください」という事【こと】。 | Clinics, banks, city hall |

## 3. Announcements (聞く言葉) - 25 items

Justification: safety (emergency broadcasts are the reason Yasashii Nihongo exists) and transport. These arrive as sound, at native speed. Audio for this section uses natural speed by design.

| Japanese | Reading | English | It means (225 words) | Where you meet it |
|---|---|---|---|---|
| まもなく○○駅です | まもなく○○えきです | Arriving soon at ○○ | もう少【すこ】しで、その所【ところ】に止【と】まります。 | Inside trains |
| 次は○○です | つぎは○○です | Next stop: ○○ | この後【あと】に止【と】まる所【ところ】の名前【なまえ】。 | Inside trains, buses |
| ドアが閉まります。ご注意ください | どあがしまります。ごちゅういください | Doors closing | 入【はい】る所【ところ】が閉【し】まります。もう入【はい】らないでください。 | Trains, elevators |
| 駆け込み乗車はおやめください | かけこみじょうしゃはおやめください | Do not rush onto the train | 「閉【し】まる時【とき】に、中【なか】に入【はい】らないでください」という事【こと】。 | Platforms |
| ○○行き | ○○ゆき | Bound for ○○ | この長【なが】い物【もの】は、○○まで行【い】く。 | Train displays |
| 各駅停車 | かくえきていしゃ | Local train (all stops) | 全部【ぜんぶ】の所【ところ】に止【と】まる。 | Train displays |
| 快速・急行 | かいそく・きゅうこう | Rapid / express | 少【すこ】しの所【ところ】だけに止【と】まる。速【はや】い。あなたの所【ところ】に止【と】まらない時【とき】もある。良【よ】く見【み】てください。 | Train displays |
| 優先席 | ゆうせんせき | Priority seat | 体【からだ】の悪【わる】い人【ひと】と、腹【はら】に子供【こども】がいる女【おんな】の人【ひと】と、上【うえ】の年【とし】の人【ひと】が座【すわ】る所【ところ】。 | Trains, buses |
| 白線の内側でお待ちください | はくせんのうちがわでおまちください | Wait behind the white line | 下【した】の白【しろ】い道【みち】の中【なか】で待【ま】ってください。 | Platforms |
| 運転を見合わせています | うんてんをみあわせています | Service is suspended | 今【いま】、動【うご】いていません。いつ動【うご】くか、まだ分【わ】かりません。 | Stations |
| 遅れております | おくれております | Delayed | いつもの時【とき】より後【あと】に来【き】ます。 | Stations |
| 終電 | しゅうでん | Last train | この夜【よる】の、終【お】わりの一【ひと】つ。この後【あと】はもうない。 | Stations, conversations |
| 乗り換え | のりかえ | Transfer | 一【ひと】つから出【で】て、他【ほか】のに入【はい】る事【こと】。 | Stations, apps |
| 振替輸送 | ふりかえゆそう | Substitute service | この道【みち】が使【つか】えない時【とき】、他【ほか】の道【みち】で行【い】く事【こと】ができる、という事【こと】。 | Stations during disruptions |
| 地震です | じしんです | Earthquake | 土【つち】が動【うご】いています。 | Emergency broadcasts |
| 緊急地震速報 | きんきゅうじしんそくほう | Earthquake early warning | 「土【つち】が動【うご】く事【こと】が、今【いま】から来【く】る」という言葉【ことば】。強【つよ】い音【おと】と来【く】る。重【おも】い物【もの】の下【した】に入【はい】って、頭【あたま】を守【まも】ってください。 | Phone alarms, TV |
| 避難してください | ひなんしてください | Please evacuate | ここから出【で】て、良【よ】い所【ところ】に行【い】ってください、という事【こと】。 | Emergency broadcasts |
| 避難所 | ひなんじょ | Evacuation shelter | 悪【わる】い事【こと】が起【お】こった時【とき】に、行【い】く所【ところ】。多【おお】くの人【ひと】がそこに行【い】く。 | Signs, broadcasts |
| 火事です | かじです | Fire | 火【ひ】が起【お】こっています。外【そと】に出【で】てください。 | Alarms, broadcasts |
| 津波警報 | つなみけいほう | Tsunami warning | とても大【おお】きい海【うみ】の水【みず】が来【き】ます。今【いま】、高【たか】い所【ところ】へ行【い】ってください。 | Broadcasts, phone alarms |
| 大雨警報 | おおあめけいほう | Heavy rain warning | とても多【おお】い雨【あめ】が来【き】ます。水【みず】の近【ちか】くに行【い】かないでください。 | Weather broadcasts |
| 台風 | たいふう | Typhoon | とても強【つよ】い風【かぜ】と雨【あめ】。外【そと】に出【で】ないでください。 | Weather broadcasts |
| 停電 | ていでん | Power outage | 家【いえ】の光【ひかり】が止【と】まる事【こと】。 | Broadcasts, notices |
| 断水 | だんすい | Water outage | 水【みず】が止【と】まる事【こと】。水【みず】が出【で】ない。 | Notices |
| 離れてください | はなれてください | Move away | そこから出【で】てください。近【ちか】くにいてはいけません。 | Emergencies, platforms |

## 4. Forms and documents (書く物の言葉) - 26 items

Justification: civic. City hall, clinic, bank, SIM contract - every form asks the same ~25 things. Pairs with the At City Hall dialog (dgrp-22).

| Japanese | Reading | English | It means (225 words) | Where you meet it |
|---|---|---|---|---|
| 氏名 | しめい | Full name | 名前【なまえ】。ここに名前【なまえ】を書【か】く。 | Every form |
| フリガナ | ふりがな | Name reading | 名前【なまえ】の音【おと】を書【か】く所【ところ】。 | Every form |
| 生年月日 | せいねんがっぴ | Date of birth | あなたが始【はじ】まった日【にち】。年【とし】、月【つき】、日【にち】を書【か】く。 | Every form |
| 年齢 | ねんれい | Age | 「いくつですか」の事【こと】。生【い】きた年【とし】を書【か】く。 | Forms |
| 性別 | せいべつ | Sex | 男【おとこ】か、女【おんな】か。 | Forms |
| 男性・女性 | だんせい・じょせい | Male / female | 男【おとこ】の人【ひと】・女【おんな】の人【ひと】。 | Forms, toilets |
| 住所 | じゅうしょ | Address | あなたの家【いえ】がどこにあるか。家【いえ】の所【ところ】の言葉【ことば】。 | Every form |
| 電話番号 | でんわばんごう | Phone number | 音【おと】で言【い】う物【もの】の言葉【ことば】。一【いち】、二【に】、三【さん】…を書【か】く。 | Every form |
| 国籍 | こくせき | Nationality | あなたの国【くに】。どこの国【くに】の人【ひと】か。 | Civic forms |
| 職業 | しょくぎょう | Occupation | あなたが毎【まい】日【にち】する事【こと】。何【なに】をする人【ひと】か。 | Forms |
| 署名 | しょめい | Signature | 名前【なまえ】を手【て】で書【か】く事【こと】。「はい、本当【ほんとう】です」という事【こと】になる。 | Contracts, forms |
| 印鑑・はんこ | いんかん・はんこ | Personal seal | 名前【なまえ】を赤【あか】くする小【ちい】さい物【もの】。ない人【ひと】は「ないです」と言【い】って大丈夫【だいじょうぶ】な時【とき】が多【おお】い。 | City hall, banks |
| ご記入ください | ごきにゅうください | Please fill in | 「書【か】いてください」という事【こと】。 | Forms, counters |
| 必須 | ひっす | Required | 書【か】かなくてはいけない所【ところ】。 | Forms, web forms |
| 任意 | にんい | Optional | 書【か】かなくても大丈夫【だいじょうぶ】な所【ところ】。 | Forms |
| 本人確認書類 | ほんにんかくにんしょるい | Identity documents | あなたが誰【だれ】かを見【み】せる物【もの】。 | Banks, city hall, contracts |
| 在留カード | ざいりゅうかーど | Residence card | 他【ほか】の国【くに】から来【き】た人【ひと】の、とても必要【ひつよう】な物【もの】。いつも持【も】っていなくてはいけない。 | Your pocket, every civic desk |
| パスポート | ぱすぽーと | Passport | 国【くに】からもらう小【ちい】さい本【ほん】。他【ほか】の国【くに】に行【い】く時【とき】に必要【ひつよう】。 | Airports, banks, contracts |
| 有効期限 | ゆうこうきげん | Expiry date | この日【にち】まで使【つか】う事【こと】ができる、という日【にち】。 | Cards, documents, food |
| 届出 | とどけで | Notification / registration | 国【くに】の所【ところ】に「これが変【か】わりました」と言【い】う事【こと】。 | City hall |
| 市役所・区役所 | しやくしょ・くやくしょ | City hall / ward office | 国【くに】の事【こと】をする所【ところ】。家【いえ】が変【か】わった時【とき】に、ここに来【き】て言【い】う。 | Your city |
| 申請 | しんせい | Application | 国【くに】に「ください」と言【い】う事【こと】。 | City hall, immigration |
| 受付 | うけつけ | Reception | 始【はじ】めに行【い】く所【ところ】。そこの人【ひと】が助【たす】けてくれる。 | Every office, clinic |
| 窓口 | まどぐち | Service counter | 話【はな】す所【ところ】。小【ちい】さい書【か】く物【もの】をもらって、待【ま】つ。 | City hall, banks, post office |
| 緊急連絡先 | きんきゅうれんらくさき | Emergency contact | 悪【わる】い事【こと】が起【お】こった時【とき】に話【はな】す人【ひと】。その人【ひと】の、音【おと】で言【い】う物【もの】の言葉【ことば】を書【か】く。 | Forms, contracts |
| 続柄 | つづきがら | Relationship (to you) | その人【ひと】はあなたの何【なに】か。母【はは】、父【ちち】、子供【こども】…と書【か】く。 | Civic forms |

---

## Open questions for review

1. **Cut candidates**: 一方通行, 振替輸送, 続柄 are the weakest entries under the safety/transaction/civic rule. Cut or keep?
2. **○○ placeholders** (円になります, 駅です): keep the placeholder convention, or write one concrete example (三百円になります)?
3. **Glosses that strain the 225**: 押/引 (手を前に。そうすると開きます), 印鑑 (名前を赤くする小さい物). Acceptable, or reword?
4. **Audio**: natural speed only for this whole tier, or natural + slow for the announcements section?
5. Anything missing you personally needed in your first months in Japan?
