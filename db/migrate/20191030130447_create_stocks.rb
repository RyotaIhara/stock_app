class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :productName
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
  end
end
