require 'rails_helper'

feature 'user leaves home', %Q{
  As a signed in user
  I want to choose a path for this session
} do

  let!(:user) { FactoryGirl.create(:user) }


  scenario 'have access to add a new location' do
    sign_in_as(user)
    visit root_path
    click_link 'CREATE'

    expect(page).to have_content('New Location')
  end

  scenario 'have access to view all locations' do
    sign_in_as(user)
    visit root_path
    click_link 'EXPERIENCE'

    expect(page).to have_content('Choose your location')
  end
end
