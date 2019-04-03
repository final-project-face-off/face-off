Rails.application.routes.draw do

 root to: 'teams#index'

  # THIS DOESN'T WORK
  # namespace :api do
  #   namespace :v1 do
  #     resources :teams, only: [:index, :show]
  #   end
  # end

  resources :teams, only: [:index, :show]

  
  get '/charts' => 'charts#show'
  get '/compare' => 'comparisons#show'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end