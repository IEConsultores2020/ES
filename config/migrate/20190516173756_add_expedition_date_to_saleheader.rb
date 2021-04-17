class AddExpeditionDateToSaleheader < ActiveRecord::Migration
  def change
    add_column :saleheaders, :expeditionDate, :date
  end
end
