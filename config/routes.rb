Rails.application.routes.draw do
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
end
