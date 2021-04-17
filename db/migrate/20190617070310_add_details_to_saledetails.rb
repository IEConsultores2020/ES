class AddDetailsToSaledetails < ActiveRecord::Migration
  def change
    add_column :saledetails, :user, :integer
    add_column :saledetails, :saleheader_id, :integer
  end
end
