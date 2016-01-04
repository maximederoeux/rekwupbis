Rails.application.routes.draw do
  resources :articles
  resources :events
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
