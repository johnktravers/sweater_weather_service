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

  it 'displays an error message if the email is already taken' do
    create(:user, email: 'whatever@example.com')
    req_body = '{
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }'
    post '/api/v1/users', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]

    expect(error.count).to eq(1)
    expect(error[0][:status]).to eq('400 Bad Request')
    expect(error[0][:title]).to eq('Email has already been taken')
  end

  it 'displays an error message if the passwords do not match' do
    req_body = '{
      "email": "whatever@example.com",
      "password": "password1",
      "password_confirmation": "password2"
    }'
    post '/api/v1/users', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]

    expect(error.count).to eq(1)
    expect(error[0][:status]).to eq('400 Bad Request')
    expect(error[0][:title]).to eq("Password confirmation doesn't match Password")
  end

  it 'displays an error message if one of the fields is blank' do
    req_body = '{
      "password_confirmation": "password2"
    }'
    post '/api/v1/users', params: req_body, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]

    expect(error.count).to eq(2)
    expect(error[0][:status]).to eq('400 Bad Request')
    expect(error[0][:title]).to eq("Email can't be blank")
    expect(error[1][:status]).to eq('400 Bad Request')
    expect(error[1][:title]).to eq("Password can't be blank")
  end
end
