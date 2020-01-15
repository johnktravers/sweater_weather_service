class Api::V1::BackgroundsController < ApplicationController
  def show
    image = ImageFacade.new(params[:location]).get_image
    serialized_image = ImageSerializer.new(image)
    render json: serialized_image, status: 200
  end
end
