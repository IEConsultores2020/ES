class RemoveArticuloidFromSaleheaders < ActiveRecord::Migration
  def change
    remove_column :saleheaders, :articulo_id, :integer
  end
end
