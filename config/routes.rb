Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, only: :show

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'
  get '/login', to: "users#login_form"
  post '/login', to: "users#login_user"
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  get '/users/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/users/:user_id/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'

  namespace :user do
    get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  end  
end
