require 'rails_helper'
require 'faker'

# describe: example group ~ collection of test
RSpec.describe CartBook, type: :model do
  # helper method
  # Should use Factory: https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
  def fake_a_string(length)
    Faker::Lorem.characters length
  end
  
  # before(:each): run before each example in your Example Group
  before(:all) do
    @cart = Cart.create(session_id: fake_a_string(20))
    @book = Book.create(title: 'title',
                        description: 'description', price: 10)
  end
  context 'create a new cart_book' do
    it "should valid" do
      @cart_book = CartBook.create(cart_id: @cart.id,
                                   book_id: @book.id, quantity: 1)
      expect(CartBook.find_by(cart_id: @cart.id,
                              book_id: @book.id)).to eq @cart_book
    end
    it 'should not valid' do
      @cart_book = CartBook.new(cart_id: @cart.id, book_id: @book.id,
                                quantity: 0)
      expect(@cart_book).to_not be_valid
    end
  end
  # context "cart existed and cart_book does not exist" do
  #  it "make a new cart_book" do # an example, a test
  #    # should begin with: should, when...
  #    @cart = Cart.create(session_id: "session_id")
  #    @book = Book.create(title: 'title', description: "description", price: 50)
  #    cart_book = CartBook.create(cart_id: @cart.id, book_id: @book.id, quantity: 1)
  #
  #    expect(CartBook.find_by(cart_id: cart.id, book_id: 1)).to eq(cart_book)
  #    # .to OR .not_to
  #    # .to be false OR .to be true
  #    # eq is a "matcher". https://www.tutorialspoint.com/rspec/rspec_matchers.htm
  #    #a.equal?(b) # object identity - a and b refer to the same object
  #    # a.eql?(b) # object equivalence - a and b have the same value
  #    # a == b # object equivalence - a and b have the same value with type conversions]
  #    # https://relishapp.com/rspec/rspec-expectations/v/2-0/docs/matchers/equality-matchers
  #  end
  # end
end
