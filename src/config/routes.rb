Rails.application.routes.draw do
  get 'search_microposts/index'

  get 'search_users/index'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  patch '/notice_follow',   to: 'notice_followers#create'
  delete '/notice_follow',  to: 'notice_followers#destroy'
  get '/rss/:id', to: 'rsss#index', as: 'rss', defaults: { format: :rss }
  post '/search_users',   to: 'search_users#index'
  post '/search_microposts',   to: 'search_microposts#index'
  resources :users do
    member do
      get :following, :followers
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/hello', to: 'application#hello'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
