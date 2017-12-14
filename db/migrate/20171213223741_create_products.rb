class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.float :price, null: false 
      t.float :weight, null: false
      t.integer :category_id, null: false 
      t.integer :order_id 

      t.timestamps
    end
  end
end
