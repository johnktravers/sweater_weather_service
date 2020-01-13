class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.api_key = SecureRandom.hex
    if user.save
      render json: { api_key: user.api_key }.to_json, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
