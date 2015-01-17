require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    name 'Coolguy123'

    password 'password'
    password_confirmation 'password'

  end

  factory :location do
    #sequence(:address) { |n| "#{n}New York, NY, USA"}
    address 'New York, NY, USA'
    #latitude 41.4222
    #longitude -119.8888
  end

  factory :hunt do
    sequence(:name) { |n| "#{n}nnn"}
    description "Discover SanFran on a foggy day"

    user
    location

  end

  factory :questionset do
    sequence(:question) { |n| "#{n}What is the oldest public garden in the US"}
    address "King's Chapel, Boston, MA"

    question_no 1

    hunt

  end

  factory :huntsplayeduser do
    user_session_id "1h199199199991"
    address "King's Chapel, Boston, MA"

    question_no 1

  end


  factory :admin_user, parent: :user do
    role 'admin'
  end



end
