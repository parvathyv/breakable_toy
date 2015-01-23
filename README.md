# the5questiontrip
A google maps based Rails application that is a platform for users to share itineraries in the form of question and answer sets.

# Rules
* A user has to answer all five questions to complete the hunt and obtain an itinerary.
* A user has to answer the questions in order to complete the hunt.
* A user can leave a hunt at any point during a sign in session and return to continue the hunt.
* A user can play a hunt only once in a sign in session. User has to sign out and login to replay a hunt.


# Third party tools
* Google maps Javascript API for integration of the map.
* Geocoder gem for geolocation. The app uses the gem to store locations in the database for
persistence of data.
* Cookies for keeping track of user sessions in the database
* Imagemagick, along with Amazon's AWS S3 service for file uploads.
* D3 for the collapsible tree data visualization
* Devise for user management
* Omniauth for user authentication



