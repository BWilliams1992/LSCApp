# frozen_string_literal: true

Rails.application.routes.draw do
  get 'user/show'
  get 'user/index'
  get 'plot_extras/index'
  get 'plot_extras/show'
  get 'plot_extras/new'
  get 'plot_extras/edit'
  get 'dashboard/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  resources :clean_requests do
    get '/convert' => 'cleans#convert', as: :convert
  end
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
