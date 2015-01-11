require 'rails_helper'

feature 'user adds a location', %Q{
  As a user
  I want to add a location
  So I can share my favorite place with others

  [x] 1) User must be signed in
  [x] 2) User should be able to add location or choose existing location
  [x] 3) Location must have an address
} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:location) { FactoryGirl.create(:location) }


  scenario 'user signs in and adds an location' do

=begin    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
    #"New York, NY", [
    #  {
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
=end

    sign_in_as(user)
    visit new_location_path

    fill_in 'Address', with: 'Boston, MA'
    click_button 'Create'

    expect(page).to have_content('Location was successfully created')

  end

  scenario 'User chooses existing location' do
    sign_in_as(user)

    visit new_location_path


    select location.address, from: 'location_id'
    click_button 'Create'
    visit new_location_hunt_path(location)

    expect(page).to have_content('Name')
  end

  scenario 'User must be logged in' do
    visit new_location_path
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
  end
end
