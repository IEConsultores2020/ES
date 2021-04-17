json.array!(@saledetails) do |saledetail|
  json.extract! saledetail, :id
  json.url saledetail_url(saledetail, format: :json)
end
