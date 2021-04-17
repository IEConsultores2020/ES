class CreateCompras < ActiveRecord::Migration
  def change
    create_table :compras do |t|
      t.integer :num_factura
      t.date :fecha_ingreso
      t.integer :cantidad
      t.integer :valor_unidad
      t.string :moneda
      t.integer :valor_total
      t.integer :valor_venta

      t.timestamps null: false
    end
  end
end
