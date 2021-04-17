class AddUserToCompra < ActiveRecord::Migration
  def change
    add_reference :compras, :user, index: true, foreign_key: true
  end
end
