require 'rails_helper'

RSpec.describe GoogleMapsService, type: :service do
  it 'can retrieve directions data from a given origin and destination' do
    stub_maps_api('Denver, CO', 'Pueblo, CO', 'denver_pueblo_trip.json')

    service = GoogleMapsService.new
    geocode_info = service.get_directions_info('Denver, CO', 'Pueblo, CO')

    expect(geocode_info[:distance][:text]).to eq('114 mi')
    expect(geocode_info[:duration][:text]).to eq('1 hour 48 mins')
    expect(geocode_info[:duration][:value]).to eq(6476)

    expect(geocode_info[:start_address]).to eq('Denver, CO, USA')
    expect(geocode_info[:end_address]).to eq('Pueblo, CO, USA')
    expect(geocode_info[:end_location]).to eq({lat: 38.2542053, lng: -104.6087488})
  end
end
