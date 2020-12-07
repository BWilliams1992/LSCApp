Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'clean_requests#index'
  resources :clean_requests do
    get "/convert" => 'cleans#convert', as: :convert
  end
  resources :cleans
  resources :locations do
    resources :cost_house_locations
    resources :plots
  end
  resources :houses
  resources :invoices
end
