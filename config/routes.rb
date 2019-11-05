Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'sessions#new'
  resources :products
  resources :stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :users
  resources :sessions, only: [:new, :create]
  get '/logout' => 'sessions#destroy', :as => :logout
end