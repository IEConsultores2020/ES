class AddArticuloToInkardex < ActiveRecord::Migration
  def change
    add_reference :inkardexes, :articulo, index: true, foreign_key: true
  end
end
