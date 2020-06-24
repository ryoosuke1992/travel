Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get :signup,       to: 'users#new'
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :plans
  resources :relationships, only: [:create, :destroy]
  get :favorites, to: 'favorites#index'
  post   "favorites/:plan_id/create"  => "favorites#create"
  delete "favorites/:plan_id/destroy" => "favorites#destroy"
  post   "participants/:plan_id/create"  => "participants#create"
  delete "participants/:plan_id/destroy" => "participants#destroy"
  resources :comments, only: [:create, :destroy]
  resources :notifications, only: :index
end
