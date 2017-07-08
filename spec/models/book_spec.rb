require 'rails_helper'

RSpec.describe Book, type: :model do
  before(:all) do
    @book = Book.new(title: 'Conan', description: 'Detective novel', price: 50)
  end
  context "create a new book" do
    it "should be valid" do
      expect(@book).to be_valid
    end
    it "should not valid when price is not a number" do
      @book.price = 'aaa'
      expect(@book).to_not be_valid
    end
  end
end
