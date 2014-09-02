Sklep::Application.routes.draw do
  localized do
    root "home#index"

    namespace :admin do
      resources :products do
        resources :variants
      end
      resources :product_types
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

    get "search", to: "search#index"
    get "search/autocomplete", to: "search#autocomplete", as: "search_autocomplete"
    get "quality", to: "home#quality"
    get "bargain", to: "products#bargain"
  end
  
end
