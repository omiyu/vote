Rails.application.routes.draw do
  resources :votings
  resources :makes
  resources :users
  get "/signup" => "users#new"
  get "/login" => "users#login_form"
  post "/login" => "users#login"
  get "/logout" => "users#logout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/" => "home#top"
  get "about" => "home#about"
  get "/csv_export" => "makes#csv_export"

end
