class Medida < ActiveRecord::Base
	has_many :articulos
	belongs_to :user

  def user_name
     user.try(:name)
  end 

 def code_with_name
    "#{codigo}: #{nombre}"
  end
end
