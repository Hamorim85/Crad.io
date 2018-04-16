Rails.application.routes.draw do
  devise_for :brands
  resources :influencers

  resources :mailings, except: [:edit, :update, :destroy]
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
