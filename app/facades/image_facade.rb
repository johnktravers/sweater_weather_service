class ImageFacade
  attr_reader :location

  def initialize(location)
    @location = location.gsub(/,/, ' ')
  end

  def get_image
    image_service = UnsplashService.new
    image_info = image_service.get_image_info(location)
    Image.new(image_info)
  end
end
