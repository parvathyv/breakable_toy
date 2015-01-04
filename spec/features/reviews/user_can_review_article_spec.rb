require 'rails_helper'

feature "user can add a review to an article", %q(

As a user
I want to be able to review an article
So that I can desribe how I feel about its usefulness

Acceptance criteria
[ ] A user can post a review on an article.
[ ] A user can see their article posted.
[ ] User reviews should be posted with most recent first
[ ] A user
) do


  before :each do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'
  end



  let!(:article) { FactoryGirl.create(:article) }
  #
  scenario "a user can add a review to an article" do


    add_new_review(article)

    expect(page).to have_content("This article fucking sucks.")
    expect(page).to have_content("Review successfully added")

  end

  scenario "a user sees an error if they don't submit a full review" do


    visit articles_path

    click_on article.name

    click_on "Add Review"

    expect(page).to have_content("Review did fail")
  end

  scenario "a user can edit a review" do

    review = FactoryGirl.create(:review)
    visit article_path(review.article)

    # click_on review.article.name

    # fill_in "Body", with: "This article fucking sucks."
    # click_on "Add Review"

    # save_and_open_page
    click_on "Edit Review"

    fill_in "Body", with: "This article is actually awesome."
    click_on "Save"

    # save_and_open_page

    expect(page).to have_content("Review successfully edited")
    expect(page).to have_content("This article is actually awesome.")
  end

  scenario "a user can delete their review" do
    review = FactoryGirl.create(:review)
    visit article_path(review.article)

    click_on "Edit Review"

    click_on "Delete"

    expect(page).to have_content("Review deleted")
  end

end
