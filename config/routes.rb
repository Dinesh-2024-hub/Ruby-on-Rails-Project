Rails.application.routes.draw do
  root "pages#home"

  get "home", to: "posts#index", as: :home

  resources :posts, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    resources :likes, only: [ :create, :destroy ]
    resources :comments, only: [ :create, :destroy ]
  end

  resource :session
  resources :passwords, param: :token

  resources :users, only: [ :new, :create ]

  get "users/:username", to: "users#show", as: :user_profile

  post "users/:username/follow",
       to: "follows#create",
       as: :follow_user

  delete "users/:username/follow",
         to: "follows#destroy",
         as: :unfollow_user

  get "following", to: "posts#following", as: :following

  get "up" => "rails/health#show", as: :rails_health_check
end
