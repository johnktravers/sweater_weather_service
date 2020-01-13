class CurrentWeather < Weather
  attr_reader :temp, :apparent_temp, :humidity, :visibility, :uv_index

  def initialize(info, timezone)
    super
    @temp = info[:temperature]
    @apparent_temp = info[:apparentTemperature]
    @humidity = info[:humidity]
    @visibility = info[:visibility]
    @uv_index = info[:uvIndex]
  end
end
