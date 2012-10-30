class MapController < ApplicationController
  def index
    if Authorization.count == 0
      redirect_to latitude_auth
    end

    latitude.auth.access_token = Authorization.order(:created_at).first.token
  end
end
