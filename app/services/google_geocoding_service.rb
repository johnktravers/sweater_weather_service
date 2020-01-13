class GoogleGeocodingService
  def get_geocode_info(location)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params['key'] = ENV['GOOGLE_GEOCODING_API_KEY']
      req.params['address'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
