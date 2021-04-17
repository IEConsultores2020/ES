class AddArticuloToOutkardex < ActiveRecord::Migration
  def change
    add_reference :outkardexes, :articulo, index: true, foreign_key: true
  end
end
