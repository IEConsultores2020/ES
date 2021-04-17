class AddArticuloToConteos < ActiveRecord::Migration
  def change
    add_reference :conteos, :articulo, index: true, foreign_key: true
  end
end
