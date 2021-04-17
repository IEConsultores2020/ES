class AddDiscountPercentToSaledetail < ActiveRecord::Migration
  def change
    add_column :saledetails, :discount_percent, :integer
  end
end
