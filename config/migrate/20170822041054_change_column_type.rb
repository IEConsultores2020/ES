class ChangeColumnType < ActiveRecord::Migration
  def change
  	change_column :conteos, :cantidad_salida, :decimal, :precision => 16, :scale => 2
  	change_column :conteos, :cantidad, :decimal, :precision => 16, :scale => 2
  end
end
