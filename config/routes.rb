Rails.application.routes.draw do

  get '/list_companies', to: 'list_companies#list_companies'
  post '/list_companies', to: 'list_companies#list_companies'
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'users/registrations' },
    path: 'accounts',
    path_names: { sign_up: 'new' }

  root to: 'dashboard#index'
 
  constraints(subdomain: /^(?!www\Z)(\w+)/) do
    resources :projects
    resources :projects do
      resources :sprints
      resources :issues do
      resources :time_logs, shallow: true
    end
    end
    resources :users do
    end
  end
  resources :time_logs, only: [:index]
end
