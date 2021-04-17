class ChangeColumnNum1FacturainCompras < ActiveRecord::Migration
  def change
  	change_column :compras, :num_factura, :string
  end
end
