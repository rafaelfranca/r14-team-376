Rails.application.routes.draw do
  resource :organizations, only: [:new, :create]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'home#index'
end
