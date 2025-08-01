module ApplicationHelper
  include Pagy::Frontend

  def default_meta_tags
    {
      site: "SweetsLog",
      title: "SweetsLog ～美味しい『スイーツ』を食べた幸せな気持ち『ログ』しよう～",
      reverse: true,
      charset: "utf-8",
      description: "お店で食べたスイーツを記録・シェアできるアプリ",
      keywords: "スイーツ,ケーキ,甘党,カフェ,共有,シェア",
      canonical: "https://sweetslog.com/",
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: "https://sweetslog.com/",
        image: image_url("ogp.png"),
        local: "ja-JP"
      },
      twitter: {
        card: "summary_large_image",
        image: image_url("ogp.png")
      }
    }
  end

  def katakana_to_hiragana(str)
    str.tr("ァ-ン", "ぁ-ん")
  end
end
