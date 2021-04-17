class AddStateToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :state, :string
  end
end
