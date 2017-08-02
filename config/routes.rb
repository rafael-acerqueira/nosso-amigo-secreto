require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  #mount Sidekiq::Web => '/sidekiq'

  get 'members/:token/opened', to: 'members#opened'
  resources :members, only: [:create, :destroy, :update]

  resources :campaigns, except: [:new] do
    post 'raffle', on: :member
  end

  root to: 'pages#home'
end
