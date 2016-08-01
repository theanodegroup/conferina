Rails.application.routes.draw do

  get 'persons/index'

  get 'persons/new'

  get 'persons/edit'

  get 'persons/update'

  get 'persons/create'

  get 'persons/destroy'

  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :users

  resources :events
  get 'publishable/:id', to: 'events#publishable', as: 'publishable' 
  get 'event_data', to: 'events#event_data'
  get 'event_data/:id', to: 'events#event_data'

  resources :category_types
  resources :location_types
  resources :person_types
  resources :session_types

  resources :persons
end
