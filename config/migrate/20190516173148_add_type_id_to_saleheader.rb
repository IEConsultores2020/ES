class AddTypeIdToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :typeID, :number
  end
end
