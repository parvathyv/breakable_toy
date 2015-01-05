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


  factory :admin_user, parent: :user do
    role 'admin'
  end



end
