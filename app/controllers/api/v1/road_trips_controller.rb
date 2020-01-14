class Api::V1::RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])

    if user
      
    else

    end
  end

  private

  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination)
  end
end
