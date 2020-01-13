require 'rails_helper'

RSpec.describe 'Antipode API Endpoint' do
  it 'returns the antipode city name and forecast for a given city' do
    get '/api/v1/antipode?location=hong kong', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    antipode_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(antipode_info[:id]).to eq('1')
    expect(antipode_info[:attributes][:location_name]).to eq('Jujuy, Argentina')
    expect(antipode_info[:attributes][:search_location]).to eq('Hong Kong')

    forecast_keys = [:summary, :current_temp]
    expect(antipode_info[:attributes][:forecast].keys).to eq(forecast_keys)
  end

  it 'returns valid information for another city with an antipode' do
    get '/api/v1/antipode?location=jaen, spain', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    antipode_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(antipode_info[:id]).to eq('1')
    expect(antipode_info[:attributes][:location_name]).to eq('Waitao, New Zealand')
    expect(antipode_info[:attributes][:search_location]).to eq('Jaén, Spain')

    forecast_keys = [:summary, :current_temp]
    expect(antipode_info[:attributes][:forecast].keys).to eq(forecast_keys)
  end

  it 'returns a JSON error message if the antipode city does not exist' do
    get '/api/v1/antipode?location=denver, co', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

    message = 'The given location does not have an existing antipode. Please try another location.'
    expect(error[:title]).to eq(message)
    expect(error[:status]).to eq('404 Not Found')
  end
end
