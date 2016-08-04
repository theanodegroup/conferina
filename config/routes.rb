Rails.application.routes.draw do
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
  resources :locations
  resources :sessions
  resources :socials
end
