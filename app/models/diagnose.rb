class Diagnose
  include ActiveModel::Model

  attr_accessor :q1, :q2, :q3

  def result
    case [ q1, q2, q3 ]
    when [ "A", "A", "A" ]
      "ふわとろパンケーキ"
    when [ "A", "A", "B" ]
      "バスクチーズケーキ"
    when [ "A", "A", "C" ]
      "フィナンシェ"
    when [ "A", "B", "A" ]
      "あんバタートースト"
    when [ "A", "B", "B" ]
      "みたらし団子"
    when [ "A", "B", "C" ]
      "最中（もなか）"
    when [ "B", "A", "A" ]
      "ガトーショコラ"
    when [ "B", "A", "B" ]
      "ショートケーキ"
    when [ "B", "A", "C" ]
      "マカロン"
    when [ "B", "B", "A" ]
      "いちご大福"
    when [ "B", "B", "B" ]
      "どら焼き"
    when [ "B", "B", "C" ]
      "塩豆大福"
    when [ "C", "A", "A" ]
      "クレープ（カスタード＆フルーツ）"
    when [ "C", "A", "B" ]
      "フルーツタルト"
    when [ "C", "A", "C" ]
      "プチシュークリーム"
    when [ "C", "B", "A" ]
      "白玉クリームぜんざい"
    when [ "C", "B", "B" ]
      "抹茶ティラミス"
    when [ "C", "B", "C" ]
      "ひとくち羊羹"
    end
  end
end
