Postit::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  resources :users, :only => [:create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, :except => :destroy do
    resources :comments, :only => [:new, :create]
  end

  resources :categories
end
