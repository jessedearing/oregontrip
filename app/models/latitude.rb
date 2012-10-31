class Latitude
  attr_accessor :lat, :lon
  def client
    @client ||= Google::APIClient.new
  end

  def api
    client.discovered_api("latitude", "v1")
  end

  def current_location
    current_location = client.execute(api_method: api.current_location.get).body
    Rails.logger.debug "DEBUG current_location: #{current_location}"
    j = JSON.parse(current_location)['data']

    self.lat = j['latitude']
    self.lon = j['longitude']
    self
  end

  def set_auth(client_key, secret, callback_url)
    client.authorization.client_id = client_key
    client.authorization.client_secret = secret
    client.authorization.redirect_uri = callback_url
    client.authorization.scope = "https://www.googleapis.com/auth/latitude.current.best https://www.googleapis.com/auth/latitude.current.city"
    self
  end

  def auth
    client.authorization
  end

  def access_token=(token)
    auth.access_token = token
  end

  def authorize!(reup_token)
    auth.code = reup_token
    access_token = auth.fetch_access_token!
    Rails.logger.debug "DEBUG access_token: #{access_token.inspect}"
    Authorization.create!(token: access_token['access_token'], renew_token: access_token['refresh_token'])
  end
end
