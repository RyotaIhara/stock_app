class RemoveProductNameAndPriceFromStocks < ActiveRecord::Migration[6.0]
  def change

    remove_column :stocks, :productName, :string
    remove_column :stocks, :price, :integer
  end
end
