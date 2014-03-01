class AddLockedAtToCart < ActiveRecord::Migration
  def change
    add_column :carts, :locked_at, :datetime
  end
end
