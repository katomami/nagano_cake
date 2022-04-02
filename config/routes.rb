Rails.application.routes.draw do
  root to:'public/homes#top'
  
  
  
    get '/about', to:'public/homes#about'

  namespace :admin do
    resources :items
    resources :genres
  end
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
    }
  devise_for :admin, skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
