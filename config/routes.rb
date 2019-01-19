Rails.application.routes.draw do
  apipie
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


  # API
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
      }

      resources :coins, only: :index
      resources :shops, only: [:index, :show]
      resources :boards, only: [:index, :create] do
        resources :responses, only: [:index, :create, :destroy]
      end
    end
  end
end



