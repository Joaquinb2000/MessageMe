Rails.application.routes.draw do
  get "chatroom/(:id)", to: 'chatrooms#show'


  root "pages#home"
  get "login", to: 'sessions#new'
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"

  post "message", to: "messages#create"

  resources :chatrooms, except: [:show]
  resources :users
  resources :chatroom_members, except: [:index, :new, :create]

  mount ActionCable.server, at: '/cable'
end
