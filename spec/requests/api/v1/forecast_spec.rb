require 'rails_helper'

RSpec.describe 'Forecast API Endpoint' do
  it "can return a city's weather forecast" do
    stub_geocoding_api('denver,co', 'denver_geocode.json')
    stub_dark_sky_api('39.7392358,-104.990251', 'denver_forecast.json')

    get '/api/v1/forecast?location=denver,co', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    forecast_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(forecast_info[:type]).to eq('forecast')
    expect(forecast_info[:attributes][:address]).to eq('Denver, CO, USA')

    current_keys = [:time, :summary, :icon, :temp, :apparent_temp, :humidity, :visibility, :uv_index]
    expect(forecast_info[:attributes][:current_weather].keys).to eq(current_keys)

    hourly_keys = [:time, :summary, :icon, :temp]
    expect(forecast_info[:attributes][:hourly_weather][0].keys).to eq(hourly_keys)
    expect(forecast_info[:attributes][:hourly_weather].length).to eq(24)

    daily_keys = [:time, :summary, :icon, :temp_high, :temp_low, :precip_probability, :precip_type]
    expect(forecast_info[:attributes][:daily_weather][0].keys).to eq(daily_keys)
    expect(forecast_info[:attributes][:daily_weather].length).to eq(8)
  end
end
