Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  devise_scope :user do
    post "sessions/user" => "devise/sessions#create"
    get "sessions/new.user" => "devise/sessions#new"
  end

  resources :users

  resources :events
  get 'publishable/:id', to: 'events#publishable', as: 'publishable'
  get 'session_publish/:id', to: 'sessions#session_publish', as: 'session_publish' 
  get 'event_data', to: 'events#event_data'
  get 'event_data/:id', to: 'events#event_data'
  post 'search_events', to: 'events#search_events'

  post 'persons/search', to: 'persons#search', as: 'search_person'
  post 'locations/search', to: 'locations#search', as: 'search_location'
  post 'sessions/search', to: 'sessions#search', as: 'search_session'
  post 'venues/search', to: 'venues#search', as: 'search_venue'

  post 'location_types/search', to: 'location_types#search', as: 'search_location_type'
  post 'category_types/search', to: 'category_types#search', as: 'search_category_type'
  post 'person_types/search', to: 'person_types#search', as: 'search_person_type'
  post 'session_types/search', to: 'session_types#search', as: 'search_session_type'
  post 'tags/search', to: 'tags#search', as: 'search_tag'
  get 'search', to: 'searchs#search'
  post 'search', to: 'searchs#search'

  resources :category_types
  resources :location_types
  resources :person_types
  resources :session_types
  resources :tags

  resources :persons
  resources :locations
  resources :sessions
  resources :socials
  resources :venues

end
