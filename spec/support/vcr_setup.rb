VCR.configure do |config|
  config.filter_sensitive_data('geocoder'){"http://maps.googleapis.com/maps/api/geocode/json?address=New+York%2C+NY%2C+USA&language=en&sensor=false"}
  config.cassette_library_dir = "support/vcr_cassettes"
  config.hook_into :fakeweb
  config.configure_rspec_metadata!
  config.default_cassette_options = { record: :new_episodes }
  config.allow_http_connections_when_no_cassette = true

end
