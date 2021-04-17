class CreateSaleheaders < ActiveRecord::Migration
  def change
    create_table :saleheaders do |t|

      t.timestamps null: false
    end
  end
end
