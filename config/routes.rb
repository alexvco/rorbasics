Rails.application.routes.draw do
  resources :sessions
  resources :visitors
  resources :addresses
  resources :categories
  resources :password_resets
  root 'blogs#index'

  resources :images
  resources :blogs
  # resources :users

  match '/users',          to: 'users#index',   via: :get,           as:   :users
  match '/users',          to: 'users#create',  via: :post
  match '/users/new',      to: 'users#new',     via: :get,           as:   :new_user
  match '/users/:id/edit', to: 'users#edit',    via: :get,           as:   :edit_user
  match '/users/:id',      to: 'users#show',    via: :get,           as:   :user
  match '/users/:id',      to: 'users#update',  via: [:patch, :put]
  match '/users/:id',      to: 'users#destroy', via: :delete
end
