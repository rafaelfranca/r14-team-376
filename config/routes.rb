Rails.application.routes.draw do
  resources :recruitments, only: [:show]
  get 'positions' => 'positions#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'home#index'
end
