FactoryGirl.define do
  factory :user do
    name  'John Doe'
    sequence(:email){ |n| "user#{n}@dodo.com" }
    password 'password'
    password_confirmation { |user| user.password }
  end
end

