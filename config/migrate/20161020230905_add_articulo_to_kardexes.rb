class AddArticuloToKardexes < ActiveRecord::Migration
  def change
    add_reference :kardexes, :articulo, index: true, foreign_key: true
  end
end
