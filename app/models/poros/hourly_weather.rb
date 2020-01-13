class HourlyWeather < Weather
  attr_reader :temp

  def initialize(info, timezone)
    super
    @temp = info[:temperature]
  end
end
