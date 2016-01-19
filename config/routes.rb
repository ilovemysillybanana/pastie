Rails.application.routes.draw do

  devise_for :users
  resources :users, :only => [:show]

  resources :listings do
    resources :comments

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
