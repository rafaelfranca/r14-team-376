Rails.application.routes.draw do
  get 'recruitments/show'
  get 'positions' => 'positions#index'
end
