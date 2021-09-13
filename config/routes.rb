Rails.application.routes.draw do
  get '/list_companies', to: 'list_companies#list_companies'
  post '/list_companies', to: 'list_companies#list_companies'
  devise_for :users, controllers: { registrations: 'users/registrations' },
    path: 'accounts',
    path_names: { sign_up: 'new' }

  constraints(subdomain: /^(?!www\Z)(\w+)/) do #end of input of string
    resources :projects do
      resources :sprints
      resources :issues
      resources :projects_users
    end

    resources :issues

    resources :users do
    end
  end
  root to: 'dashboard#index'
end
