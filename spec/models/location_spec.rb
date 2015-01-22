require 'rails_helper'

describe Location do

  it {should have_many(:hunts).dependent(:destroy) }

  describe "#address" do
    it { should have_valid(:address).when("Boston, MA", "New York, NY, USA", "Alcatraz, San Fransisco, CA") }
    it { should_not have_valid(:address).when(nil) }
  end

  describe "#latitude" do
    it { should have_valid(:latitude).when(44.1222, 22.12) }
    it { should allow_value(44.1222).for(:latitude) }
    it { should allow_value(-119.1222).for(:longitude) }

    it { should_not allow_value("abc").for(:latitude) }

  end

  describe "#longitude" do
    it { should allow_value(-119.1222).for(:longitude) }

    it { should_not allow_value("abc").for(:longitude) }

  end



end

