class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def latitude
    @latitude ||= Latitude.new.set_auth(ENV['G_CLIENT_KEY'], ENV['G_CLIENT_SECRET'], latitude_callback_url)
  end
end
