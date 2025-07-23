FactoryBot.define do
  factory :user do
    name { "SweetsLogTEST" }
    sequence(:email) { |n| "sweetslog_test#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
