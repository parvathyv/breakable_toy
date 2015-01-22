require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    name 'Coolguy123'
    password 'password'
    password_confirmation 'password'

  end

  factory :location do
    address 'New York, NY, USA'
  end

  factory :hunt do
    sequence(:name) { |n| "#{n}nnn"}
    description "Discover SanFran on a foggy day"
    user
    location
  end

  factory :questionset do
    sequence(:question) { |n| "#{n}What is the oldest public garden in the US"}
    address "Boston, MA, USA"
    question_no 3
    description 'The best city to walk in the US'
    hunt
  end

  factory :huntsplayeduser do
    user_session_id "a9200101a111111a9200101a11111132"
    address "Boston, MA, USA"
    question_no 1
    hunt
    user
  end

  factory :admin_user, parent: :user do
    role 'admin'
  end
end
