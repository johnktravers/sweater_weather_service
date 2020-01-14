class Api::V1::AntipodesController < ApplicationController
  def show
    antipode = AntipodeFacade.new(params[:location]).get_antipode
    if antipode.location_name
      serialized_antipode = AntipodeSerializer.new(antipode)
      render json: serialized_antipode
    else
      render json: antipode_error, status: 404
    end
  end

  private

  def antipode_error
    { errors:
      [{
        status: '404 Not Found',
        title: 'The given location does not have an existing antipode. Please try another location.'
      }]
    }.to_json
  end
end
