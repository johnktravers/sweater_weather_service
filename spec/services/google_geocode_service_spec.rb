require 'rails_helper'

RSpec.describe GoogleGeocodingService, type: :service do
  it 'can retrieve latitude and longitude from an address' do
    stub_geocoding_api('Denver, CO', 'denver_geocode.json')

    service = GoogleGeocodingService.new
    geocode_info = service.get_geocode_info('Denver, CO')

    expect(geocode_info[:status]).to eq('OK')
    expect(geocode_info[:results][0][:formatted_address]).to eq('Denver, CO, USA')
    expect(geocode_info[:results][0][:geometry][:location][:lat]).to eq(39.7392358)
    expect(geocode_info[:results][0][:geometry][:location][:lng]).to eq(-104.990251)
  end
end
