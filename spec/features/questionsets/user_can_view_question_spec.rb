require 'rails_helper'

feature 'user adds a location', %Q{

  As a user
  I want to be able to look at all locations
  So that I can decide which part of the country I am interested in getting into

  Acceptance criteria
  [ ] A user can view an articles name, description and url

)} do
  let!(:questionset) { FactoryGirl.create(:questionset) }


  scenario "a user can view question",focus:true do
    sign_in_as(questionset.hunt.user)
    visit hunt_questionset_path(questionset.hunt, questionset)

    expect(page).to have_content(questionset.question)
  end



  scenario "a user answers question",focus:true do
    sign_in_as(questionset.hunt.user)
    visit hunt_questionset_path(questionset.hunt, questionset)

    fill_in 'Address', with: "Boston, MA, USA"
    click_on 'Answer'

    expect(page).to have_content("Correct, move on!")

end



end
