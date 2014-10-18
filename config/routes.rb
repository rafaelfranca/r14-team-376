Rails.application.routes.draw do
  get 'test/index'

  devise_for :users

  root to: 'home#index'
end
