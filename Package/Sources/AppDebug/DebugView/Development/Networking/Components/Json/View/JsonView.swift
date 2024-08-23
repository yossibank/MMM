import SwiftUI

struct JsonView: View {
    let json: JsonElement

    init(_ json: String) {
        self.json = JsonElement.parse(json)
    }

    var body: some View {
        JsonElementView(key: nil, element: json, depth: 1)
            .font(.system(.subheadline, weight: .semibold))
    }
}

#Preview {
    let json = """
    {
        "GenreInformation":[],
        "Items":[
            {
                "affiliateRate":4,
                "affiliateUrl":"",
                "asurakuArea":"",
                "asurakuClosingTime":"",
                "asurakuFlag":0,
                "availability":1,
                "catchcopy":"「室根からあげ」TVで紹介されました！からあげグランプリ4度目の最高金賞！からあげフェスティバルNo.1決定戦初代優勝☆レンジでチンするだけ！お弁当 おすすめ♪",
                "creditCardFlag":1,
                "endTime":"",
                "genreId":"200944",
                "giftFlag":0,
                "imageFlag":1,
                "itemCaption":"商品について 返礼品名 室根からあげ(いわいもも)訳あり 原材料名 鶏もも肉（岩手県産）、しょうゆ、玉ねぎ、おろししょうが、酵母エキス、清酒、砂糖、衣（でん粉、コーンフラワー、しょうゆ、小麦粉、玉ねぎ、おろししょうが、食塩）、揚げ油（なたね油）/加工でん粉、増粘多糖類、（一部に小麦・大豆・鶏肉を含む） 内容量 ■訳あり室根からあげ(いわいもも)1.6kg ： (小分け800g×2袋) または ■訳あり室根からあげ(いわいもも)3.2kg ： (小分け800g×4袋) ■訳あり室根からあげ(いわいもも)8kg ： (小分け800g×10袋) 訳あり品：小さいものや大きいもの、こわれ等が入ります。味は同等です。 賞味期限 冷凍1年 保存方法 -18℃以下で保存 調理方法 【油で揚げる場合】 　冷凍のまま170℃の油で3分間揚げてください。 【電子レンジの場合】 　凍ったままの商品を袋から出し皿にのせ、ラップをかけずに加熱してください。 ・3個の場合500wで約1分30秒 ・5個の場合500wで約2分 ＊衣をより「サクッ」とさせたい場合は、オーブントースターやフライ調理がおすすめです！ 備考 配達の日時指定はできません。ご了承のほどよろしくお願いいたします。 動画配信元:からあげ協会 製造者 株式会社オヤマ岩手県一関市室根町折壁字愛宕下161 ・ふるさと納税よくある質問はこちら ・寄付申込みのキャンセル、返礼品の変更・返品はできません。あらかじめご了承ください。「からあげフェスティバル」で初代優勝の「室根からあげ」をご家庭で！ 室根からあげ（いわいもも）小分け1.6kg～8kg 「株式会社オヤマ」のご紹介 株式会社オヤマは、岩手県一関市に飼育農場と工場を有し、岩手県産銘柄鶏「いわいどり」を親鳥から育成し、生産、処理、加工、販売までを一貫システムで行っている会社です。また、岩手県内と東京・秋葉原に唐揚げ専門店「からあげ家」を出店し、「いわいどり」を美味しく提供しています。 創業以来、私たちは「心から美味しいといわれる鶏肉」を日夜追求し続けています。飼育方法や飼料に工夫を凝らし、心を込めて丁寧に育て、徹底した衛生管理と鮮度のよい鶏肉を、いち早く消費者の皆様にお届けするシステムをつくり上げてきました。また、「グルメ」という言葉がまだでは一般的なかった時代から、“食の豊かさを文化の豊かさとして楽しむ時代が来る ” との信念で、食肉加工に加え、二次加工、加工食品にも取り組んできました。 その成果が「第8・9回、14・15回からあげグランプリ」東日本しょうゆダレ部門【最高金賞】受賞と「からあげフェスティバル」初代優勝です。 今は、いかに売れるものを作るかの「技術力」「商品力」「きめこまやかな対応」が求められる時代です。 「心から美味しいといわれる鶏肉」のテーマに取り組んだのは昭和36年、食卓を囲む人々の笑顔に支えられ、オヤマは仕事に誇りと信頼を持ち、本物志向を信念に、明日の食文化の創造にこだわり続けてきました。それこそが消費者の心の「器」をみたすことと信じて! 食の「安全、安心、健康」を追求しつつ、お客様のニーズにさらにお応え続けるため、価値ある企業づくりを目指してまいります。","itemCode":"f032093-ichinoseki:10000282","itemName":"【ふるさと納税】訳あり からあげ 1.6kg～8kg 小分け レンジ 冷めてもおいしい 室根からあげ 【 規格外 不揃い 冷凍 唐揚げ 冷凍食品 惣菜 お惣菜 大容量 から揚げ お弁当 おかず 簡単 業務用 おすすめ 人気 国産 肉 鶏モモ 奥州 いわいどり 一関 フライドチキン 岩手県 】",
                "itemPrice":12000,
                "itemPriceBaseField":"item_price_min3",
                "itemPriceMax1":54000,
                "itemPriceMax2":54000,
                "itemPriceMax3":54000,
                "itemPriceMin1":12000,
                "itemPriceMin2":12000,
                "itemPriceMin3":12000,
                "itemUrl":"https://item.rakuten.co.jp/f032093-ichinoseki/oyama-01/?rafcid=wsc_i_is_1032211485929725116",
                "mediumImageUrls":[
                    "https://thumbnail.image.rakuten.co.jp/@0_mall/f032093-ichinoseki/cabinet/07789463/00446_item_sku.jpg?_ex=128x128","https://thumbnail.image.rakuten.co.jp/@0_mall/f032093-ichinoseki/cabinet/07789463/00446_01.jpg?_ex=128x128",
                    "https://thumbnail.image.rakuten.co.jp/@0_mall/f032093-ichinoseki/cabinet/07789463/00446_02nn.jpg?_ex=128x128"
                ],
                "pointRate":1,
                "pointRateEndTime":"",
                "pointRateStartTime":"",
                "postageFlag":0,
                "reviewAverage":4.69,
                "reviewCount":392,
                "shipOverseasArea":"",
                "shipOverseasFlag":0,
                "shopAffiliateUrl":"",
                "shopCode":"f032093-ichinoseki",
                "shopName":"岩手県一関市",
                "shopOfTheYearFlag":0,
                "shopUrl":"https://www.rakuten.co.jp/f032093-ichinoseki/?rafcid=wsc_i_is_1032211485929725116",
                "smallImageUrls":[
                    "https://thumbnail.image.rakuten.co.jp/@0_mall/f032093-ichinoseki/cabinet/07789463/00446_item_sku.jpg?_ex=64x64",
                    "https://thumbnail.image.rakuten.co.jp/@0_mall/f032093-ichinoseki/cabinet/07789463/00446_01.jpg?_ex=64x64",
                    "https://thumbnail.image.rakuten.co.jp/@0_mall/f032093-ichinoseki/cabinet/07789463/00446_02nn.jpg?_ex=64x64"
                ],
                "startTime":"",
                "tagIds":[
                    1003530,1011174,1011182,1032626,1032632,1037390,1040130,1045372,1016365
                ],
                "taxFlag":0
            }
        ],
        "TagInformation":[],
        "carrier":0,
        "count":19482,
        "first":4,
        "hits":3,
        "last":6,
        "page":2,
        "pageCount":100
    }
    """

    return ScrollView {
        JsonView(json)
    }
}
