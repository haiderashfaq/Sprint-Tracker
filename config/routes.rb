Rails.application.routes.draw do
  get '/list_companies', to: 'list_companies#list_companies'
  post '/list_companies', to: 'list_companies#list_companies'

  devise_for :users, controllers: { registrations: 'users/registrations' },
    path: 'accounts',
    path_names: { sign_up: 'new' }

  root to: 'dashboard#index'

  constraints(subdomain: /^(?!www\Z)(\w+)/) do # end of input of string
    resources :projects do
      member do
        get 'backlog'
        get 'active_sprint'
      end
      resources :sprints
      resources :issues
      resources :projects_users
    end

    resources :sprints do
      member do
        get 'start_sprint'
        patch 'start_sprint'
        # post 'start_sprint'
        get 'complete_sprint'
        post 'complete_sprint'
      end
    end
    resources :issues do
      collection do
        post 'add_issues_to_sprint'
      end
    end
    resources :users do
    end
  end
end
