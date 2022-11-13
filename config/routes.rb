# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root 'user/provider/projects#index'

  constraints subdomain: /.*/ do
    namespace :provider do
      namespace :manager do
        resources :projects, except: [:destroy] do
          resources :accessibilities
          resources :notifications
          resources :folders
          resources :tasks do
            resources :messages
          end
        end
      end

      resources :organizations, except: [:index, :destroy, :show]
      resources :projects, except: [:show]
      resources :providers, except: [:show]
      resources :customers, only: [:index, :destroy]
      resources :invite_links, except: [:show, :update, :edit]
      resources :invitations, except: [:show, :update, :edit]
    end

    namespace :customer do
      resources :projects, only: [:show] do
        resources :folders
        resources :tasks do
          resources :messages
        end
      end
    end

    namespace :common do
      resources :invitations, only: [:index] do
        post 'common/invitations/confirm/:id', to: 'invitations#confirm', as: :confirm
        post 'common/invitations/rejected/:id', to: 'invitations#rejected', as: :rejected
      end
      resources :authorizations, only: [:index, :new, :create]
    end

    get 'cadastrar', to: 'invitations#cadastrar', as: :cadastrar
    get 'logar', to: 'invitations#logar', as: :logar
    post 'log_in', to: 'invitations#log_in', as: :log_in
  end

  namespace :user do
    namespace :common do
      resources :invitations, only: [:index] do
        post 'common/invitations/confirm/:id', to: 'invitations#confirm', as: :confirm
        post 'common/invitations/rejected/:id', to: 'invitations#rejected', as: :rejected
      end
      resources :authorizations, only: [:index, :new, :create]
    end
  end
end
