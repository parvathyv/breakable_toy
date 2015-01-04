require 'rails_helper'

feature 'admin deletes article', %Q{
  As an admin
  I want to delete an article
  So that I can filter out unwanted articles
} do

  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:review) { FactoryGirl.create(:review) }

  scenario 'admin deletes a review' do
    sign_in_as(admin)
    visit article_path(review.article)
    click_on "Edit Review"
    click_on "Delete"
    expect(page).to have_content("Review deleted")
  end

end
