require 'rails_helper'

feature 'user adds a location', %Q{
  As a user
  I want to add a location
  So I can share my favorite place with others

  [x] 1) User must be signed in
  [x] 2) User should be able to add location or choose existing location
  [x] 3) Location must have an address
} do


  let!(:questionset) { FactoryGirl.build(:questionset) }

=begin
  scenario 'user signs in and adds a hunt' do
    sign_in_as(questionset.hunt.user)
    visit new_hunt_questionset_path(questionset.hunt)

    fill_in 'Question', with: "What is the oldest public garden in the US"
    fill_in 'Address', with: "Boston Commons, Boston, MA"

    click_button 'Create'

    expect(page).to have_content('Question was successfully created')

  end
=end

  scenario 'user signs in and adds a questionset incorrectly' do
    sign_in_as(questionset.hunt.user)
    visit new_hunt_questionset_path(questionset.hunt)


    click_button 'Create'

    expect(page).to_not have_content('Question was successfully created')
    expect(page).to have_content('Question was not created.')

  end

  scenario 'User must be logged in' do
    visit new_hunt_questionset_path(questionset.hunt)
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
  end
end
