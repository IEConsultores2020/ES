class AddUserIdToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :user_id, :integer
  end
end
