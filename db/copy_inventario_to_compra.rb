# db/copy_inventario_to_compra.rb
require 'rubygems'

Inventario.all.each do |i|
  if i.num_factura != nil
    if not i.num_factura.blank?
      compra = Compra.new(
        :num_factura =>  i.num_factura,
        :fecha_ingreso => i.fecha_ingreso,    
        :cantidad => i.cantidad_integer, 
        :valor_unidad =>  i.valor_unidad,    
        :moneda => i.moneda,    
        :valor_total => i.valor_total,
        :valor_venta => i.valor_venta,
        :user_id => i.user_id,
        :articulo_id => i.articulo_id,    
        :tienda_id => i.tienda_id
      )
      compra.save!
    end
  end
end


#then from console run:
#$rails runner db/copy_inventario_to_compra.rb