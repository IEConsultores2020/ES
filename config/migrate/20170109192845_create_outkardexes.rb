class CreateOutkardexes < ActiveRecord::Migration
  def change
    create_table :outkardexes do |t|
      t.date :outfecha
      t.string :numdocumento
      t.float :cantidad
      t.float :valorventa
      t.string :moneda

      t.timestamps null: false
    end
  end
end
