require 'rails_helper'

describe User do

  describe "#password", focus: true do
    it { should have_valid(:password).when("abcd1234", "asd^2jk@%#&!!") }
    it { should_not have_valid(:password).when("abc", nil, "") }
  end

  describe "#password_confirmation", focus: true do
    subject { FactoryGirl.build(:user, password: "abcd1234") }
    it { should have_valid(:password_confirmation).when("abcd1234") }
    it { should_not have_valid(:password_confirmation).when("asdasd") }
  end

  describe "#email", focus: true do
    subject { FactoryGirl.create(:user) }
    it { should have_valid(:email).when("meow@aol.com", "paddington@meow.com") }
    it { should_not have_valid(:email).when("wasd", "kitty.com", "ki@", nil, "") }
    it { should validate_uniqueness_of(:email) }
  end
end

