class AddPtax2ToEinvoice < ActiveRecord::Migration
  def change
    add_column :einvoices, :ptax2, :decimal
  end
end
