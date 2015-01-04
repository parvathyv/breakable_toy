require 'rails_helper'

feature 'User edits an article', %q(
	As an authenticated user
	I want to update an item's information
	So that I can correct errors or provide new information

	Acceptance criteria:

	[x] The user must be logged in
	[x] The user can edit an article
	[x] Only the user who posted the article can edit it
) do

let!(:user) { FactoryGirl.create(:user) }
let!(:article) { FactoryGirl.create(:article, user: user) }

scenario 'User edits an article' do

  sign_in_as(user)
  visit article_path(article.id)

  click_on 'Edit'

  edit_article(article.id)

  expect(page).to have_content('Article successfully edited')

  end

   scenario 'User must be logged in' do

    visit edit_article_path(article.id)

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
