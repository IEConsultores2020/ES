class AddArticuloIdToSaledetails < ActiveRecord::Migration
  def change
    add_column :saledetails, :articulo_id, :integer
  end
end
