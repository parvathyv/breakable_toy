feature "User can delete an article", %q{
	As an authenticated user
	I want to delete an item
	So that no one can review it

	[x] 1) User can delete an article
	[x] 2) Only the user who posted the article can delete it
} do

let!(:user) { FactoryGirl.create(:user) }
let!(:article) { FactoryGirl.create(:article, user: user) }

scenario "User deletes an article" do

    sign_in_as(user)

    visit edit_article_path(article)
    click_on 'Delete article'

    expect(page).to have_content "Article successfully deleted"
  end
end