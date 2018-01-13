class SongsController < ApplicationController
  before_action :set_spotify_user
  before_action :set_vars

  def index
    @next_track = @playlist_tracks[@current_track_index + 1]
  end

  def search
    @results = RSpotify::Track.search(params[:query], limit: 10, market: "US")
  end

  def add_to_queue
    @playlist.add_tracks!(params[:track_uri], position: @queue_index)
    Rails.cache.write("queue_index", @queue_index + 1)

    head :ok
  end

  private

  def set_vars
    @playlist = RSpotify::Playlist.find("nkwan12", Rails.cache.read(:playlist_id))
    @playlist_tracks = @playlist.tracks
    @current_track = @spotify_user.currently_playing
    @current_track_index = @playlist_tracks.index { |t| t.uri == @current_track.uri } || -1
    @queue_index = Rails.cache.fetch("queue_index") { @current_track_index + 1 }
  end
end
