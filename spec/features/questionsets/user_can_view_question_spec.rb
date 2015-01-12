require 'rails_helper'

feature "user can view all locations", %q(

  As a user
  I want to be able to look at all locations
  So that I can decide which part of the country I am interested in getting into

  Acceptance criteria
  [ ] A user can view an articles name, description and url

) do
  let!(:questionset) { FactoryGirl.create(:questionset) }




  scenario "a user can view question" do
    sign_in_as(questionset.hunt.user)
    visit hunt_questionset_path(questionset.hunt, questionset)

    expect(page).to have_content(questionset.question)
  end

=begin
  scenario "a user answers question" do
    sign_in_as(questionset.hunt.user)
    visit hunt_questionset_path(questionset.hunt, questionset)

    fill_in 'Address', with: questionset.address
    click_on 'Answer'

    expect(page).to have_content("Great job on guessing")
  end


  scenario "a user answers question and moves forward one question" do
    questionset = FactoryGirl.create(:questionset)
    sign_in_as(questionset.hunt.user)
    visit hunt_questionset_path(questionset.hunt, questionset)

    fill_in 'Address', with: questionset.address
    click_on 'Answer'

    expect(page).to have_content("Great job on guessing")

=end



end
