Rails.application.routes.draw do

 root to: 'home#index'

  resources :teams, only: [:index, :show]

  resources :games, only: [:index, :show]

  resources :faceoff_results, only: [:create, :show]

  get '/charts' => 'charts#show'
  get '/compare' => 'comparisons#show'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end