class MapController < ApplicationController
  def index
    if Authorization.count == 0
      redirect_to latitude_auth
    end

    latitude.auth.access_token = Authorization.current.token

    current_location = latitude.current_location
    @coords = current_location
    @geo_info = Geocoder.search("#{current_location.lat}, #{current_location.lon}").first
    Rails.logger.debug "Geocoder info: #{@geo_info.inspect}"
  end

  def update_coords
    latitude.auth.access_token = Authorization.current.token

    current_location = latitude.current_location

    render :json => {'lat' => current_location.lat, 'lon' => current_location.lon}
  end
end
