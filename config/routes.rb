require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  root 'home#index'

  resource :user, only: %i[edit update destroy]

  resources :sources
  resources :articles

  resources :hacks, only: [:index]
  resource :hack, only: [:show] do
    member do
      get :download_pdf
    end
  end

  get '/pages/:page' => 'pages#show', as: :page

  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#internal_server_error', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
