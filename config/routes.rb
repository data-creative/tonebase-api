Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      get "hello", to: "api#hello"

      resources :instruments, only: [:index, :show, :create, :update, :destroy]
      resources :advertisers, only: [:index, :show, :create, :update, :destroy]
      resources :ads, only: [:index, :show, :create, :update, :destroy] do
        scope module: "ads" do
          resources :instruments, only: [:destroy], param: :instrument_id
        end
      end
      resources :ad_placements, only: [:index, :show, :create, :update, :destroy]
      resources :ad_instruments, only: [:create, :destroy]

      resources :users, only: [:index, :show, :create, :update, :destroy] do
        scope module: "users" do
          resources :follows, only: [:index, :destroy], param: :followed_user_id
          resources :followers, only: [:index]

          resources :favorite_videos, only: [:index, :destroy], param: :video_id
        end
      end
      resources :user_followships, only: [:create, :destroy]

      resources :videos, only: [:index, :show, :create, :update, :destroy]
      resources :user_favorite_videos, only: [:index, :show, :create, :update, :destroy]
      resources :user_view_videos, only: [:index, :create]

      resources :announcements, only: [:index, :show, :create, :update, :destroy]
      resources :notifications, only: [:index, :show, :destroy]
      resources :user_notifications, only: [:update]

      namespace :metrics do
        get "users_total"
        get "users_over_time"
      end
    end
  end
end
