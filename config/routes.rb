Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users
    resources :products
    
    resources :teams do
      resources :agents do
        member do
          post :generate_agents
        end
      end
      
      member do
        post :generate_supervisors
        post :simulate_sales
      end
    end
  end

  resources :dashboard, only: [:index]

  root 'dashboard#index'
end
