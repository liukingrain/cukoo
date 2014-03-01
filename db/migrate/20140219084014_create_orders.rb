class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :cart_id
      t.string :email
      t.string :status
      t.integer :shipping_address_id
      t.string :shipping_method
      t.float :shipping_price
      t.string :payment_method
      t.string :auth_token
      t.integer :billing_address_id
      t.text :comment
      t.boolean :invoice
      t.boolean :custom_billing_address

      t.timestamps
    end
  end
end
