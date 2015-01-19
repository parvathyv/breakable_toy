require 'rails_helper'

describe Questionset do

  it { should belong_to :hunt}

  describe "#address",focus: true do
    it { should have_valid(:address).when("Boston, MA", "New York, NY, USA", "Alcatraz, San Fransisco, CA") }
    it { should_not have_valid(:address).when(nil) }
  end

  describe "#latitude",focus: true do
    it { should have_valid(:latitude).when(44.1222, 22.12) }
    it { should allow_value(44.1222).for(:latitude) }
    it { should allow_value(-119.1222).for(:longitude) }
    it { should validate_numericality_of(:latitude)}
    it { should_not allow_value("abc").for(:latitude) }

  end

  describe "#longitude",focus: true do
    it { should allow_value(-119.1222).for(:longitude) }
    it { should validate_numericality_of(:latitude)}
    it { should_not allow_value("abc").for(:longitude) }

  end

  describe "#hunt_id", focus: true do
    it { should have_valid(:hunt_id).when(1, 2) }
    it { should_not have_valid(:hunt_id).when(nil,"er",9.191) }
  end

  describe "#question_no", focus: true do
    it { should have_valid(:question_no).when(1, 2) }
    it { should_not have_valid(:question_no).when(nil,"er",-9.111) }
  end

  describe "#description", focus: true do

    text = ""
      501.times do
    text << "a"
      end

    it { should have_valid(:description).when("a description", "something here") }
    it { should_not have_valid(:description).when("#{text}") }
  end


  describe "#question", focus: true do

    text = ""
      301.times do
    text << "a"
      end

    it { should have_valid(:question).when("a description", "something here") }
    it { should_not have_valid(:question).when("#{text}") }
  end

end

