Rails.application.routes.draw do
  resources :recruitments, only: [:show] do
    resources :recruitment_steps, only: [:show], path: 'steps'
  end

  get 'positions' => 'positions#index'

  resource :organizations, only: [:new, :create]

  get '/users/new' => 'users/registrations#new', as: :new_users
  post '/users' => 'users/registrations#create'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'home#index'
end
