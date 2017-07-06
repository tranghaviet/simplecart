class CartsController < ApplicationController
  include CartsHelper
  
  # def create
  #   @cart = Cart.new(cart_params)
  #   if @cart.save
  #     redirect_to edit_carts_path
  #   else
  #     redirect_to root_path
  #   end
  # end
  
  def edit
    @cart = Cart.find_by(session_id: session[:session_id])
    if @cart.nil?
      redirect_to root_path
    else
      @cart_books = @cart.cart_books
      if @cart_books.count == 0
        redirect_to root_path
      else
        render 'edit'
      end
    end
  end
  
  def update
    @cart = Cart.find_by(session_id: session[:session_id])
    @cart_books = @cart.cart_books
    params[:cart][:cart_books_attributes].each do |_, v|
      @cart_book = @cart_books.find_by(id: v["id"].to_i)
      quantity = v["quantity"].to_i
      if quantity == 0
        @cart_book.destroy
      else
        @cart_book.update_attributes(quantity: quantity)
      end
    end
    respond_to do |f|
      f.html {redirect_to edit_carts_path}
      f.js {render json: {status: 'success', message: "Cart was updated"}}
    end
  end
  
  def destroy
    Cart.find_by(session_id: session[:session_id]).destroy
    redirect_to root_path
  end
  
  private
  def cart_params
    params.require(:cart).permit(:id, cart_books_attributes: [:book_id, :quantity])
  end
end
