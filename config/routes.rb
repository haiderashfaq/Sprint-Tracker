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
    	resources :issues
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
    resources :issues do
      resources :time_logs
    end
    resources :users do
    end
  end

  get '/history', to: 'issues#history'
  resources :reports, only: :index
  get '/sprint/report', to: 'reports#sprint_report'
  get '/issue/report', to: 'reports#issue_report'

end
