Rails.application.routes.draw do
  resources :recruitments, only: [:show]
  get 'positions' => 'positions#index'

  resources :organizations, only: [:new, :create]

  get '/users/new' => 'users/registrations#new', as: :new_users
  post '/users' => 'users/registrations#create'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/:organization_id' => 'organizations#show', as: :organization

  root to: 'home#index'
end
