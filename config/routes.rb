Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
    }
  devise_for :admin, skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'cart_items', to:'public/cart_items#create'
  delete 'cart_items/:id', to:'public/cart_items#destroy'
  patch 'cart_items/:id', to:'public/cart_items#update'
  get 'cart_items', to:'public/cart_items#index', as: 'cart_item'
  delete 'cart_items', to:'public/cart_items#destroy_all'
  get 'items', to:'public/items#index'
  get 'items/:id', to:'public/items#show', as: 'item'

  get 'customers', to:'public/customers#show'
  get 'customers/edit', to:'public/customers#edit'
  patch 'customers', to:'public/customers#update'
  get 'customers/unsubscribe', to:'public/customers#unsubscribe'
  patch 'customers/withdrawal', to:'public/customers#withdrawal'

  root to:'public/homes#top'
  get '/about', to:'public/homes#about'
  


  namespace :admin do
    resources :items
    resources :genres
  end

end
