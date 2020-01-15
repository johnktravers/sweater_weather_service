class Api::V1::ForecastsController < ApplicationController
  def show
    forecast = ForecastFacade.new(params[:location]).create_forecast
    serialized_forecast = ForecastSerializer.new(forecast)
    render json: serialized_forecast
  end
end
