class AddValueToSaledetail < ActiveRecord::Migration
  def change
    add_column :saledetails, :value, :decimal
  end
end
