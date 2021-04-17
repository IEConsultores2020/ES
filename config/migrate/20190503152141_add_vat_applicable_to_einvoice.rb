class AddVatApplicableToEinvoice < ActiveRecord::Migration
  def change
    add_column :einvoices, :Vat_applicable, :integer
  end
end
