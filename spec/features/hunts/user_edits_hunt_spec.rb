require 'rails_helper'

feature 'User edits an article', %q(
  As an authenticated user
  I want to update an item's information
  So that I can correct errors or provide new information

  Acceptance criteria:

  [x] The user must be logged in
  [x] The user can edit an article
  [x] Only the user who posted the article can edit it
) do


  let!(:questionset){ FactoryGirl.create(:questionset) }

  scenario 'User edits an hunt',focus:true do
    sign_in_as(questionset.hunt.user)
    visit location_hunt_path(questionset.hunt.location, questionset.hunt)

    click_link 'Edit Hunt'

    fill_in 'Name', with: 'New article on Devise'

    fill_in 'Description', with: 'This article gives you
    information about devise,a user management system'

    click_button 'Update'

    expect(page).to have_content('Hunt was successfully updated.')
  end


end
