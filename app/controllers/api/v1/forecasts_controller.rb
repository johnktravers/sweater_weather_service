class Api::V1::ForecastsController < ApplicationController
  def show
    forecast = ForecastFacade.new(params[:location]).create_forecast
    if forecast.class == Forecast
      serialized_forecast = ForecastSerializer.new(forecast)
      render json: serialized_forecast, status: 200
    else
      render json: not_found_error, status: 404
    end
  end

  def not_found_error
    { errors: [{
        status: '404 Not Found',
        title: 'Given location was not found. Please try again'
      }]
    }.to_json
  end
end
