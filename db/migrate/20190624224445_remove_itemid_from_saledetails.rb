class RemoveItemidFromSaledetails < ActiveRecord::Migration
  def change
    remove_column :saledetails, :item, :decimal
  end
end
