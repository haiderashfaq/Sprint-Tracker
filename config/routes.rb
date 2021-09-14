Rails.application.routes.draw do

  get '/list_companies', to: 'list_companies#list_companies'
  post '/list_companies', to: 'list_companies#list_companies'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations' },
    path: 'accounts',
    path_names: { sign_up: 'new' }

  root to: 'dashboard#index'

  constraints(subdomain: /^(?!www\Z)(\w+)/) do
    resources :projects do
      resources :sprints
      resources :projects_users
      resources :issues
    end
    resources :issues
    resources :users do
    end
  end
end
