require 'rails_helper'

feature "user can view all locations", %q(

  As a user
  I want to be able to look at all locations
  So that I can decide which part of the country I am interested in getting into

  Acceptance criteria
  [ ] A user can view an articles name, description and url

) do
  let!(:hunt) { FactoryGirl.create(:hunt) }


  scenario "a user can view location details" do
    sign_in_as(hunt.user)
    visit location_path(hunt.location)

    expect(page).to have_content('Create your hunt')

    expect(page).to have_content(hunt.location.address.split(',').first.upcase)
    expect(page).to have_content(hunt.name)

  end


end
