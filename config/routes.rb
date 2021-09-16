Rails.application.routes.draw do

  get '/list_companies', to: 'list_companies#list_companies'
  post '/list_companies', to: 'list_companies#list_companies'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations' },
    path: 'accounts',
    path_names: { sign_up: 'new' }

  root to: 'dashboard#home'

  constraints(subdomain: /^(?!www\Z)(\w+)/) do
    resources :projects do
      resources :sprints
      resources :projects_users
      resources :issues
    end
    resources :issues do
      resources :time_logs
    end
    resources :users do
    end
  end

  get "/history", to: "issues#history"
end
