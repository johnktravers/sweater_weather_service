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
    expect(forecast_info[:attributes][:location]).to eq('Denver, CO, USA')
    expect(forecast_info[:attributes][:today_summary]).to eq('Clear throughout the day.')
    expect(forecast_info[:attributes][:tonight_summary]).to eq('Clear')
    expect(forecast_info[:attributes][:temp_high]).to eq('59°')
    expect(forecast_info[:attributes][:temp_low]).to eq('22°')

    current_keys = [:summary, :icon, :time, :temp, :apparent_temp, :humidity, :visibility, :uv_index]
    expect(forecast_info[:attributes][:current_weather].keys).to eq(current_keys)

    hourly_keys = [:summary, :icon, :time, :temp]
    expect(forecast_info[:attributes][:hourly_weather][0].keys).to eq(hourly_keys)
    expect(forecast_info[:attributes][:hourly_weather].length).to eq(24)

    daily_keys = [:summary, :icon, :time, :temp_high, :temp_low, :precip_probability, :precip_type]
    expect(forecast_info[:attributes][:daily_weather][0].keys).to eq(daily_keys)
    expect(forecast_info[:attributes][:daily_weather].length).to eq(8)
  end

  it 'parses the time correctly for a different time zone' do
    stub_geocoding_api('new york, ny', 'nyc_geocode.json')
    stub_dark_sky_api('40.7127753,-74.0059728', 'nyc_forecast.json')

    get '/api/v1/forecast?location=new york, ny', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    forecast_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(forecast_info[:type]).to eq('forecast')
    expect(forecast_info[:attributes][:location]).to eq('New York, NY, USA')
    expect(forecast_info[:attributes][:today_summary]).to eq('Possible drizzle overnight.')
    expect(forecast_info[:attributes][:tonight_summary]).to eq('Clear')
    expect(forecast_info[:attributes][:temp_high]).to eq('54°')
    expect(forecast_info[:attributes][:temp_low]).to eq('43°')

    expect(forecast_info[:attributes][:current_weather][:time]).to eq('10:48 AM, 01/15')
    expect(forecast_info[:attributes][:hourly_weather][0][:time]).to eq('10 AM')
    expect(forecast_info[:attributes][:daily_weather][0][:time]).to eq('Wednesday, 01/15')
  end

  it 'displays an error message if the lat and long cannot be found' do
    stub_geocoding_api('asdkfgjalkbg', 'no_geocode.json')

    get '/api/v1/forecast?location=asdkfgjalkbg', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

    expect(error[:status]).to eq('404 Not Found')
    expect(error[:title]).to eq('Given location was not found. Please try again')
  end
end
