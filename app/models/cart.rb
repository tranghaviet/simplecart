class Cart < ApplicationRecord
  has_many :cart_books
  has_many :books, through: :cart_books
  accepts_nested_attributes_for :cart_books,
                                allow_destroy: true
end
