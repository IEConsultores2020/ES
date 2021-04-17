require 'rubygems'
require 'roo'
class Conteo < ActiveRecord::Base
  belongs_to :articulo 
  belongs_to :user
  validates_presence_of :articulo_id, :user_id,:fecha_conteo
  validates_uniqueness_of :articulo_id, scope: [:fecha_conteo, :user_id]
  
  def self.import(file, user)
    my_time = Time.now
    fname = "public/output/errors_conteo" + user.to_s + ".txt"
    vprocesado = 0 #indicador del proceso de cada registro leido de conteo
    total_restado = 0 #calcula total restado en el kardex
    File.open(fname,'w') do |f2|
      msj = "Inicio log nanducho cargue archivo conteos " + my_time.to_s
      f2.puts msj
      numlinea = 0
      CSV.foreach(file.path, headers: true) do |row|
        numlinea = numlinea + 1
        mi_articulo_nombre = row['articulo_nombre']
        msj = row['fecha_conteo'] + ',' +  mi_articulo_nombre + ',' + row['cantidad'] + ". Linea " + numlinea.to_s 

        if row['cantidad'].to_f < 0 then
          msj = msj  + "=>  La cantidad en conteo debe ser mayor o igual a cero."
          f2.puts msj
        elsif mi_articulo_nombre != nil then                    
          articulo = Articulo.where(["nombre = ? and user_id = ?", mi_articulo_nombre, user]).first

          if articulo != nil then            
            fecha_conteo = row['fecha_conteo'].strip.to_date        
            conteo = Conteo.where(["fecha_conteo = ? and articulo_id = ? and user_id = ?", fecha_conteo, articulo.id, user]).first
            inkardext = Inkardex.where(["articulo_id = ? and user_id = ? and existencia > ?", articulo.id, user, -0.0000001]).order("created_at DESC").first

            if conteo != nil then
              msj = msj + "=>  La linea ya fue cargada."
              f2.puts msj                      
            elsif inkardext != nil then

              if inkardext.existencia < row['cantidad'].to_d then
                msj = msj + "=>  La existencia es menor al valor del conteo"
                f2.puts msj
              else       
                cantidad =  row['cantidad'].to_d    
                total_salida = inkardext.existencia - cantidad
  
                 #validates_numericality_of total_salida, :greater_than => 0, :less_than => 10
                if total_salida == 0 then
                  vprocesado = 3
                else

                  ##msj  = "marc4"
                  f2.puts msj  
                  vprocesado = 0
                  total_restado = 0
                  temp = 0
                  #Actualizar en el kardex sacando existencias por cada compra hasta completar cantidad_salida y actualizar las demás existencias en el kardex.
                  Inkardex.where("articulo_id = ? and user_id = ? and existencia >= ? and cantidad > ?", articulo.id, user, 0.01, -0.0001).each do |inkardex|
                    #msj "entro al batch"
                    #f2.puts msj
                    #Si la existencia en el kardex es menor de lo que falta por restar
                    if inkardex.cantidad < total_salida - total_restado
                      total_restado = inkardex.cantidad + total_restado
                      inkardex.update(existencia: 0)
                      temp = total_restado
                    else #Si la existencia es mayor o igual a lo que falta por restar
                      if total_restado < total_salida then
                        grabar = 1
                      else
                        grabar = 0
                      end 
                      total_restado = total_salida
                      temp = inkardex.existencia - total_salida
                      inkardex.update(existencia: temp)
                      #SinoSi total_salida = total_restado 
                      #si existencia_kardex > total_restado 
                      #Existencia_kardex := total_restado                    
                    end #if inkardex.existencia < total_salida - total_restado
                    inkardex.save!
                    if grabar = 1 then
                      #msj = msj + "=> inkardex existencia actualizada"
                      numdocumento = "C:" + inkardex.infecha.to_s + ":" + inkardex.numdocumento 
                      conteo_inkardex = Inkardex.new(:infecha => fecha_conteo, :numdocumento => numdocumento,
                                      :cantidad => total_salida * -1 , :existencia => temp, 
                                      :valorcompra => inkardex.valorcompra, :moneda => "COP", :user_id => user, 
                                      :articulo_id => articulo.id)
                      conteo_inkardex.save!
                    end
                    #msj = msj + "=> inkardex salida creada"
                    vprocesado = 1
                  end #Inkardex.where(["articulo_id = ? and user = ? and existencia > 0"])
                end #if total_salida == 0 then
                if total_restado < total_salida then
                  vprocesado = 2
                end 
                if vprocesado != 0 then
                  conteo = Conteo.new(:fecha_conteo => fecha_conteo, :user_id => user, 
                  :articulo_id => articulo.id, 
                  :cantidad => row['cantidad'].to_d, 
                  :cantidad_salida => total_salida, 
                  :procesado => vprocesado)
                  conteo.save!

                  #Actualizo el inventario
                  inventario = Inventario.where(["user_id = ? and articulo_id = ?", user, articulo.id]).first
                  if inventario != nil then
                     inventario.cantidad_integer = cantidad.to_s
                     msj = msj + "| inventario actualizado ok"
                     inventario.save!
                  else
                     msj = msj + "| inventario NO actualizado"
                  end
                end
                if vprocesado == 0 then
                  msj = msj + " No Procesado. " + vprocesado.to_s
                elsif vprocesado == 1 then
                  msj = msj + ". OK Se actualizaron entradas y salidas completamente "+ vprocesado.to_s
                elsif vprocesado == 2
                  msj = msj + ". No se actualizaron todas las entradas y salidas de acuerdo al conteo "+ vprocesado.to_s
                elsif vprocesado == 3
                  msj = msj + ". No se registran salidas "+ vprocesado.to_s
                end #if vprocesado = 0 then
                f2.puts msj
              end #if inkardext.existencia < row[cantidad] then
            else
              #inkardext = nil 
                msj = msj + "=>  El articulo no registra entradas en el kardex."
                f2.puts msj            
            end # if unconteo != nil then
          else
            msj = msj + "=> No se encuentra el articulo"
            f2.puts msj
          end  #articulo != nil
        else
          msj = msj + "=> No existe el campo articulo_nombre" 
          f2.puts msj
        end #if row['cantidad'].to_i < 0 then
      end #CSV.foreach(file.path, headers: true) do |row|
      my_time = Time.now
      f2.puts "Fin log nanducho cargue archivo conteos" + my_time.to_s
    end #File.open(fname,'w') do |f2|    
  end #def self.import(file, user)
  
  def self.search(datefilter)
    if datefilter.blank? or datefilter == 0 then
      mi_date = Time.now  
    else
      mi_date = datefilter
    end
    where("created_at like ? ", "#{mi_date}")
  end  
  
end
