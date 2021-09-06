Rails.application.routes.draw do
  resources :issues
  resources :projects
  devise_for :users
  root to: 'issues#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
