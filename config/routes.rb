Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  devise_scope :user do
    post "sessions/user" => "devise/sessions#create"
  end

  resources :users

  resources :events
  get 'publishable/:id', to: 'events#publishable', as: 'publishable' 
  get 'event_data', to: 'events#event_data'
  get 'event_data/:id', to: 'events#event_data'
  post 'persons/search', to: 'persons#search', as: 'search_person'
  post 'locations/search', to: 'locations#search', as: 'search_location'
  post 'sessions/search', to: 'sessions#search', as: 'search_session'

  resources :category_types
  resources :location_types
  resources :person_types
  resources :session_types

  resources :persons
  resources :locations
  resources :sessions
  resources :socials
end
