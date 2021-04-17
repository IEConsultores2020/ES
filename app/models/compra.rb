require 'rubygems'
require 'roo'
class Compra < ActiveRecord::Base
  belongs_to :tienda
  belongs_to :articulo 
  belongs_to :user
  has_many :conteos
  validates_presence_of :num_factura, :articulo_id, :user_id,:fecha_ingreso
 # validates_uniqueness_of :articulo_id, scope: [:num_factura, :user_id, :fecha_ingreso]

  def self.import(file, user)
    my_time = Time.now
    fname = "public/output/errors_compra" + user.to_s + ".txt"
    File.open(fname,'w') do |f2|
      msj = "Inicio log nanducho cargue archivo compras " + my_time.to_s
      f2.puts msj
      numlinea = 0
      CSV.foreach(file.path, headers: true) do |row|
        numlinea = numlinea + 1
        mi_articulo_nombre = row['articulo_nombre']
        msj = row['fecha_ingreso'] + ',' + row['num_factura'] + ',' + mi_articulo_nombre + ',' + row['cantidad'] + ". Linea " + numlinea.to_s 
        if mi_articulo_nombre != nil then
          articulo = Articulo.where( ["nombre = ? and user_id = ?", mi_articulo_nombre, user]).first
          if articulo != nil then
              fecha_ingreso = row['fecha_ingreso'].strip.to_date
              numcompras = Compra.where(["num_factura = ? and fecha_ingreso = ? and user_id = ? and articulo_id = ?",  
                                    row['num_factura'].strip, fecha_ingreso, user, articulo.id]).count
            if numcompras > 0 then
                msj = msj +  "=>  No guardado, Repetido."
                f2.puts msj
            elsif row['cantidad'].to_d <= 0 or row['valor_unidad'].to_d <= 0
                msj = msj +  "=>  Cantidad y valor compra debe ser mayor a cero."
                f2.puts msj
            else                                 
              #inserto en compra
              compra = Compra.new(:num_factura => row['num_factura'].strip, :fecha_ingreso => row['fecha_ingreso'].strip,
                                  :articulo_id => articulo.id, :cantidad => row['cantidad'],:valor_unidad => row['valor_unidad'], :valor_venta => row['valor_total'])
              compra.valor_total = compra.cantidad + compra.valor_unidad
              compra.tienda_id = 2 
              compra.user_id  = user
              compra.save!           
                
              msj = msj + "> compras ok"
              #f2.puts msj

              #obtengo la cantidad actual en kardex.
              inkardexx = Inkardex.where(["user_id = ? and articulo_id=? ",user, articulo.id]).order("created_at DESC").first
              if inkardexx != nil then
                cant_inkardex = inkardexx.existencia
              else
                cant_inkardex = 0
              end 

              #inserto en inkardex
              inkardex = Inkardex.new(:infecha => compra.fecha_ingreso, :numdocumento => compra.num_factura,
                                      :cantidad => compra.cantidad, :valorcompra => compra.valor_unidad,
                                      :user_id => user, :articulo_id => compra.articulo_id)
              inkardex.moneda = 'COP'
              inkardex.existencia = inkardex.cantidad + cant_inkardex
              inkardex.save!

              msj = msj+"| kardex ok"  
              #msj = msj + "| intento inventario"
              #Y se actualiza el inventario
              inventario = Inventario.where(["user_id = ? and articulo_id = ?", user, articulo.id]).first
              if inventario != nil then
                inventario.cantidad_integer = inkardex.existencia
                msj = msj + "| inventario actualizado ok"
                inventario.save!
              else
                
                inventariox = Inventario.new(:moneda => "COP", :cantidad_integer => inkardex.existencia, 
                                          :articulo_id => compra.articulo_id, :user_id => user)
                inventariox.valor_venta = 0
                inventariox.tienda_id = 2
                inventariox.save!
                msj = msj + "| inventario creado ok"
              end        

              f2.puts msj
                               
            end
          else
            msj = msj + "=> No se encuentra el articulo"
            f2.puts msj
          end  #articulo != nil
        else
          msj = msj + "=> No existe el campo articulo" 
          f2.puts msj
        end #if mi_articulo_nombre = nil then
      end #CSV.foreach(file.path, headers: true) do |row|
      my_time = Time.now
      f2.puts "Fin log nanducho cargue archivo comrpas" + my_time.to_s
    end #File.open(fname,'w') do |f2|    
  end  
   
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |compra|
        csv << compra.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.registrarin(compra)
    inkardex = Inkardex.new(:infecha => compra.fecha_ingreso, :numdocumento => compra.num_factura,
                            :cantidad => compra.cantidad, :valorcompra => compra.valor_unidad,
                            :articulo_id => compra.articulo_id)
    #obtengo la cantidad actual en kardex.
    inkardexx = Inkardex.where(["user_id = ? and articulo_id=? ",compra.user_id, compra.articulo_id]).order("created_at DESC").first
    if inkardexx != nil then
      cant_inkardex = inkardexx.existencia
    else
      cant_inkardex = 0
    end     
    inkardex.moneda = 'COP'
    inkardex.user_id = compra.user_id
    inkardex.articulo_id = compra.articulo_id
    inkardex.existencia = inkardex.cantidad + cant_inkardex
    inkardex.save!

    inventario = Inventario.where(["user_id = ? and articulo_id = ?", compra.user_id, compra.articulo_id]).first
    if inventario != nil then
      inventario.cantidad_integer = inkardex.existencia
      inventario.save!
    else
      inventariox = Inventario.new(:moneda => "COP", :cantidad_integer => inkardex.existencia, 
                                   :articulo_id => compra.articulo_id, :user_id => compra.user_id)
      inventariox.valor_venta = 0
      inventariox.tienda_id = 2
      inventariox.user_id = compra.user_id
      inventariox.save!
    end 
  end

  def tienda_nombre
     tienda.try(:nombre)
  end 

  def tienda_nombre=(nombre)
    self.tienda = tienda.find_or_create_by_nombre(nombre) if nombre.present?
  end
   
  def articulo_nombre
     articulo.try(:nombre)
  end 
  
  def articulo_descripcion
     articulo.try(:descripcion)
  end 

  def articulo_nombre=(nombre)
    self.articulo = Articulo.find_by_nombre(nombre)  if nombre.present?
  end  

  def articulo_descripcion=(descripcion)
    self.articulo = Articulo.find_by_descripcion(descripcion)  if descripcion.present?
  end  
   
  def componente_nombre
     articulo.try(:componente_nombre)
  end 
  def componente_nombre=(componente_nombre)
    self.articulo = Articulo.find_by_componente_nombre(componente_nombre)  if componente_nombre.present?
  end  
  
  def modelo_nombre
     articulo.try(:modelo_nombre)
  end 
  def modelo_nombre=(modelo_nombre)
    self.articulo = Articulo.find_by_modelo_nombre(modelo_nombre)  if modelo_nombre.present?
  end  
  
  def medida_nombre
     articulo.try(:medida_nombre)
  end 
  
  def medida_nombre=(medida_nombre)
    self.articulo = Articulo.find_by_medida_nombre(medida_nombre)  if medida_nombre.present?
  end  
  
  def moneda
  	 'COP'
  end
  
  def valor_total
    cantidad * valor_unidad
  end 

  def self.search(query, filter, datefilter)
    if datefilter.blank? or datefilter == 0 then
    # where(:title, query) -> This would return an exact match of the query      
      joins(:articulo).where("num_factura like ? and exists (select 1 from componentes where codigo like ? and articulos.componente_id = componentes.id)", "%#{query}%", "%#{filter}%")
    else
      joins(:articulo).where("compras.fecha_ingreso =  ? and num_factura like ? and  exists (select 1 from componentes where codigo like ? and articulos.componente_id = componentes.id)", "#{datefilter}", "%#{query}%", "%#{filter}%")
    end
  end

  def user_name
     user.try(:name)
  end 


  validates_presence_of :tienda_id, :fecha_ingreso, :moneda, :articulo_id, :cantidad, :valor_unidad  

end
