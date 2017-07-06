Rails.application.routes.draw do

  get 'books/index'

  resource :carts, only: [:edit, :update, :destroy]
  resource :cart_books, only: [:create, :update, :destroy]

  root 'books#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
