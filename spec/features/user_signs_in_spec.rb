require 'rails_helper'

feature 'user signs in', %Q{
  As a signed up user
  I want to sign in
  So that I can regain access to my account
} do
  let!(:user) { FactoryGirl.create(:user) }
  scenario 'specify valid credentials' do
    sign_in_as(user)

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')
  end

  scenario 'user uses github to sign in', :vcr do
    Capybara.current_driver = :mechanize
    visit root_path
    click_link 'Sign in with Github'
    fill_in 'Username or Email', with: 'something'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content('This repository Explore Features Enterprise Blog Incorrect username or password.')
    expect(page).to_not have_content('Successfully authenticated')
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path

    click_button 'Log in'

    expect(page).to have_content('New Iteration')
    expect(page).to_not have_content('Sign Out')
  end
end
