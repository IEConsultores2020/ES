json.array!(@einvoices) do |einvoice|
  json.extract! einvoice, :id, 
:organizationtype, :name, :identification,  :autorization, :init_date_allow, :end_date_allow, :invoice_code, :prefix, :from, :to, :currency, :Vat_applicable
  json.url einvoice_url(einvoice, format: :json)
end

