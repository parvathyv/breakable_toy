require 'rails_helper'

describe Hunt do

  it { should belong_to :user }
  it { should belong_to :location }
  #it {should have_many(:huntsplayedusers).dependent(:destroy) }
  it {should have_many(:questionsets).dependent(:destroy) }


  describe "#name" do
    it { should have_valid(:name).when("Freedom Trial", "Foggy Day") }
    it { should_not have_valid(:name).when(nil,"er") }
  end

  describe "#description" do

    text = ""
      501.times do
    text << "a"
      end

    it { should have_valid(:description).when("a description", "something here") }
    it { should_not have_valid(:description).when("#{text}") }
  end



end

