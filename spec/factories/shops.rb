FactoryBot.define do
  factory :shop do
    sequence(:name) { |n| "取引所名#{n}"}
    sequence(:address) { |n| "東京都渋谷区#{n}"}
    sequence(:company) { |n| "株式会社仮想通貨#{n}"}
  end
end
