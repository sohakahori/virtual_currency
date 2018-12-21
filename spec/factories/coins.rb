FactoryBot.define do
  factory :coin do
    sequence(:coin_market_cap_id) { |n| "coin#{n}"}
    sequence(:name) { |n| "コイン名#{n}"}
    sequence(:symbol) { |n| "symbol#{n}"}
    sequence(:rank) { |n| "#{n}"}
    sequence(:market_cap_jpy) { |n| n}
  end
end
