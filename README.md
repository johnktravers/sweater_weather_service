# Sweater Weather

Sweater Weather is a backend application built in Ruby on Rails to supply a frontend with forecast and google maps data. You can interact with the deployed version on Heroku by following this [link](https://sweater-weather-jtravers.herokuapp.com/api/v1/forecast?location=denver,co).

## Setup Instructions

To run this application on your device, navigate to your desired directory and execute the following commands:

```
git clone git@github.com:johnktravers/sweater_weather_service.git sweater_weather
cd sweater_weather
bundle install
bundle exec rake db:{create,migrate}
rails server
```

Once the commands have finished executing, open a web browser and navigate to `http://localhost:3000`. You can now access any of the endpoints discussed below.

## Endpoints

There are five endpoints that allow a user to read or create data:

1. `GET /api/v1/forecast?location=<LOCATION>` returns forecast data for the given location. This uses the Google Geocoging API to get the location's latitude and longitude and the Dark Sky API to retrieve forecast data at those coordinates.

2. `GET /api/v1/backgrounds?location=<LOCATION>` returns the URL of an image associated with the given location. This uses the Unsplash API to search for associated photos.

3. `POST /api/v1/users` with the HTTP headers `{"Content-Type": "application/json", "Accept": "application/json"}` and a JSON body containing the keys `email`, `password`, and `passwrord_confirmation` creates a user and returns the new user's API key in a JSON response.

4. `POST /api/v1/sessions` with the HTTP headers `{"Content-Type": "application/json", "Accept": "application/json"}` and a JSON body containing the keys `email` and `password` logs a user into the application by adding the user's ID to the session and returns the new user's API key in a JSON response.

5. `POST /api/v1/road_trip` with the HTTP headers `{"Content-Type": "application/json", "Accept": "application/json"}` and a JSON body containing the keys `origin`, `destination`, and `api_key` creates a new road trip for the user. The JSON response of this endpoint contains the formatted origin and destination, travel time, arrival time, and forecast information at the destination at the arrival time.
