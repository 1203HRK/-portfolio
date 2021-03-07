Rails.application.routes.draw do
  
  root to: 'home#top'

  get 'personal/show'
  get 'personal/select'
  
  #devide
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    resources :users
    resources :reviews do
      resource :likes, only: [:create, :destroy]
    end
    resources :tags
    resources :items do
      member do
        patch 'save_item'
      end
    end
    
end
