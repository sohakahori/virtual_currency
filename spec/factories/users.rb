FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "first_name#{n}"}
    sequence(:last_name) { |n| "last_name#{n}"}
    sequence(:nickname) { |n| "nickname#{n}"}
    sequence(:email) { |n| "test#{n}@test.com"}
    password "testtest"
  end
end
