class AddDataToEinvoice < ActiveRecord::Migration
  def change
    add_column :einvoices, :data, :integer
  end
end
