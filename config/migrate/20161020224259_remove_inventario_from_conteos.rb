class RemoveInventarioFromConteos < ActiveRecord::Migration
  def change
    remove_reference :conteos, :inventario_id, index: true, foreign_key: true
  end
end
