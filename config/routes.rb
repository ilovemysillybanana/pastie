Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations", :omniauth_callbacks => "callbacks" }
  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end
  resources :users, :only => [:show]

  resources :user, only: :show do
    member do
      put "like" => "users#upvote"
      put "unlike" => "users#downvote"
    end
  end

  resources :listings do
    resources :comments do
      member do
        put "like" => "comments#upvote"
        put "unlike" => "comments#downvote"
      end
    end

    member do
      put "like" => "listings#upvote"
      put "unlike" => "listings#downvote"
    end

    collection do
      get 'search'
      get :autocomplete 
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
