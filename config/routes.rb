Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
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
