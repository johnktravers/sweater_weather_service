class GoogleMapsService
  def get_directions_info(origin, destination)
    response = Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |req|
      req.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
      req.params['origin'] = origin
      req.params['destination'] = destination
    end

    JSON.parse(response.body, symbolize_names: true)[:routes].first
  end
end
