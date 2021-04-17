json.array!(@saleheaders) do |saleheader|
  json.extract! saleheader, :id
  json.url saleheader_url(saleheader, format: :json)
end
