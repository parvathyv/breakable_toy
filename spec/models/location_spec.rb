require 'rails_helper'

describe Location do

  #it { should belong_to :user }

  it { should have_many(:hunts).dependent(:destroy) }

  describe "#address", focus: true do
    it { should have_valid(:address).when("Boston, MA", "New York, NY, USA", "Alcatraz, San Fransisco, CA") }
    it { should_not have_valid(:address).when(nil) }
  end

  describe "#latitude",focus: true do
    subject { FactoryGirl.create(:location) }
    #it { should have_valid(:latitude).when(44.1289, 23.2222) }
    it { should_not have_valid(:latitude).when("abc", nil, "www.web.com") }
    it { should validate_uniqueness_of([:latitude, :longitude]) }
  end

  describe "#longitude",focus: true do
    subject { FactoryGirl.create(:location) }
   # it { should have_valid(:longitude).when(-119.1289, -139.2222) }
    it { should_not have_valid(:longitude).when("abc", nil, "www.web.com") }
    it { should validate_uniqueness_of([:latitude, :longitude]) }
  end



end

