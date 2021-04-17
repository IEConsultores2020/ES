class AddVatApplicable1ToEinvoice < ActiveRecord::Migration
  def change
    add_column :einvoices, :vat_applicable1, :date
  end
end
