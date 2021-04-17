class AddTypeIdToSaleheaders < ActiveRecord::Migration
  def change
    add_column :saleheaders, :typeID, :string
  end
end
