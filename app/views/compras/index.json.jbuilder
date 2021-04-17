json.array!(@compras) do |compra|
  json.extract! compra, :id, :num_factura, :fecha_ingreso, :cantidad, :valor_unidad, :moneda, :valor_total, :valor_venta
  json.url compra_url(compra, format: :json)
end
