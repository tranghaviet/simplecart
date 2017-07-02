class CreateCartBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_books do |t|
      t.integer :cart_id
      t.integer :book_id
      t.integer :quantity

      t.timestamps
    end
  end
end
