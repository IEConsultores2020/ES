class AddColumnsToConteo < ActiveRecord::Migration
  def change
    add_column :conteos, :fecha_conteo, :date
    add_column :conteos, :cantidad_salida, :float
    add_column :conteos, :procesado, :integer
    add_column :conteos, :user_id, :integer
  end
end
