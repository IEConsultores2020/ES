class RemoveFieldUserFromSaleheaders < ActiveRecord::Migration
  def change
    remove_column :saleheaders, :user, :integer
  end
end
