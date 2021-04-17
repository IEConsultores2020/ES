class AddTaxToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :tax, :number
  end
end
