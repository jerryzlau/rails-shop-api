class CreateProductCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :product_categories do |t|
      t.integer :category_id, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
