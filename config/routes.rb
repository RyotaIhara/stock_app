Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#hello'
  get '/stocks/index', to: 'stocks#index'
  get '/stocks/show', to: 'stocks#show'
  get '/rcvs/index', to: 'rcvs#index'
  get '/rcvs/edit', to: 'rcvs#index'
  get '/sos/edit', to: 'sos#index'
end