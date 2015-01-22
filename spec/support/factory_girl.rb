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
    #huntsplayeduser
  end

  factory :questionset do
    sequence(:question) { |n| "#{n}What is the oldest public garden in the US"}
    address "King's Chapel, Boston, MA"

    question_no 1
    description 'The best city to walk in the US'
    hunt
  end

  factory :huntsplayeduser do
    user_session_id "a9200101a111111a9200101a11111132"
    address "King's Chapel, Boston, MA"

    question_no 1

    after(:create) {|huntsplayeduser| huntsplayeduser.users = [create(:user)]}
  end

  factory :admin_user, parent: :user do
    role 'admin'
  end
end
