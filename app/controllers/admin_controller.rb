class AdminController < ApplicationController
  before_action :set_spotify_user, except: [:spotify_auth_callback]

  def index
    # redirect_to '/auth/spotify' and return unless @spotify_user
    redirect_to "https://accounts.spotify.com/authorize?" \
      "response_type=code&client_id=#{ENV["spotify_client_id"]}" \
      "&scope=playlist-read-private+playlist-modify-private+streaming+user-read-currently-playing" \
      "&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Fspotify%2Fcallback" and return

    @playlists = @spotify_user.playlists
  end

  def spotify_auth_callback
    user = RSpotify::User.new(request.env['omniauth.auth'])
    Rails.cache.write(:spotify_user, user)
    redirect_to "/admin/"
  end

  def start_party
    Rails.cache.write(:playlist_id, params[:playlist_id])
  end

  def end_party
    Rails.cache.delete(:spotify_user)
    Rails.cache.delete(:playlist_id)
  end
end
