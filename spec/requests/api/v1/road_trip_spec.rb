require 'rails_helper'

RSpec.describe 'Road Trip API Endpoint' do
  before :each do
    req_body = '{
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }'
    post '/api/v1/users', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    @user = User.last
  end

  it 'can create a roadtrip for a user given a valid api key' do
    req_body = {
      'origin' => 'Denver,CO',
      'destination' => 'Pueblo,CO',
      'api_key' => @user.api_key
    }.to_json
    post '/api/v1/road_trip', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    road_trip_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(road_trip_info[:type]).to eq('road_trip')
    expect(forecast_info[:attributes][:origin]).to eq('Denver, CO, USA')
    expect(forecast_info[:attributes][:destination]).to eq('Pueblo, CO, USA')
    expect(forecast_info[:attributes][:travel_time]).to eq('2 hours')

    forecast_keys = [:temp, :summary]
    expect(forecast_info[:attributes][:arrival_forecast].keys).to eq(forecast_keys)
  end
end
