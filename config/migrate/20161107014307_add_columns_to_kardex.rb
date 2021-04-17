class AddColumnsToKardex < ActiveRecord::Migration
  def change
    add_column :kardexes, :fecha_conteo, :date
    add_column :kardexes, :fecha_salida, :date
    add_column :kardexes, :cantidad_salida, :float
    add_column :kardexes, :procesado, :integer
    add_column :kardexes, :user_id, :integer
  end
end
