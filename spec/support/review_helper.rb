module ReviewHelper
  def add_new_review(article)
    visit articles_path(article)

    click_on article.name

    fill_in "Body", with: "This article fucking sucks."
    click_on "Add Review"
  end
end