Rails.application.routes.draw do

  resources :invitations, except: [:new]

  resources :events

  resources :users, except: [:new, :create]

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  root "static_pages#home"

  get "/about", to: 'static_pages#about'
end
