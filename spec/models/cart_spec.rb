require 'rails_helper'

RSpec.describe Cart, type: :model do
  # we can use "let"
  # The value will be cached across
  # multiple calls in the same example but not across examples.
  before(:all) do
    Cart.create(session_id: 'aaaaa')
  end
  context "when create a new cart" do
    it "should be valid" do
      expect(Cart.where(session_id: 'aaaaa')).to exist
    end
    it "should not valid" do
      @cart = Cart.new(session_id: 'aaaaa')
      expect(@cart).to_not be_valid
    end
  end
end
