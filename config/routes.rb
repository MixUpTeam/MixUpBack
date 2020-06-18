Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :track_playlists
      resources :playlists
      resources :user_profiles
    end
  end
end
