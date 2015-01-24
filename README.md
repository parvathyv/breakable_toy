# the5questiontrip
A google maps based Rails application that is a platform for users to share itineraries in the form of question and answer sets akin to a treasure hunt.

# Rules
* An itinerary to be unlocked in a location of choice in presented in the form of a hunt.
* A location has many hunts. Each hunt that can be played has 5 questions.
* A user has to answer all five questions to complete the hunt and obtain an itinerary.
* A user has to answer the questions in numerical order to complete the hunt.
* A user can leave a hunt at any point during a sign in session and return to continue the hunt.
* A user can play a hunt only once in a sign in session. User has to sign out and login to replay a hunt.
* A user can use clues(infobox on the question page) for help.


# Third party tools
* Google Maps Javascript API for integration of the map.
* Geocoder gem for geolocation. The app uses the gem to store locations in the database for
persistence of data.
* Cookies for keeping track of user sessions in the database.
* D3.js for data visualization.
* Devise for user management.
* Omniauth for user authentication.
* Imagemagick and Minimagick for image manipulation.
* Carrier Wave and Amazon's AWS S3 service for file uploads.



