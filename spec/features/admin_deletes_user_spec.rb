require 'rails_helper'

feature 'admin deletes article', %Q{
  As an admin
  I want to delete an article
  So that I can filter out unwanted articles
} do

  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user1) { FactoryGirl.create(:user) }

  scenario 'admin deletes an user' do
    sign_in_as(admin)
    visit edit_admin_user_path(user)
    click_on 'Delete user'
    expect(page).to have_content "User successfully deleted"
  end

  scenario 'authenticated user tried to delete another user' do
    sign_in_as(user)
    visit edit_admin_user_path(user1)
    expect(page).to have_content "Invalid user"
  end

end
