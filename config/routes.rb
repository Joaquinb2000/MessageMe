Rails.application.routes.draw do
  get "chatroom/(:id)", to: 'chatrooms#show'

  root "pages#home"
  get "login", to: 'sessions#new'
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [ :create ]

  post "message", to: "messages#create"

  resources :chatrooms, except: [:show]

  mount ActionCable.server, at: '/cable'
end
