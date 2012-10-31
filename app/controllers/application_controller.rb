class ApplicationController < ActionController::Base
  protect_from_forgery

  include Mobylette::RespondToMobileRequests

  mobylette_config do |config|
    config[:skip_user_agents] = [:ipad]
    config[:fallback_chains] = {
      iphone: [:mobile, :html]
    }
  end

  protected
  def latitude
    @latitude ||= Latitude.new.set_auth(ENV['G_CLIENT_KEY'], ENV['G_CLIENT_SECRET'], latitude_callback_url)
  end
end
