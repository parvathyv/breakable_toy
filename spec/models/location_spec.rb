require 'rails_helper'

describe Location do

  #it { should belong_to :user }

  it {should have_many(:hunts).dependent(:destroy) }
  it {should have_many(:huntsplayedusers).dependent(:destroy) }

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
    it { validate_uniqueness_of(:latitude).scoped_to(:longitude) }
  end

  describe "#longitude",focus: true do
    it { should allow_value(-119.1222).for(:longitude) }
    it { should validate_numericality_of(:latitude)}
    it { should_not allow_value("abc").for(:longitude) }
    it { validate_uniqueness_of(:latitude).scoped_to(:longitude) }
  end



end

