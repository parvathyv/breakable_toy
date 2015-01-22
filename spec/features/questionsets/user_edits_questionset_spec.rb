require 'rails_helper'

feature 'User edits an article', %q(
  As an authenticated user
  I want to update an item's information
  So that I can correct errors or provide new information

  Acceptance criteria:

  [x] The user must be logged in
  [x] The user can edit an article
  [x] Only the user who posted the question can edit it
) do


  let!(:questionset){ FactoryGirl.create(:questionset,question_no: 2) }

  scenario 'User edits a questionset',focus:true do
    sign_in_as(questionset.hunt.user)
    visit edit_hunt_questionset_path(questionset.hunt, questionset)

    fill_in 'Question', with: 'City on the east coast'

    fill_in 'Address', with:"New York, NY, USA"
    fill_in 'Description', with:"whywhywhywhy"


    click_button 'Update'

    expect(page).to have_content('Questionset was successfully updated')
  end



end
