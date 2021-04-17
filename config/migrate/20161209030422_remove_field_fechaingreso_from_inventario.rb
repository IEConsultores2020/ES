class RemoveFieldFechaingresoFromInventario < ActiveRecord::Migration
  def change
    remove_column :inventarios, :fecha_ingreso, :date
  end
end
