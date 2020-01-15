class RoadTripFacade
  attr_reader :origin, :destination

  def initialize(params)
    @origin = params[:origin]
    @destination = params[:destination]
  end

  def create_road_trip
    road_trip = get_road_trip(origin, destination)
    if road_trip
      set_arrival_forecast(road_trip)
      road_trip
    end
  end

  private

  def get_road_trip(origin, destination)
    maps_service = GoogleMapsService.new
    directions_info = maps_service.get_directions_info(origin, destination)
    RoadTrip.new(directions_info[:legs].first) if directions_info
  end

  def set_arrival_forecast(road_trip)
    dark_sky_service = DarkSkyService.new
    forecast_info = dark_sky_service.get_future_forecast_info(
      road_trip.end_lat,
      road_trip.end_long,
      road_trip.arrival_time
    )
    road_trip.set_arrival_forecast(forecast_info)
  end
end
