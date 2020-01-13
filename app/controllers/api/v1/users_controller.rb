class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.api_key = SecureRandom.hex
    if user.save
      render json: { api_key: user.api_key }.to_json, status: 201
    else
      render json: error_messages(user), status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def error_messages(user)
    { errors: user_errors(user) }.to_json
  end

  def user_errors(user)
    user.errors.full_messages.map do |message|
      {
        status: '400 Bad Request',
        title: message
      }
    end
  end
end
