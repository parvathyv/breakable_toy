module ArticleHelper
  def add_new_article(article)
    visit new_article_path

    fill_in 'Name', with: article.name
    fill_in 'Url', with: article.url
    fill_in 'Description', with: article.description
    click_button 'Submit'
  end

  def edit_article(articleid)
    visit article_path(articleid)
    click_button 'Edit'

    fill_in 'Name', with: 'New article on Devise'
    fill_in 'Url', with: 'http://stackoverflow.com'
    fill_in 'Description', with: 'This article gives you information about devise,a user management system'

    click_button 'Submit'

  end

  def malicious_user
  visit new_user_registration_path

    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

  end

end