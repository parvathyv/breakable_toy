require 'rails_helper'

feature 'user signs in', %Q{
  As a signed up user
  I want to sign in
  So that I can regain access to my account
} do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'specify valid credentials',focus:true do
    visit root_path
    sign_in_as(user)
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')
  end

  scenario 'user uses github to sign in', focus:true do
    set_omniauth
    visit root_path
    log_in(user)
    expect(page).to have_content('Successfully authenticated from Github account.')
  end

  scenario 'specify invalid credentials',focus:true do
    visit new_user_session_path
    click_button 'Log in'
    expect(page).to have_content('New Iteration')
    expect(page).to_not have_content('Sign Out')
  end
end
