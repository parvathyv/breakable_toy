require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    name 'Coolguy123'
    password 'password'
    password_confirmation 'password'
  end

  factory :location do
    sequence(:address) { |n| "#{n}Seattle, WA"}
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

    add_attribute :latitude, 41.9990
    add_attribute :longitude, 119.2378
    add_attribute :question_no, 1


    hunt

  end




  factory :admin_user, parent: :user do
    role 'admin'
  end



end
