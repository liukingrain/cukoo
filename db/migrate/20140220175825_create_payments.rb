class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :amount
      t.string :method
      t.integer :order_id

      t.timestamps
    end
  end
end
