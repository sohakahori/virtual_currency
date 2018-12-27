FactoryBot.define do
  factory :response do
    sequence(:body) { |n| "response body#{n}"}
    association :user
    association :board
  end
end
