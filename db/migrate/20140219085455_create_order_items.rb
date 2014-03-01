class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.string :product_type
      t.integer :order_id
      t.integer :quantity
      t.string :product_name
      t.float :product_price

      t.timestamps
    end
  end
end
