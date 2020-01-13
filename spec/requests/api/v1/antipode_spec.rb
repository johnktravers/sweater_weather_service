require 'rails_helper'

RSpec.describe 'Antipode API Endpoint' do
  it 'returns the antipode city name and forecast for a given city' do
    get '/api/v1/antipode?location=hong kong, china', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    antipode_info = JSON.parse(response.body, symbolize_names: true)[:data][0]

    expect(antipode_info[:id]).to eq(1)
    expect(antipode_info[:attributes][:location_name]).to eq('La Quiaca, Argentina')
    expect(antipode_info[:attributes][:search_location]).to eq('Hong Kong, China')

    forecast_keys = [:summary, :current_temperature]
    expect(antipode_info[:attributes][:forecast][:keys]).to eq(forecast_keys)
  end
end
