class AddUserToSaledetails < ActiveRecord::Migration
  def change
    add_column :saledetails, :user_id, :integer
  end
end
