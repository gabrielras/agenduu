# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root 'user/provider/projects#index'

  constraints subdomain: /.*/ do  
    namespace :user do
      namespace :manager do
        resources :group, except: [:destroy] do
          resources :accessibilities
          resources :clients
          resources :invites
          resources :pinned_links
          resources :rewards
          resources :tasks do
            resources :sub_tasks
          end
          resources :testimonies
        end
      end

      resources :organizations, except: [:index, :destroy, :show]
      resources :groups, except: [:show]
      resources :users, except: [:show]
      resources :clients, only: [:index, :destroy]
      resources :invites, except: [:show, :update, :edit]
      resources :ask_for_testimonies, except: [:show, :update, :edit]
      resources :awards, except: [:show, :update, :edit]
      resources :testimonies, except: [:show, :update, :edit]
      resources :dashboards,  only: [:index]
    end

    devise_for :clients, controllers: {
      sessions: 'clients/sessions',
      registrations: 'clients/registrations',
      passwords: 'clients/passwords'
    }

    namespace :client do
      resources :group, only: [:show] do
        resources :awards
        resources :tasks do
          resources :ratings
        end
      end
    end
  end
end
