class AddTotalToSaledetail < ActiveRecord::Migration
  def change
    add_column :saledetails, :total, :float
  end
end
