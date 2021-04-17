require 'rubygems'
require 'roo'

class Inkardex < ActiveRecord::Base
  belongs_to :articulo 

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

  def user_name
     user.try(:name)
  end 


  validates_presence_of :infecha,  :numdocumento, :cantidad, :existencia, :moneda, :articulo_id

end
