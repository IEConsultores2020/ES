class AddPtax2ToArticulo < ActiveRecord::Migration
  def change
    add_column :articulos, :ptax2, :decimal
  end
end
