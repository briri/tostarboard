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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get '/dashboard', to: 'dashboard#show'

  get '/terms', to: 'home#terms'
end
