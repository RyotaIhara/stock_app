Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'stocks#index'
  resources :products
  resources :stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :members
  resources :sessions, only: [:new, :create, :destroy]
end