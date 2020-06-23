Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  namespace :api do
    namespace :v1 do
      resources :track_playlists do
        post '/up_vote' => 'track_playlists#up_vote'
        post '/down_vote' => 'track_playlists#down_vote'
      end
      resources :playlists
      resources :user_profiles
    end
  end
end
