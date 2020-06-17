Rails.application.routes.draw do
  resources :track_playlists
  resources :playlists
  resources :user_profiles
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
