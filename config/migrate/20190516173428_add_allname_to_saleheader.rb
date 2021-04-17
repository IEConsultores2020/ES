class AddAllnameToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :allname, :text
  end
end
