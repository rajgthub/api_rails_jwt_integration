Rails.application.routes.draw do
  # devise_for :users
  namespace :v1, defaults: {format: :json} do
    resources :contacts, except: :destroy
    delete "contacts/:id", to: 'contacts#delete'
    resources :sessions, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
