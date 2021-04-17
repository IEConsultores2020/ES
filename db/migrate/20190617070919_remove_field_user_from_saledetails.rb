class RemoveFieldUserFromSaledetails < ActiveRecord::Migration
  def change
    remove_column :saledetails, :user, :integer
  end
end
