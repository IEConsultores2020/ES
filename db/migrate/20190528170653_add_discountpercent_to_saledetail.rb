class AddDiscountpercentToSaledetail < ActiveRecord::Migration
  def change
    add_column :saledetails, :discountpercent, :string
  end
end
