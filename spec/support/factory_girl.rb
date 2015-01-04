require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    name 'Coolguy123'
    password 'password'
    password_confirmation 'password'
  end

  factory :article do
    sequence(:name) {|n| "article#{n}" }
    sequence(:url) {|n| "http://www.stackoverflow#{n}.com"}
    description 'Lies and the lying liars who tell them.'
    vote_count 0

    user
  end

  factory :admin_user, parent: :user do
    role 'admin'
  end  

  factory :review do
    body "This is the super body of a super review. yeahhhhhhh"
    
    article
    user
  end
  
end
