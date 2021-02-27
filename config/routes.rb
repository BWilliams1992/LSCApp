# frozen_string_literal: true

Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users, only: %i[show index update destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  resources :clean_requests
  resources :cleans
  resources :locations do
    resources :cost_house_locations
    resources :plots do
      resources :plot_extras
    end
  end
  resources :houses
  resources :extras
  resources :invoices
end
