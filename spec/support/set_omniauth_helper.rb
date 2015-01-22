module OmniauthHelper
  def set_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
    {
      provider: "github",
      uid: 12344321,
      info: {
        name: "Paul Pierce",
        email: "P2@celtix.net"
       }

    })
  end
end
