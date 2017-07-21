require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq'

  get 'members/:token/opened', to: 'member#opened'
  resources :members, only: [:create, :destroy, :update]

  resources :campaigns, execpt: [:new] do
    post 'raffle', on: :member
  end

  root to: 'pages#home'
end
