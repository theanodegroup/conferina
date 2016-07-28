Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :users

  resources :events
  resources :category_types
  resources :location_types
  resources :person_types
  resources :session_types
end
