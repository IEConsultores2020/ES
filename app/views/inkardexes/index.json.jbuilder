json.array!(@inkardexes) do |inkardex|
  json.extract! inkardex, :id, :infecha, :numdocumento, :cantidad, :existencia, :valorcompra, :moneda
  json.url inkardex_url(inkardex, format: :json)
end
