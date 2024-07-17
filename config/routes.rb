Rails.application.routes.draw do
  scope module: :public do
    get 'users/show'
    get 'users/edit'
    devise_for :users

    devise_scope :user do
      post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    end

    root to: "homes#top"
    get 'homes/about'

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end

    resources :users
    get '/search', to: 'searches#search'
  end



  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]

    get 'post_comment_dashboards', to: 'post_comment_dashboards#index'
    resources :post_comments, only: [:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
