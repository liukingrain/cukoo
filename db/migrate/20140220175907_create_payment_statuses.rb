class CreatePaymentStatuses < ActiveRecord::Migration
  def change
    create_table :payment_statuses do |t|
      t.string :status
      t.integer :payment_id

      t.timestamps
    end
  end
end
