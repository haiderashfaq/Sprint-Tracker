Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: "sessions", registrations: "users/registrations" },
   path: 'accounts',
   path_names: { sign_up: 'new' }

  root to: "dashboard#index"
  constraints(subdomain: /.+/) do
    resources :users do
      # collection do
      #   post 'new'
      #   post 'create'
      # end
    end
  end
#   devise_for :users
#   resources :users
end
