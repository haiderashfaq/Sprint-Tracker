Rails.application.routes.draw do
  resources :projects do
    resources :sprints
    resources :issues
  end

  resources :issues

  devise_for :users
  root to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
