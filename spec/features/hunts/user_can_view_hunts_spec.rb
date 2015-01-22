require 'rails_helper'

feature "user can view all locations", %q(

  As a user
  I want to be able to look at all locations
  So that I can decide which part of the country I am interested in getting into

  Acceptance criteria
  [ ] A user can view an articles name, description and url

) do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:hunt) { FactoryGirl.create(:hunt) }

  scenario "a user can view all locations",focus:true do
    sign_in_as(user)
    visit locations_path
    expect(page).to have_content(user.name)
  end


end
