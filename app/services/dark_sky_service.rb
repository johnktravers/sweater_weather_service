class DarkSkyService
  def get_forecast_info(lat, long)
    url = "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{lat},#{long}"
    response = Faraday.get(url) do |req|
      req.params['exclude'] = 'minutely,alerts,flags'
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end
end
