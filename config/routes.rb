Rails.application.routes.draw do
  get 'recruitment_steps/show'

  resources :organizations, only: [:new, :create]

  devise_scope :user do
    get '/users/new' => 'users/registrations#new', as: :new_users
    post '/users' => 'users/registrations#create'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/:organization_id' => 'organizations#show', as: :organization

  resources :positions, only: [:new, :create, :show] do
    resources :recruitments, only: [:show]
  end

  root to: 'home#index'
end
