class DailyWeather < Weather
  attr_reader :temp_high, :temp_low, :precip_probability, :precip_type

  def initialize(info, timezone)
    super
    @temp_high = info[:temperatureHigh]
    @temp_low = info[:temperatureLow]
    @precip_probability = info[:precipProbability]
    @precip_type = info[:precipType]
  end
end
