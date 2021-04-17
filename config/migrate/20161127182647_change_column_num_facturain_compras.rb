class ChangeColumnNumFacturainCompras < ActiveRecord::Migration
  def change
  	change_column :compras, :num_factura, :text
  end
end
