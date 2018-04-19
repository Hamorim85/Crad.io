Rails.application.routes.draw do
  devise_for :admins
  devise_for :brands

  resources :influencers, only: %i[index show]
  resources :mailings, except: %i[edit update destroy]

  namespace :admin do
    get '/', to: 'pages#dashboard', as: :dashboard
    resources :influencers
  end

  root to: 'pages#landing_page'
  get "/home", to: 'pages#home'
  get "/contact", to: 'pages#contact'
  post "/sendcontact", to: 'pages#sendcontact'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
