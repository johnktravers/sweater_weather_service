require 'rails_helper'

RSpec.describe UnsplashService, type: :service do
  it 'can retrieve a photo url given a location' do
    stub_unsplash_api('denver co', 'denver_background.json')

    service = UnsplashService.new
    image_info = service.get_image_info('denver co')

    url = 'https://images.unsplash.com/photo-1521224911436-5b591bffc321?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMDU5Mn0'
    expect(image_info[:results][0][:urls][:raw]).to eq(url)

    expect(image_info[:results][0][:user][:name]).to eq('Jeff Brown')
    expect(image_info[:results][0][:user][:portfolio_url]).to eq('http://www.jeffbrownphoto.com')
  end
end
