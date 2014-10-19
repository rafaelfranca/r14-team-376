Rails.application.routes.draw do
  resources :recruitments, only: [:show]
  get 'positions' => 'positions#index'

  resources :organizations, only: [:new, :create]

  devise_scope :user do
    get '/users/new' => 'users/registrations#new', as: :new_users
    post '/users' => 'users/registrations#create'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/:organization_id' => 'organizations#show', as: :organization

  scope '/:organization_id' do
    resources :positions, only: [:new, :create, :show], as: :organization_positions
  end

  root to: 'home#index'
end
