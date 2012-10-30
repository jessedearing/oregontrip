class Latitude
  def client
    @client ||= Google::APIClient.new
  end

  def api
    client.discovered_api("latitude", "v1")
  end

  def current_location
    j = JSON.parse(client.execute(api_method: api.current_location.get).body)['data']
    {:lat => j['latitude'], :lon => j['longitude']}
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
end
