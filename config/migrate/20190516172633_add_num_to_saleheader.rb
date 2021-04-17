class AddNumToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :num, :number
  end
end
