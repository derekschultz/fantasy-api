Rails.application.routes.draw do
  resources :players
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/players/:id", to: "players#show"

  get "/search", to: "players#search"
end
