FactoryBot.define do
  factory :coin do
    sequence(:name) { |n| "コイン名#{n}"}
    sequence(:name_kana) { |n| "コインメイ#{n}"}
    sequence(:market_rank) { |n| n}
  end
end
