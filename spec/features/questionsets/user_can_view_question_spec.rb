require 'rails_helper'

feature 'user answers a question', %Q{

  As a user
  I want to be able to answer a question
  So that I can move on to the next part of the hunt

  Acceptance criteria
  [ ] A user can view a question
  [ ] A user answers the question
  [ ] A user moves on to the next part of the question
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
