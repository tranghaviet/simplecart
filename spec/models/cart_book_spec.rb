require 'spec_helper'

RSpec.describe CartBook, type: :model do
  context "cart existed and cart_book does not exist" do
   it "make a new cart_book" do
     cart = Cart.create!(session_id: "session_id")
     cart_book = CartBook.create!(cart_id: cart.id, book_id: 1, quantity: 1)
     
     expect(CartBook.findby(cart_id: cart.id, book_id: 1)).to eq(cart_book)
   end
  end
end
