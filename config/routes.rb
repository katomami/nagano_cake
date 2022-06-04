Rails.application.routes.draw do

  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  devise_for :customers, skip: [:passwords,], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
    }
  devise_for :admin, skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'cart_items', to:'public/cart_items#create'
  delete 'cart_items/:id', to:'public/cart_items#destroy', as: 'destroy_cart_item'
  patch 'cart_items/:id', to:'public/cart_items#update', as: 'update_cart_item'
  get 'cart_items', to:'public/cart_items#index', as: 'cart_item'
  delete 'cart_items', to:'public/cart_items#destroy_all', as: 'destroy_all_cart_item'
  get 'items', to:'public/items#index'
  get 'items/:id', to:'public/items#show', as: 'item'
  get 'customers/my_page', to:'public/customers#show'
  get 'customers/unsubscribe', to:'public/customers#unsubscribe'
  patch 'customers/withdrawal', to:'public/customers#withdrawal'

  root to:'public/homes#top'
  get '/about', to:'public/homes#about'
  get 'orders/new', to:'public/orders#new'
  post 'orders/confirm', to:'public/orders#confirm'
  get 'orders/thanks', to:'public/orders#thanks'
  post 'orders', to:'public/orders#create'
  get 'orders', to:'public/orders#index', as: 'orders_index'
  get 'orders/:id', to:'public/orders#show', as: 'orders_show'
  get 'addresses', to:'public/addresses#index'
  get 'addresses/:id/edit', to:'public/addresses#edit', as: 'edit_addresses'
  post 'addresses', to:'public/addresses#create'
  patch 'addresses/:id', to:'public/addresses#update', as: 'update_addresses'
  delete 'addresses/:id', to:'public/addresses#destroy', as: 'destroy_addresses'
  get 'customers/edit_mypage', to:'public/customers#edit', as:'customers_edit_mypage'
  patch 'customers/update_mypage', to:'public/customers#update', as: 'customers_update_mypage'
  get '/admin',to:'admin/homes#top'
  patch 'admin/order_details/:id', to:'admin/order_details#update', as: 'order_details_update'

  namespace :admin do
    resources :items
    resources :genres
    resources :orders
    resources :customers
  end
  namespace :public do

  end
end
