require 'rails_helper'

RSpec.describe 'User Login API Endpoint' do
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

  it 'can log a user in with valid credentials' do
    req_body = '{
      "email": "whatever@example.com",
      "password": "password"
    }'
    post '/api/v1/sessions', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    user_key = JSON.parse(response.body, symbolize_names: true)

    expect(user_key[:api_key]).to eq(@user.api_key)
  end

  it 'displays an error if the credentials are invalid' do
    req_body = '{
      "email": "whatever@example.com",
      "password": "password1"
    }'
    post '/api/v1/sessions', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

    expect(error[:status]).to eq('400 Bad Request')
    expect(error[:title]).to eq('Credentials are invalid. Please try again')
  end
end
