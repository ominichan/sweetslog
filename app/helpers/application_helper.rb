module ApplicationHelper
  include Pagy::Frontend

  def default_meta_tags
    {
      site: "SweetsLog",
      title: "美味しい『スイーツ』を食べた幸せな気持ち『ログ』しよう",
      reverse: true,
      charset: 'utf-8',
      description: "SweetsLogはお店で食べた美味しいスイーツを記録・シェアできるアプリです。",
      keywords: "スイーツ,ケーキ,甘党,カフェ,共有,シェア",
      canonical: "https://sweetslog.fly.dev/",
      separator: "|",
      og:{
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: "https://sweetslog.fly.dev/",
        image: image_url("ogp.png"),
        local: "ja-JP"
      },
      twitter: {
        card: "summary_large_image",
        image: image_url("ogp.png")
      }
    }
  end
end
