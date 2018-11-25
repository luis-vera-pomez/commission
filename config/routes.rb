Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users
    resources :products
    
    resources :teams do
      member do
        post :generate_users
      end
    end
  end

  resources :dashboard, only: [:index]

  root 'dashboard#index'
end
