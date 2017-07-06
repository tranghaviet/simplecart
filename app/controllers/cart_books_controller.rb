class CartBooksController < ApplicationController
  def create
    @cart = Cart.find_by(session_id: session[:session_id])
    if @cart.nil? # cart chua ton tai
      @cart = Cart.new(session_id: session[:session_id]) # tao cart moi
      if @cart.save
        @cart_book = CartBook.new(cart_book_params) # va tao cart_book moi
        @cart_book.cart_id = @cart.id
        save_cart_book @cart_book
      else
        on_error(@cart.errors.full_messages)
      end
    else
      @cart_book = @cart.cart_books.find_by(book_id: params[:cart_book][:book_id])
      if @cart_book.nil? # cart_book chua ton tai
        @cart_book = CartBook.new(cart_book_params)
        @cart_book.cart_id = @cart.id
        save_cart_book @cart_book
      else # cart da ton tai
        @cart_book.quantity = @cart_book.quantity + params[:cart_book][:quantity].to_i
        save_cart_book @cart_book
      end
    end
  end
  
  def save_cart_book(cart_book)
    if cart_book.save
      on_success
    else
      on_error(cart_book.errors.full_messages)
    end
  end
  
  def on_success
    respond_to do |f|
      f.html {redirect_to root_path}
      f.js {render json: {status: 'success', message: "Cart was updated"}}
    end
  end
  
  def on_error(errors)
    respond_to do |f|
      f.html {redirect_to root_path}
      f.js {render json: {status: 'failure', message: errors}}
    end
  end
  
  def update
    @cart = Cart.find_by(session_id: session[:session_id])
    @cart_book = @cart.cart_books.find_by(book_id: params[:book_id])
    @cart_book.quantity = @cart_book.quantity + params[:quantity]
    save_cart_book @cart_book
    redirect_to root_path
  end
  
  def destroy
    @cart = Cart.find_by(session_id: session[:session_id])
    @cart.cart_books.find_by(book_id: params[:book_id]).destroy
    # CartBook.find(params[:id]).destroy
    redirect_to root_path
  end
  
  private
  def cart_book_params
    params.require(:cart_book).permit(:book_id, :quantity)
  end
end
