require 'rails_helper'

describe Huntsplayeduser do
  it { should belong_to :user }
  it {should belong_to :hunt}

  describe "#question_no" do
    it { should have_valid(:question_no).when(1, 2) }
    it { should_not have_valid(:question_no).when(nil,"er",-9.111) }
  end

  describe "#hunt_id" do
    it { should have_valid(:hunt_id).when(1, 2) }
    it { should_not have_valid(:hunt_id).when(nil,"er",9.191) }
  end

  describe "#user_id" do
    it { should have_valid(:user_id).when(1, 2) }
    it { should_not have_valid(:user_id).when(nil,"er",9.191) }
  end

  describe "#user_session_id" do
    it { should have_valid(:user_session_id).when("a9200101a111111a9200101a11111132") }
    it { should_not have_valid(:user_session_id).when(nil,"er",9.191) }
  end

end

