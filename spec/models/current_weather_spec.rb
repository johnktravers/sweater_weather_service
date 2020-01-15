require 'rails_helper'

RSpec.describe CurrentWeather, type: :model do
  it 'initializes properly' do
    uv_indices = ['1 (low)', '4 (moderate)', '6 (high)', '9 (very high)', '12 (extreme)']

    uv_indices.each do |uv_index|
      info = {
        time: 1579057200,
        temperature: 54.32,
        apparentTemperature: 48.29,
        humidity: 0.45,
        visibility: 2,
        uvIndex: uv_index.split.first.to_i
      }
      timezone = TZInfo::Timezone.get('America/Denver')
      weather = CurrentWeather.new(info, timezone)

      expect(weather.temp).to eq(54.32)
      expect(weather.apparent_temp).to eq(48.29)
      expect(weather.humidity).to eq('45.0%')
      expect(weather.visibility).to eq('2 miles')
      expect(weather.uv_index).to eq(uv_index)
    end
  end
end
