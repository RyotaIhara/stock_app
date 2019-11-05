class DropTableUnitprices < ActiveRecord::Migration[6.0]
  def change
    drop_table :members
  end
end
