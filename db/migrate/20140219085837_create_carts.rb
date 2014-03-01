class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.string :email
      t.string :step
      t.string :shipping_address_id
      t.string :shipping_method
      t.string :payment_method
      t.integer :billing_address_id
      t.boolean :invoice
      t.boolean :custom_billing_address
      t.text :comment

      t.timestamps
    end
  end
end
