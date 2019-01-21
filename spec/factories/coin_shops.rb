FactoryBot.define do
  factory :coin_shop do
    association :coin
    association :shop
  end
end
