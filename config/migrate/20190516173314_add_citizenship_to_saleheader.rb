class AddCitizenshipToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :citizenship, :string
  end
end
