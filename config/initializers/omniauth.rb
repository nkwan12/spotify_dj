require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["spotify_client_id"], ENV["spotify_client_secret"],
    scope: "playlist-read-private playlist-modify-private streaming user-read-currently-playing"
end