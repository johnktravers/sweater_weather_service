class DarkSkyService
  def get_forecast_info(lat, long)
    response = conn.get("#{lat},#{long}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_future_forecast_info(lat, long, time)
    response = conn.get("#{lat},#{long},#{time}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(
      url: "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}",
      params: { exclude: 'minutely,alerts,flags' }
    )
  end
end
