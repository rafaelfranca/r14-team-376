Rails.application.routes.draw do
  get 'recruitments/show'
  get 'positions' => 'positions#index'
  get 'test/index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'home#index'
end
