Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations => 'users/registrations'
  }

  devise_scope :user do
    get 'users/new_address_preset', to: 'users/registrations#new_address_preset'
    post 'users/create_address_preset', to: 'users/registrations#create_address_preset'
  end

  root to: "items#index"
  resources :tags, only: [:index]
  resources :items do
    resources :transactions, only: [:index, :new, :create]
    resources :comments, only: :create 
    member do
      get :purchase_confirm
      post :purchase
    end
  end
  resources :cards, only: [:index, :new, :create, :destroy]
end
