class CreateSaledetails < ActiveRecord::Migration
  def change
    create_table :saledetails do |t|

      t.timestamps null: false
    end
  end
end
