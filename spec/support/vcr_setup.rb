VCR.configure do |config|
  config.filter_sensitive_data('github') {"https://github.com/login?return_to=%2Flogin%2Foauth%2Fauthorize%3Fclient_id%3Dd7d188230cb45197c709%26redirect_uri%3Dhttp%253A%252F%252Flocalhost%253A3000%252Fusers%252Fauth%252Fgithub%252Fcallback%26response_type%3Dcode%26scope%3Duser%252Cpublic_repo%26state%3D77acf81f42d086ea8dfd7a93dfa67daf04d43bff71ae73fa"}
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = "support/vcr_cassettes"
  config.hook_into :fakeweb

  end
