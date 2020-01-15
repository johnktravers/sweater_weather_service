require 'rails_helper'

RSpec.describe 'Road Trip API Endpoint' do
  before :each do
    @user = create(:user)
  end

  it 'can create a roadtrip for a user given a valid api key' do
    time_now = Time.parse('2020-01-14 21:12:31 -0700')
    allow(Time).to receive(:now).and_return(time_now)

    stub_maps_api('Denver, CO', 'Pueblo, CO', 'denver_pueblo_trip.json')
    stub_dark_sky_api('38.2542053,-104.6087488,1579068027', 'pueblo_forecast.json')

    req_body = {
      'origin' => 'Denver, CO',
      'destination' => 'Pueblo, CO',
      'api_key' => @user.api_key
    }.to_json
    post '/api/v1/road_trip', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    road_trip_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(road_trip_info[:type]).to eq('road_trip')
    expect(road_trip_info[:attributes][:origin]).to eq('Denver, CO, USA')
    expect(road_trip_info[:attributes][:destination]).to eq('Pueblo, CO, USA')
    expect(road_trip_info[:attributes][:travel_time]).to eq('1 hour 48 mins')

    expect(road_trip_info[:attributes][:arrival_forecast][:local_time]).to eq('11:00 PM, 01/14')
    expect(road_trip_info[:attributes][:arrival_forecast][:temperature]).to eq('36°')
    expect(road_trip_info[:attributes][:arrival_forecast][:summary]).to eq('Clear')
  end

  it 'displays an error if the api key is invalid' do
    req_body = {
      'origin' => 'Denver, CO',
      'destination' => 'Pueblo, CO',
            'api_key' => 'invalid_api_key'
    }.to_json
    post '/api/v1/road_trip', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(401)

    error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

    expect(error[:status]).to eq('401 Unauthorized')
    expect(error[:title]).to eq('Given API key is invalid. Please try again')
  end

  it 'displays an error if the api key is missing' do
    req_body = {
      'origin' => 'Denver, CO',
      'destination' => 'Pueblo, CO'
    }.to_json
    post '/api/v1/road_trip', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(401)

    error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

    expect(error[:status]).to eq('401 Unauthorized')
    expect(error[:title]).to eq('Given API key is invalid. Please try again')
  end

  it 'displays an error if origin or destination are not found' do
    stub_maps_api('denver, co', 'skajgbadkfkh', 'no_trip.json')

    req_body = {
      'origin' => 'denver, co',
      'destination' => 'skajgbadkfkh',
      'api_key' => @user.api_key
    }.to_json
    post '/api/v1/road_trip', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

    expect(error[:status]).to eq('404 Not Found')
    expect(error[:title]).to eq('Origin or destination location not found. Please try again')
  end
end
