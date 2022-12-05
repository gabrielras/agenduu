# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root 'user/environments#index'

  constraints subdomain: /.*/ do  
    namespace :user do
      resources :organizations, except: [:index, :destroy, :show]
      resources :users, except: [:show]
      resources :affiliates, only: [:index, :show] do
        resources :rewards, except: [:index, :show, :destroy]
      end
      resources :invites, only: [:new, :update, :create]
      resources :affiliate_campaigns
      resources :rewards
      resources :dashboards,  only: [:index]
      resources :notifications, only: [:index, :update]
      resources :environments, only: [:index]
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
