Rails.application.routes.draw do

  get '/list_companies', to: 'list_companies#list_company'
  post '/list_companies', to: 'list_companies#list_company'

  devise_for :users, controllers: { sessions: 'sessions', registrations: 'users/registrations' },
    path: 'accounts',
    path_names: { sign_up: 'new' }

  root to: 'dashboard#index'
  constraints(subdomain: /^(?!www\Z)(\w+)/) do #end of input of string
    resources :projects
    resources :issues
    resources :users do
    end
  end
end
