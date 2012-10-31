class LatitudeController < ApplicationController
  def auth
    redirect_to latitude.auth.authorization_uri.to_s
  end

  def callback
    latitude.authorize!(params[:code])
    redirect_to '/'
  end

  def reup
    a = Authorization.order('created_at DESC').first
    latitude.auth.refresh_token = a.renew_token
    at = latitude.auth.fetch_access_token!['access_token']
    a.token = at
    a.save!
    render :text => "Reup successful"
  end
end
