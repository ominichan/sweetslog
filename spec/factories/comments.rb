FactoryBot.define do
  factory :comment do
    body { "テストコメントです。" }
    association :user
    association :post
  end
end
