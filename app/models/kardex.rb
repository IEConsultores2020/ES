class Kardex < ActiveRecord::Base
  belongs_to :inventario
  belongs_to :articulo
end
