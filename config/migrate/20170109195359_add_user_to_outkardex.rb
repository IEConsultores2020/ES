class AddUserToOutkardex < ActiveRecord::Migration
  def change
    add_reference :outkardexes, :user, index: true, foreign_key: true
  end
end
