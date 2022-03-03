Rails.application.routes.draw do
  get "/companies/bulk_create", to: "companies#bulk_create_form", as: :companies_bulk_create_form
  post "/companies/bulk_create", to: "companies#bulk_create", as: :companies_bulk_create
  get "/companies/bulk_update", to: "companies#bulk_update_form", as: :companies_bulk_update_form
  match "/companies/bulk_update",          to: "companies#bulk_update", via: [:patch, :put],
                                           as: :companies_bulk_update

  resources :companies
  resources :sessions
  resources :visitors
  resources :addresses
  resources :categories
  resources :password_resets
  root "blogs#index"

  resources :images
  resources :blogs
  # resources :users

  get "/users", to: "users#index", as: :users
  post "/users", to: "users#create"
  get "/users/new", to: "users#new", as:   :new_user
  get "/users/:id/edit", to: "users#edit", as: :edit_user
  get "/users/:id", to: "users#show", as: :user
  match "/users/:id",      to: "users#update", via: [:patch, :put]
  delete "/users/:id", to: "users#destroy"

  get "/albums", to: "albums#index", as: :albums
  post "/albums", to: "albums#create"
  get "/albums/new", to: "albums#new", as: :new_album

  match "*a", to: "application#routing_error", via: %i[delete get patch put post]
end
