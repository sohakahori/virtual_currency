Rails.application.routes.draw do
  # devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
    resources :users, only: :index
  end

  namespace :public do
    resources :coins, only: :index

  end

  scope module: :user do
    devise_for :users, controllers: {
      sessions: 'public/users/sessions',
      registrations: 'public/users/registrations',
      passwords: 'public/users/passwords'
    }
  end
end

