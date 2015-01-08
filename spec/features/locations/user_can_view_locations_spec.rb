require 'rails_helper'

feature "user can view all locations", %q(

  As a user
  I want to be able to look at all locations
  So that I can decide which part of the country I am interested in getting into

  Acceptance criteria
  [ ] A user can view an articles name, description and url

) do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:location) { FactoryGirl.create(:location) }

  scenario "a user can view all locations" do
    sign_in_as(user)
    visit locations_path

    #click_on location.address.split(',').first.upcase

    expect(page).to have_content('Choose your location')
    expect(page).to have_content(user.name)

    expect(page).to have_content(location.address.split(',').first)

  end

  scenario "unauthorized user cannot view all locations" do

    visit locations_path


    expect(page).to_not have_content('Choose your location')
    expect(page).to have_content('Sign In')

    expect(page).to_not have_content(location.address.split(',').first)

  end
end
