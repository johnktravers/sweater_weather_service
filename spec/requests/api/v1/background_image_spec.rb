require 'rails_helper'

RSpec.describe 'Background Image API Endpoint' do
  it 'returns the URL of an image for a given location' do
    stub_unsplash_api('denver co', 'denver_background.json')

    get '/api/v1/backgrounds?location=denver,co', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    image_info = JSON.parse(response.body, symbolize_names: true)[:data]

    url = 'https://images.unsplash.com/photo-1521224911436-5b591bffc321?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMDU5Mn0'
    expect(image_info[:attributes][:url]).to eq(url)
    expect(image_info[:attributes][:photographer_name]).to eq('Jeff Brown')

    portfolio_url = 'http://www.jeffbrownphoto.com'
    expect(image_info[:attributes][:photographer_url]).to eq(portfolio_url)
  end

  it 'returns a default image if no image is found' do
    stub_unsplash_api('sdkljhgakfjg', 'no_background.json')

    get '/api/v1/backgrounds?location=sdkljhgakfjg', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    image_info = JSON.parse(response.body, symbolize_names: true)[:data]

    url = 'https://images.unsplash.com/photo-1528872042734-8f50f9d3c59b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMDU5Mn0'
    expect(image_info[:attributes][:url]).to eq(url)
    expect(image_info[:attributes][:photographer_name]).to eq('Agustinus Nathaniel')

    portfolio_url = 'https://agustinusnathaniel.com'
    expect(image_info[:attributes][:photographer_url]).to eq(portfolio_url)
  end
end
