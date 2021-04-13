Rails.application.routes.draw do

   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#top'

  # devide 管理者
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  # devide ユーザー
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  #　管理者
  namespace :admin do
    root to: 'homes#top'
    resources :personal
    resources :items
    resources :tags
    resources :users
  end

  #　ユーザー
  scope module: :user do
    get 'personal/select' => 'personal#select'
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :reviews do
      post 'like' => 'likes#create', as: 'create_like'
      delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
      resources :comments,only: [:create, :edit, :updated, :destroy]
    end
    resources :personal
    resources :tags
    resources :items do
      member do
        patch 'save_item'
      end
    end
    resources :notifications, only: :index
    get   'inquiry'         => 'inquiry#index'
    post  'inquiry/confirm' => 'inquiry#confirm'
    post  'inquiry/thanks'  => 'inquiry#thanks'
    get 'search' => 'searchs#search'
  end


end
