FactoryBot.define do
  factory :board do
    sequence(:title) { |n| "test title #{n}"}
    association :user
  end
end
