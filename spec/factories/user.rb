FactoryGirl.define do
  #sequence :email do |n|
    #"user#{n}#{rand(1<<10)}@dodo.com"
  #end

  factory :user do
    name  'John Doe'
    email 'user@dodo.com'
    password 'password'
    password_confirmation { |user| user.password }
  end

  #factory :confirmed_user, parent: :user do
    #confirmed_at DateTime.now
  #end

end

