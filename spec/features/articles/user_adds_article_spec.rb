require 'rails_helper'

feature 'user adds an article', %Q{
  As a user
  I want to add a tech resource
  So I can share with other users

  [x] 1) User must be signed in
  [x] 2) User should be able to add article
  [x] 3) Article must have a name (between 5-50)
  [x] 4) Article must have a URL (is valid)
  [x] 5) Article must have a description (maximum 500)
  [x] 6) Article URL must be unique
} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:article) { FactoryGirl.build(:article) }

  scenario 'user signs in and adds an article' do
    sign_in_as(user)

    add_new_article(article)

    expect(page).to have_content('Article successfully added')

  end

  scenario 'User does not fill out form at all' do
    sign_in_as(user)

    visit new_article_path

    click_button 'Submit'

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Url can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario 'User does not fill out form correctly' do

    sign_in_as(user)

    visit new_article_path
    fill_in 'Name', with: 'Bl'
    fill_in 'Url', with: 'awesome article, dude'
    fill_in 'Description', with: "
but for now, I think that these are the most salient points from my rereading of IT.  I am super glad that it wasn't nearly as scary as the first time around, although I am still not quite ready to tackle the mini-series.  I did really enjoy this commentary on the book and recommend for more consideration of it: http://www.tor.com/blogs/2013/09/the-great-stephen-king-reread-it'
but for now, I think that these are the most salient points from my rereading of IT.  I am super glad that it wasn't nearly as scary as the first time around, although I am still not quite ready to tackle the mini-series.  I did really enjoy this commentary on the book and recommend for more consideration of it: http://www.tor.com/blogs/2013/09/the-great-stephen-king-reread-it'"


    click_button 'Submit'

    expect(page).to have_content "Name is too short (minimum is 5 characters)"
    expect(page).to have_content "Url is invalid"
    expect(page).to have_content "Description is too long (maximum is 500 characters)"
  end

scenario "User enters title that is too long" do
  sign_in_as(user)

  visit new_article_path
  fill_in 'Name', with: 'Here is a title that is over 50 characters. Much too long dude! Do not be so long! You are annoying for everyone!'

  click_button 'Submit'

  expect(page).to have_content "Name is too long (maximum is 50 characters)"
  end

  scenario 'user cannot add an article that is already in the database' do
    article = FactoryGirl.create(:article)

    sign_in_as(user)

    visit new_article_path
    add_new_article(article)
    add_new_article(article)

    click_button 'Submit'
    expect(page).to_not have_content 'Article was successfully created.'

    expect(page).to have_content 'Url has already been taken'
  end

  scenario 'User must be logged in' do
    article = FactoryGirl.create(:article)
    visit new_article_path

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
