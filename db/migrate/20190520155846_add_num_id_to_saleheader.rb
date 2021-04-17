class AddNumIdToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :num_id, :decimal
  end
end
