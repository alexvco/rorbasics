Rails.application.routes.draw do
  match '/companies/bulk_create',          to: 'companies#bulk_create_form',        via: :get,           as:   :companies_bulk_create_form
  match '/companies/bulk_create',          to: 'companies#bulk_create',             via: :post,          as:   :companies_bulk_create
  match '/companies/bulk_update',          to: 'companies#bulk_update_form',        via: :get,           as:   :companies_bulk_update_form
  match '/companies/bulk_update',          to: 'companies#bulk_update',             via: [:patch, :put], as:   :companies_bulk_update

  resources :companies
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

  match '*a', to: 'application#routing_error', via: %i[delete get patch put post]
end
