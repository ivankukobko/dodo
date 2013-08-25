FactoryGirl.define do
  factory :user do
    name  'John Doe'
    sequence(:email){ |n| "user#{n}@dodo.com" }
    password 'password'
    password_confirmation { |user| user.password }
  end

  factory :project do
    sequence(:name){|t| "Project #{n}"}
    description 'Lorem ipsum...'
  end

  factory :todo_list do
    sequence(:title){|t| "Todo List #{n}"}
    description 'Lorem ipsum...'
  end

  factory :todo_item do
    sequence(:title){|t| "Todo Item #{n}"}
    description 'Lorem ipsum...'
  end

  factory :info_page do
    title 'About'
    permalink 'about'
    body 'Lorem ipsum...'
  end
end

