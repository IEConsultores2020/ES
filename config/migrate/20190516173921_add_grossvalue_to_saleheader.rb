class AddGrossvalueToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :grossvalue, :number
  end
end
