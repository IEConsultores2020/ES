class AddTiendaToCompra < ActiveRecord::Migration
  def change
    add_reference :compras, :tienda, index: true, foreign_key: true
  end
end
