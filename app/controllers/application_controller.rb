class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_spotify_user
    @spotify_user = Rails.cache.read(:spotify_user)
  end
end
