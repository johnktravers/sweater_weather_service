class Api::V1::RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.new(road_trip_params).create_road_trip
      serialized_road_trip = RoadTripSerializer.new(road_trip)
      render json: serialized_road_trip, status: 200
    else
      render json: road_trip_error, status: 400
    end
  end

  private

  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination)
  end

  def road_trip_error
    { errors: [] }.to_json
  end
end
