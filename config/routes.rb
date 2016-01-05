Rails.application.routes.draw do

  root :to => "pages#index"

  get 'pages/about'
  get 'contact/contactus'

  controller :contact do
    post '/contact' => :contactus
  end

  match ':controller(/:action(/:id))', :via => [:get, :post]
end
