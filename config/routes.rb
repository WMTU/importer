Rails.application.routes.draw do
  resources :media_assets
  root to: 'media_assets#new'

  resource :sessions, only: [:new, :create, :destroy]
end
