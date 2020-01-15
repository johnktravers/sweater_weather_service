class CurrentWeather < Weather
  attr_reader :time,
              :temp,
              :apparent_temp,
              :humidity,
              :visibility,
              :uv_index

  def initialize(info, timezone)
    super
    @time = parse_local_time(info[:time], timezone)
    @temp = info[:temperature].round.to_s + '°'
    @apparent_temp = info[:apparentTemperature].round.to_s + '°'
    @humidity = (info[:humidity] * 100).to_i.to_s + '%'
    @visibility = info[:visibility].to_s + ' miles'
    @uv_index = get_uv_rating(info[:uvIndex])
  end

  private

  def parse_local_time(unix_time, timezone)
    utc_time = Time.at(unix_time).utc.to_datetime
    local_time = timezone.utc_to_local(utc_time)
    local_time.strftime('%l:%M %p, %m/%d')
  end

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
