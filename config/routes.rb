# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    invitations: 'users/invitations'
  } do

    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get '/dashboard', to: 'dashboard#show'

  get '/terms', to: 'home#terms'

  # API version 1
  namespace :api do
    namespace :v1 do
      get '/me', format: :json, to: 'api#me'
      get '/heartbeat', format: :json, to: 'api#heartbeat'

      resources :users, only: %i[show]
      resources :regions, only: %i[index show]
      resources :clubs
      resources :vessels
      resources :ratings
      resources :events
      resources :series
    end
  end

end
