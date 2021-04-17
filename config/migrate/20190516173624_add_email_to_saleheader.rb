class AddEmailToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :email, :string
  end
end
