Rails.application.routes.draw do

  get '/list_companies', to: 'list_companies#list_companies'
  post '/list_companies', to: 'list_companies#list_companies'

  devise_for :users, controllers: { registrations: 'users/registrations' },
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
