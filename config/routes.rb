Rails.application.routes.draw do
  
  get '/list_companies', to: 'list_companies#list_company'
  post '/list_companies', to: 'list_companies#list_company'
  resources :time_logs
  resources :projects
  resources :issues
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'users/registrations' },
    path: 'accounts',
    path_names: { sign_up: 'new' }

  root to: 'dashboard#index'
  constraints(subdomain: /.+/) do
    resources :users do
    end
  end
  constraints(subdomain: '') do
    get '/accounts/sign_up', to: 'sessions#find_company'
  end
end
