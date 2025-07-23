FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "title#{n}" }
    body { "テスト投稿です。"}
    spot { "大阪城" }
    address { "日本、〒540-0002 大阪府大阪市中央区大阪城１−１" }
    association :user
  end
end
