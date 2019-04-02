Rails.application.routes.draw do

 root to: 'teams#index'

  namespace :api do
    namespace :v1 do
      
    end
  end

  resources :teams, only: [:index]

  get '/compare' => 'comparisons#show'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
end 