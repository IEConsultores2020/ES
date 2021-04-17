class AddLineToSaledetail < ActiveRecord::Migration
  def change
    add_column :saledetails, :line, :char
  end
end
