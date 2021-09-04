Rails.application.routes.draw do

  resources :projects
  devise_for :users, controllers: { sessions: "sessions", registrations: "users/registrations" },
   path: 'accounts',
   path_names: { sign_up: 'new' }

  root to: "dashboard#index"
  constraints(subdomain: /.+/) do
    resources :users do
    end
  end
end
