Rails.application.routes.draw do
  root "static_pages#top"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[ show edit update ] do
    member do
      get :my_posts
      get :profile
    end
  end

  resources :posts, only: %i[ index new create show edit update destroy ] do
    resources :comments, only: %i[create edit destroy], shallow: true
    collection do
      get :likes
    end
  end
  resources :likes, only: %i[ create destroy ]

  get  "diagnoses/new", to: "diagnoses#new", as: "new_diagnose"
  post "diagnoses/result", to: "diagnoses#result", as: "diagnoses_result"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
