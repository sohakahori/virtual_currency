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
  end
end

