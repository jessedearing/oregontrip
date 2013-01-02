class MapController < ApplicationController
  def index
    if ENV['DISABLE']
      @coords = current_location = Latitude.new
      current_location.lat = "45.5236"
      current_location.lon = "-122.6750"
      @geo_info = Hashie::Mash.new({city: 'Portland', state: 'OR'})
    else
      if Authorization.count == 0
        redirect_to latitude_auth
      end

      latitude.auth.access_token = Authorization.current.token

      if Authorization.current.updated_at + 50.minutes <= Time.now
        a = Authorization.current
        latitude.auth.refresh_token = a.renew_token
        at = latitude.auth.fetch_access_token!['access_token']
        a.token = at
        a.save!
      end

      current_location = latitude.current_location
      @coords = current_location
      @geo_info = Geocoder.search("#{current_location.lat}, #{current_location.lon}").first
      Rails.logger.debug "Geocoder info: #{@geo_info.inspect}"
    end

    respond_to do |format|
      format.html
      format.json { render :json => {
        lat: current_location.lat,
        lon: current_location.lon,
        city: "#{@geo_info.city}, #{@geo_info.state}",
        driver: Driver.current.name
      }}
    end
  end
end
