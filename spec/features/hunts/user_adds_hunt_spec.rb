require 'rails_helper'

feature 'user adds a location', %Q{
  As a user
  I want to add a location
  So I can share my favorite place with others

  [x] 1) User must be signed in
  [x] 2) User should be able to add location or choose existing location
  [x] 3) Location must have an address
} do


  let!(:hunt) { FactoryGirl.build(:hunt) }

  scenario 'user signs in and adds a hunt' do
    sign_in_as(hunt.user)
    visit new_location_hunt_path(hunt.location)

    fill_in 'Name', with: 'Freedom Trail'
    fill_in 'Description', with: 'Freedom Trail is the most historic walk in the oldest city in US'
    click_button 'Create'

    expect(page).to have_content('Hunt was successfully created')

  end


  scenario 'user signs in and adds a hunt incorrectly' do
    sign_in_as(hunt.user)
    visit new_location_hunt_path(hunt.location)


    click_button 'Create'

    expect(page).to_not have_content('Hunt was successfully created')
    expect(page).to have_content('Hunt was not created.')

  end

  scenario 'User must be logged in' do
    visit new_location_hunt_path(hunt.location)
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
  end
end
