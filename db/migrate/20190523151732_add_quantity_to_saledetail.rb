class AddQuantityToSaledetail < ActiveRecord::Migration
  def change
    add_column :saledetails, :quantity, :float
  end
end
