Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'stocks#dashBord'
  resources :products
  get 'stocks/dashBord' => 'stocks#dashBord'
  resources :stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :users
  resources :sessions, only: [:new, :create]
  resources :accounts, only: [:new, :create]
  get '/logout' => 'sessions#destroy', :as => :logout
end