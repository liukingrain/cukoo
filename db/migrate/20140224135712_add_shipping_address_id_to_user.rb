class AddShippingAddressIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :shipping_address_id, :integer
  end
end
