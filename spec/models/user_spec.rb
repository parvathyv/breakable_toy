require 'rails_helper'

RSpec.describe User, :type => :model do
  VCR.use_cassette("synopsis") do
    response = Net::HTTP.get_response(URI("https://github.com/login?return_to=%2Flogin%2Foauth%2Fauthorize%3Fclient_id%3Dd7d188230cb45197c709%26redirect_uri%3Dhttp%253A%252F%252Flocalhost%253A3000%252Fusers%252Fauth%252Fgithub%252Fcallback%26response_type%3Dcode%26scope%3Duser%252Cpublic_repo%26state%3D77acf81f42d086ea8dfd7a93dfa67daf04d43bff71ae73fa"))

  end
end
