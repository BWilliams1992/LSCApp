Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'clean_requests#index'
  resources :clean_requests
  resources :cleans
  resources :locations do
    resources :houses
  end
end
