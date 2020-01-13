require 'rails_helper'

RSpec.describe 'User Registration API Endpoint' do
  it 'can register a new user with unique credentials' do
    req_body = '{
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }'
    post '/api/v1/users', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(201)

    user_key = JSON.parse(response.body, symbolize_names: true)

    expect(user_key[:api_key].length).to eq(32)
  end
end
