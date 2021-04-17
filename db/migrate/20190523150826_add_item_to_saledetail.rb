class AddItemToSaledetail < ActiveRecord::Migration
  def change
    add_column :saledetails, :item, :decimal
  end
end
