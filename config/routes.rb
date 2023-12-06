Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  root to: "spots#index"

  resources :spots, only: %i[index show new create] do
    resources :participations, only: %i[new create]
    resources :events, only: [:create]
    resources :favorite_spots, only: %i[create]
  end

  resources :favorite_spots, only: %i[index destroy]

  resources :participations, only: [:show]
  resources :events, only: [:show]
  resources :teams, only: [:show]

  get 'time_until_next_action', to: 'participations#time_until_next_action'
  get 'info', to: 'pages#info'
end
