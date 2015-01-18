require 'rails_helper'

describe Location do

  #it { should belong_to :user }

  it { should have_many(:hunts).dependent(:destroy) }

  describe "#address" do
    it { should have_valid(:address).when("Boston, MA", "New York, NY, USA", "Alcatraz, San Fransisco, CA") }
    it { should_not have_valid(:address).when(nil) }
  end

  describe "#latitude",focus: true do
#    subject { FactoryGirl.create(:location) }
    it { should allow_value(44.1222).for(:latitude) }
    #it { should validate_numericality_of(:latitude).is_equal_to(44.1222)}
    it { should_not allow_value("abc").for(:latitude) }
    it { should validate_uniqueness_of([:latitude, :longitude]) }
  end

  describe "#longitude" do
    subject { FactoryGirl.create(:location) }
   # it { should have_valid(:longitude).when(-119.1289, -139.2222) }
    it { should_not have_valid(:longitude).when("abc", nil, "www.web.com") }
    it { should validate_uniqueness_of([:latitude, :longitude]) }
  end



end

