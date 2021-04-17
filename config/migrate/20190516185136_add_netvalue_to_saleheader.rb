class AddNetvalueToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :netvalue, :number
  end
end
