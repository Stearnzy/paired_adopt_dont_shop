Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Shelter Controller Paths
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  # Pets Controller Paths
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  # Shelter Pets Controller path
  get '/shelters/:id/pets', to: 'shelter_pets#index'

  # Users Controller path
  get '/users/new', to: 'users#new'
  get '/users/:id', to: 'users#show'
  post '/users/:id', to: 'users#create'

  # Reviews Controller path
  get '/shelters/:shelter_id/review/new', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'
  get '/shelters/:shelter_id/review/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id', to: 'reviews#update'
  delete '/shelters/:shelter_id', to: 'reviews#destroy'
end
