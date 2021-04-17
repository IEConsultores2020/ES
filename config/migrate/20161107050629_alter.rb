class Alter < ActiveRecord::Migration
  def change
  	change_table :conteos do |t|
      t.change :cantidad, :float, :precision => 2
    end
  	 
  end
end
