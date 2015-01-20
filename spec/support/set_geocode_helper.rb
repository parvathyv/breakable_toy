module GeocodeHelper
  def add_geocoder_stubs
    Geocoder.configure(lookup: :test)

    Geocoder::Lookup::Test.set_default_stub(
      [
        {
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731,
          'address'      => 'New York, NY, USA',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
        }
      ]
    )

    Geocoder::Lookup::Test.add_stub(
      "New York, NY, USA", [
        {
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731,
          'address'      => 'New York, NY, USA',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
        }
      ]
    )

    Geocoder::Lookup::Test.add_stub(
      "Boston, MA", [
        {
          'latitude'     => 42.119,
          'longitude'    => -118.000,
          'address'      => 'Boston, MA, USA',
          'state'        => 'Massachusetts',
          'state_code'   => 'MA',
          'country'      => 'United States',
          'country_code' => 'US'
        }
      ]
    )
  end
end
