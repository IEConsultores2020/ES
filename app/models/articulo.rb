class Articulo < ActiveRecord::Base
  belongs_to :medida
  belongs_to :componente
  belongs_to :modelo
  belongs_to :user
  has_many   :inventarios
  has_many :conteos
  has_many :inkardexes, dependent: :destroy
  validates_presence_of :nombre, :descripcion, :medida_id, :componente_id, :modelo_id
  validates_uniqueness_of :nombre, scope: [:user_id]
  accepts_nested_attributes_for :inkardexes


  

def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|   
      componente = Componente.where( ["lower(nombre) = ? and user_id = ?", row['componente_id'].downcase.strip, user]).first
      modelo     = Modelo.where( ["lower(nombre) = ? and user_id = ?", row['modelo_id'].downcase.strip, user]).first
      unidad     = Medida.where( ["lower(nombre) = ? and user_id = ?", row['medida_id'].downcase.strip, user]).first       
      articulo   = Articulo.new(:nombre => row['nombre'].upcase.strip, :descripcion => row['descripcion'])      
      articulo.componente_id = componente.id 
      articulo.modelo_id = modelo.id
      articulo.medida_id = unidad.id      
      articulo.user_id = user
      articulo.save
    end
  end
  


def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |articulo|
        csv << articulo.attributes.values_at(*column_names)
      end
    end
  end
   
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then  Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then  Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.search(query, filter, datefilter)
    if datefilter.blank? or datefilter == 0 then
    # where(:title, query) -> This would return an exact match of the query      
      joins(:compra).where("articulo_id like ? 
        and exists (select 1 from compras where fecha_ingreso like ? 
        and articulos.id = compra.articulo_id)", "%#{query}%", "%#{filter}%")
    else
      joins(:articulo).where("compras.fecha_ingreso =  ? and num_factura like ? and  exists (select 1 from componentes where codigo like ? and articulos.componente_id = componentes.id)", "#{datefilter}", "%#{query}%", "%#{filter}%")
    end
  end
  
  #Este search2 funciona para rotacion de inventarios
  def self.search2(arti, fecha_inicio, fecha_final)    
        Articulo.where("articulo_id like ? 
        and fecha_ingreso between ? and ? 
        and articulos.id = compra.articulo_id)", "%#{arti}%", "%#{fecha_inicio}%", "%#{fecha_final}%")  
  end

  def medida_nombre
    medida.try(:nombre)
  end 

  def medida_nombre=(nombre)
  	self.medida = medida.find_or_create_by_nombre(nombre) if nombre.present?
  end

  def componente_nombre
    componente.try(:nombre)
  end 

  def componente_nombre=(nombre)
  	self.componente = componente.find_or_create_by_nombre(nombre) if nombre.present?
  end

   def modelo_nombre
     modelo.try(:nombre)
  end 

   def user_name
     user.try(:name)
  end 

  def modelo_nombre=(nombre)
    self.modelo = modelo.find_or_create_by_nombre(nombre) if nombre.present?
  end


  # It returns the articles whose titles contain one or more words that form the query
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("nombre like :name1 OR descripcion LIKE :name2 ", 
          {:name1 => "%#{query}%", :name2 => "%#{query}%"}) 
    
  end

  # It returns the articles whose titles contain one or more words that form the query
  def self.filter(query)
    # where(:title, query) -> This would return an exact match of the query
    joins(:componente).where("codigo like ?", "%#{query}%") 
  end

  def name_with_desc
    "#{nombre}: #{descripcion}"
  end
end

