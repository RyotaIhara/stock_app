class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :productName
      t.integer :price
      t.string :remark

      t.timestamps
    end
  end
end
