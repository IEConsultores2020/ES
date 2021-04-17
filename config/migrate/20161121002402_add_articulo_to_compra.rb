class AddArticuloToCompra < ActiveRecord::Migration
  def change
    add_reference :compras, :articulo, index: true, foreign_key: true
  end
end
