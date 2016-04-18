Rails.application.routes.draw do
  get 'drop_in/index'

    get 'users/new'

    get 'sign_in' => 'sessions#new', as: :sign_in
    post 'sign_in' => 'sessions#create'
    delete 'sign_in' => 'sessions#delete', as: :sign_out

    get "/users/new" => 'users#new', as: :sign_up
    post "/users" => 'users#create', as: :users

    get 'drop_in' => 'drop_in#new', as: :drop_in

    root 'home#index'
end
