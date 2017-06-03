Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :instruments, only: [:index, :show, :create, :update, :destroy]
      resources :advertisers, only: [:index, :show, :create, :update, :destroy]
      resources :ads, only: [:index, :show, :create, :update, :destroy]
      resources :ad_placements, only: [:index, :show, :create, :update, :destroy]
      resources :ad_instruments, only: [:create, :destroy]

      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :user_follows, only: [:create, :destroy]
    end
  end
end
