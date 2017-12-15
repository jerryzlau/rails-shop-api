class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.decimal :weight, null: false, precision: 10, scale: 2
      t.integer :inventory, null: false, inclusion: 0..100000

      t.timestamps
    end

    add_index :products, :name, unique: true
  end
end
