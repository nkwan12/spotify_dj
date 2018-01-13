Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect("/songs")

  get '/auth/spotify/callback', to: 'admin#spotify_auth_callback'

  scope :admin, controller: :admin do
    get '/', to: "admin#index"
    post :start_party
    post :end_party
  end

  scope :songs, controller: :songs do
    get '/', to: "songs#index"
    get :search
  end
end
