class AddBillingAddressIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :billing_address_id, :integer
  end
end
