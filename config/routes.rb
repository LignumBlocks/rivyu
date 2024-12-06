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

  namespace :api do
    namespace :v1 do
      get '/hacks', to: 'hacks#index'
      get '/custom-hacks', to: 'hacks#custom_index'
      post '/hacks-sent-to-python', to: 'hacks#mark_sent_to_python'
      post '/hacks/synchronize', to: 'hacks#synchronize'
      get '/hacks/:id', to: 'hacks#index'
    end
    match '*unmatched', to: 'base#render_not_found', via: :all
  end

  get '/pages/:page' => 'pages#show', as: :page

  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#internal_server_error', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
