Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  root to: "homes#top"
  get 'homes/about'
  resources :posts
  resources :users
  get '/search', to: 'searches#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
