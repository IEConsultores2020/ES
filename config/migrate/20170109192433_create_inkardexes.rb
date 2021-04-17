class CreateInkardexes < ActiveRecord::Migration
  def change
    create_table :inkardexes do |t|
      t.date :infecha
      t.string :numdocumento
      t.float :cantidad
      t.float :existencia
      t.float :valorcompra
      t.string :moneda

      t.timestamps null: false
    end
  end
end
