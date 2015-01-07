require 'rails_helper'

feature "user can view all locations", %q(

  As a user
  I want to be able to look at all locations
  So that I can decide which part of the country I am interested in getting into

  Acceptance criteria
  [ ] A user can view an articles name, description and url

) do
  let!(:hunt) { FactoryGirl.create(:hunt) }


  scenario "a user can view hunt details" do
    sign_in_as(hunt.user)
    visit location_hunt_path(hunt.location, hunt)

    expect(page).to have_content('Your itenirary')

    expect(page).to have_content(hunt.location.address.split(',').first)
    expect(page).to have_content(hunt.name)

  end


end
