class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { api_key: user.api_key }.to_json, status: 200
    else
      render json: login_error, status: 400
    end
  end

  private

  def login_error
    { errors: [{
        status: '400 Bad Request',
        title: 'Credentials are invalid. Please try again'
      }]
    }.to_json
  end
end
