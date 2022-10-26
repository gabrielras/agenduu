# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  #draw :user

  root 'user/provider/projects#index'

  get '/invitations/confirmation/:id', to: 'invitations#confirmation', as: :confirmation
  post '/invitations/authorize/:id', to: 'invitations#authorize', as: :authorize

  namespace :user do
    namespace :provider do
      namespace :manager do
        resources :projects, except: [:destroy] do

          resources :accessibilities
          resources :notifications
          resources :folders do
            resources :accessibilities
          end
          resources :tasks do
            resources :messages
            resources :accessibilities
          end
        end
      end

      resources :organizations, except: [:index, :destroy, :show]
      resources :projects, except: [:show]
      resources :roles, except: [:show]
    end
  end
end
