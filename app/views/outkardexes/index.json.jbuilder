json.array!(@outkardexes) do |outkardex|
  json.extract! outkardex, :id, :outfecha, :numdocumento, :cantidad, :valorventa, :moneda
  json.url outkardex_url(outkardex, format: :json)
end
