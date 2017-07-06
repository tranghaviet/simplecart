class BooksController < ApplicationController
  def index
    @cart = Cart.find_by(session_id: session[:session_id]) || Cart.new
    @cart_books = @cart.cart_books.new
    @books = Book.paginate(page: params[:page], per_page: 12)
  end
end
