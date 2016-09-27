Rails.application.routes.draw do
  root to: 'home#index'

  resource :sessions, only: [:new, :create, :destroy]
end
