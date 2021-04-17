class AddInvoiceNumToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :invoice_num, :integer
  end
end
