class CurrentWeather < Weather
  attr_reader :temp, :apparent_temp, :humidity, :visibility, :uv_index

  def initialize(info, timezone)
    super
    @temp = info[:temperature]
    @apparent_temp = info[:apparentTemperature]
    @humidity = (info[:humidity] * 100).to_s + '%'
    @visibility = info[:visibility].to_s + ' miles'
    @uv_index = get_uv_rating(info[:uvIndex])
  end

  private

  def get_uv_rating(uv_index)
    if uv_index < 2.5
      "#{uv_index} " + '(low)'
    elsif uv_index < 5.5
      "#{uv_index} " + '(moderate)'
    elsif uv_index < 7.5
      "#{uv_index} " + '(high)'
    elsif uv_index < 10.5
      "#{uv_index} " + '(very high)'
    else
      "#{uv_index} " + '(extreme)'
    end
  end
end
