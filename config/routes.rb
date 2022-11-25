# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root 'user/environments#index'

  namespace :common do
    resources :environments, only: [:index]
  end

  constraints subdomain: /.*/ do  
    namespace :user do
      resources :organizations, except: [:index, :destroy, :show]
      resources :users, except: [:show]
      resources :invites, except: [:show, :update, :edit]
      resources :awards, except: [:show, :update, :edit]
      resources :dashboards,  only: [:index]
    end

    devise_for :clients, controllers: {
      sessions: 'clients/sessions',
      registrations: 'clients/registrations',
      passwords: 'clients/passwords'
    }

    namespace :client do
      resources :awards
      resources :rewards
    end
  end
end
