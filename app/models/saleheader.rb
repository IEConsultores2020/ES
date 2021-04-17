require 'rubygems'
require 'roo'
class Saleheader < ActiveRecord::Base
  belongs_to :user
  has_many   :saledetails, dependent: :destroy
  accepts_nested_attributes_for :saledetails, 
             allow_destroy: true 
  validates_presence_of :typeID, :num_id, :citizenship, :allname, :email, 
                        :expeditionDate

  def saleheader_typeID
     saleheader.try(:typeID)
  end 
  
  def saleheader_descripcion
     saleheader.try(:citizenship)
  end 

  def saleheader_citizenship=(citizenship)
    self.saleheader = Saleheader.find_by_citizenship(citizenship)  if citizenship.present?
  end    

  def saleheader_descripcion=(descripcion)
    self.saleheader = Saleheader.find_by_descripcion(descripcion)  if descripcion.present?
  end  
end
