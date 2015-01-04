require 'rails_helper'

feature 'admin deletes article', %Q{
  As an admin
  I want to delete an article
  So that I can filter out unwanted articles
} do

  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:article) { FactoryGirl.create(:article) }

  scenario 'admin deletes an article' do
    sign_in_as(user)
    add_new_article(article)
    click_link 'Sign Out'
    expect(page).to have_content('Signed out successfully')

    sign_in_as(admin)
    visit edit_admin_article_path(article)
    click_on 'Delete article'
    expect(page).to have_content "Article successfully deleted"

    visit articles_path
    expect(page).to_not have_content article.name
  end

  scenario "authenticated user tried to delete another user's article" do
    sign_in_as(user)
    visit edit_admin_article_path(user1)
    expect(page).to have_content "Invalid user"
  end

end
