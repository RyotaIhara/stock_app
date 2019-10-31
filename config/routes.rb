Rails.application.routes.draw do
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#hello'
  resources :stocks, only: [:index, :show, :new, :create, :destroy]
  resources :rcvs, only: [:edit]
  get '/rcvs/rcv', to: 'rcvs#rcv'
  resources :sos, only: [:edit]
  #get '/rcvs/index', to: 'rcvs#index'
  #get '/rcvs/edit', to: 'rcvs#index'
  #get '/sos/edit', to: 'sos#index'
end