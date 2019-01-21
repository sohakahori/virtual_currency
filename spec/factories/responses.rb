FactoryBot.define do
  factory :response do
    sequence(:body) { |n| "response_body#{n}"}
    association :user
    association :board
  end
end
