Rails.application.routes.draw do
  get '/list_companies', to: 'list_companies#list_companies'
  post '/list_companies', to: 'list_companies#list_companies'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations' },
    path: 'accounts',
    path_names: { sign_up: 'new' }

  root to: 'dashboard#home'

  constraints(subdomain: /^(?!www\Z)(\w+)/) do
    resources :projects do
      member do
        get 'backlog'
        get 'active_sprint'
      end
      resources :sprints
      resources :projects_users
      resources :issues
    end

    resources :sprints do
      member do
        get 'start_sprint_info'
        patch 'start_sprint'
        get 'complete_sprint_info'
        post 'complete_sprint'
        get 'report'
      end
    end

    resources :issues do
      collection do
        post 'add_issues_to_sprint'
      end
    end

    resources :users do
    end

    get '/companies/search', to: 'companies#search'
              end

              get "/history", to: "issues#history"
              end
