Rails.application.routes.draw do
  root 'static_pages#home'
  
  get '/help', to: 'static_pages#help'
  # 这个规则会定义两个具名路由变量，分别是 help_path 和 help_url
  # help_path -> '/help'
  # help_url  -> 'http://www.example.com/help'

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
