class AntipodeForecast
  attr_reader :summary, :current_temp

  def initialize(forecast)
    @current_temp = forecast.current_weather.temp
    @summary =  forecast.current_weather.summary
  end
end
