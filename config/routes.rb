Sklep::Application.routes.draw do
  
  root "home#index"

  namespace :admin do
    resources :products
    root to: "home#index"
    resources :users
    resources :orders
    resources :admin_users
    devise_for :users, class_name: "AdminUser", module: :devise, path: "admin_user", controllers: {
      passwords: 'admin/passwords',
      registrations: "admin/registrations", 
      sessions: "admin/sessions"
    }
  end
  
  namespace :products do
    get "bedclothes", to: "bedclothes#index"
    get "sheets", to: "sheets#index"
  end
  
  resources :products
  
  devise_for :users, controllers: { 
    passwords: 'users/passwords',
    registrations: "users/registrations", 
    sessions: "users/sessions", 
    omniauth_callbacks: "users/omniauth_callbacks", 
    confirmations: 'users/confirmations'
  }
  
  # Cart
  
  get "cart", to: "cart_steps#show", id: "fresh"
  resource :cart, only: [:destroy]
    scope "cart/steps" do
      CartSteps::Collection::STEPS.each do |step|
      get step, to: "cart_steps#show", id: step, as: "cart_#{step}_step"
      patch step, to: "cart_steps#update", id: step
    end
  end
  
  get "cart", to: "cart_steps#show", id: "fresh"
  resources :cart_items, only: [:create]
  resources :orders, only: [:show, :index, :update]


  
  
end
