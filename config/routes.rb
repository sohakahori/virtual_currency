Rails.application.routes.draw do
  # devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  scope module: 'admin' do
    devise_for :admins, controllers: {
        sessions: 'admin/admins/sessions',
        registrations: 'admin/admins/registrations',
        passwords: 'admin/admins/passwords'
    }
  end

  namespace :admin do
    resources :coins
    resources :shops
    resources :admins, except: [:edit, :update]
    resources :users, only: [:index, :destroy]
    resources :boards, only: [:index, :destroy] do
      resources :responses, only: [:index, :show, :destroy]
    end

  end

  namespace :public do
    root to: 'coins#index'

    resources :coins, only: :index
    resources :shops, only: [:index, :show]
    resources :user_responses, only: [:index, :destroy]
    resources :boards, only: [:index, :new, :create] do
      resources :responses, only: [:index, :new, :create]
      collection do
        resources :responses, only: [:destroy]
      end
    end
  end

  scope module: :user do
    devise_for :users, controllers: {
      sessions: 'public/users/sessions',
      registrations: 'public/users/registrations',
      passwords: 'public/users/passwords'
    }
  end
end

