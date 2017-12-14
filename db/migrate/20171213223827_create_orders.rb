class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status, null: false, default: 'waiting for delivery'
      t.integer :customer_id, null: false

      t.timestamps
    end
  end
end
