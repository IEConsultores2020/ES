class RemoveFieldTypeIdFromSaleheader < ActiveRecord::Migration
  def change
    remove_column :saleheaders, :typeID, :integer
  end
end
