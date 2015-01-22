feature "User can delete an article", %q{
  As an authenticated user
  I want to delete an item
  So that no one can review it

  [x] 1) User can delete an article
  [x] 2) Only the user who posted the article can delete it
} do


  let!(:hunt) { FactoryGirl.create(:hunt) }

  scenario "User deletes an article",focus:true do

    sign_in_as(hunt.user)

    visit location_hunt_path(hunt.location, hunt)
    click_on 'Delete'

    expect(page).to have_content "Hunt successfully deleted"
  end
end
