class LatitudeController < ApplicationController
  def auth
    redirect_to latitude.auth.authorization_uri.to_s
  end

  def callback
    latitude.auth.code = params[:code]
    access_token = latitude.auth.fetch_access_token!
    Rails.logger.debug "DEBUG access_token: #{access_token.inspect}"
    Authorization.create!(token: access_token['access_token'], renew_token: access_token['refresh_token'])
    redirect_to '/'
  end
end
