Rails.application.routes.draw do
  get 'recruitments/show'
  get 'test/index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'home#index'
end
