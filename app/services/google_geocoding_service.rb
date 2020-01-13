class GoogleGeocodingService
  def get_geocode_info(location)
    response = conn.get('json') do |req|
      req.params['address'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def get_location_info(lat, long)
    response = conn.get('json') do |req|
      req.params['latlng'] = "#{lat},#{long}"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(
      url: 'https://maps.googleapis.com/maps/api/geocode',
      params: { key: ENV['GOOGLE_GEOCODING_API_KEY'] }
    )
  end
end
