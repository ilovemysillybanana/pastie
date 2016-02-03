Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users, :only => [:show]

  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end

  resources :listings do
    resources :comments

    member do
      put "like" => "listings#upvote"
      put "unlike" => "listings#downvote"
    end

    collection do
      get 'search'
    end
  end

  match 'users/show', to: 'users#show', via: 'get'

  root :to => "listings#index"

  get 'pages/about'
  get 'contact/contactus'

  controller :contact do
    post '/contact' => :contactus
  end

  match ':controller(/:action(/:id))', :via => [:get, :post]
end
