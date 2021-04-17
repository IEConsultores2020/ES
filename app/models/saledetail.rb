require 'rubygems'
require 'roo'

class Saledetail < ActiveRecord::Base
  belongs_to :user
  belongs_to :saleheader 
  belongs_to :articulo
  validates_presence_of :articulo_id, :line, :value, :quantity, :total
  
end
