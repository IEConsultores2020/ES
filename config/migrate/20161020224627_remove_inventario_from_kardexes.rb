class RemoveInventarioFromKardexes < ActiveRecord::Migration
  def change
    remove_reference :kardexes, :inventario_id, index: true, foreign_key: true
  end
end
