FactoryBot.define do
  factory :admin do
    sequence(:first_name) { |n| "first_name#{n}"}
    sequence(:last_name) { |n| "last_name#{n}"}
    sequence(:email) { |n| "test#{n}@test.com"}
    password "testtest"
  end
end
