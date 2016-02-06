Rails.application.routes.draw do
  get 'reporting/attendances'

  get 'reporting/statistics'

  resources :attendances
  resources :energies
  get 'lln_imports/index'

  get 'lln_imports/import'

  resources :invoices
  resources :prices
  resources :parcels
  resources :sorting_details
  resources :sortings
  resources :washes
  resources :return_details
  resources :return_boxes
  resources :deliveries
  resources :offer_articles
  resources :offer_boxes
  resources :offers
  resources :negociated_prices
  resources :boxdetails
  resources :boxes
  resources :articles
  resources :events
  root to: 'visitors#index'
  devise_for :users
  resources :users

  resources :lln_imports do
    collection {post :import}
  end

  
end
