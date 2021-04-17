class AddUserToSaleheaders < ActiveRecord::Migration
  def change
    add_column :saleheaders, :user, :integer
  end
end
