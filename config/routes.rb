# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  #draw :user

  root 'user/provider/projects#index'

  namespace :user do
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
      resources :roles, except: [:show]
      resources :customers, only: [:index, :destroy]
    end

    namespace :customer do
    end

    namespace :common do
      resources :invitations, only: [:index] do
        post 'common/invitations/confirm/:id', to: 'invitations#confirm', as: :confirm
        post 'common/invitations/rejected/:id', to: 'invitations#rejected', as: :rejected
      end
      resources :authorizations, only: [:index, :new, :create]
    end
  end
end
