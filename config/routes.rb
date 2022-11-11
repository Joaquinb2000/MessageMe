Rails.application.routes.draw do
  root "chatroom#home"
  get "login", to: 'sessions#new'
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [ :create ]

  post "message", to: "messages#create"

  mount ActionCable.server, at: '/cable'
end
