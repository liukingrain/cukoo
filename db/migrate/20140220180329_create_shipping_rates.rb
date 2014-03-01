class CreateShippingRates < ActiveRecord::Migration
  def change
    create_table :shipping_rates do |t|
      t.string :shipping_method
      t.float :rate
      t.float :free_of_charge_treshold

      t.timestamps
    end
  end
end
