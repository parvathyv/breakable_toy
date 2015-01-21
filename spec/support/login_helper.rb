module LoginHelper
  def log_in(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
    {
      provider: user.provider,
      uid: user.uid,
      info: {
        name: user.name,
        email: user.email
      }

      })
  click_link "Sign in"

  end
end
