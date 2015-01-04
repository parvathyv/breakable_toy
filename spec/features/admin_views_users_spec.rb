require 'rails_helper'

feature 'admin views users', %Q{
  As an admin
  I want to view a list of users
  So that I can keep track of the site
} do

  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user1) { FactoryGirl.create(:user) }

  scenario 'admin views all users' do
    sign_in_as(admin)
    visit admin_users_path
    expect(page).to have_content user.name
    expect(page).to have_content user1.name
  end

  scenario 'authenticated user tries to view all users' do
    sign_in_as(user)
    visit admin_users_path
    expect(page).to_not have_content user.name
    expect(page).to_not have_content user1.name
  end

end
