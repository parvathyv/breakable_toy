VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = "support/vcr_cassettes"
  config.hook_into :fakeweb
  end
