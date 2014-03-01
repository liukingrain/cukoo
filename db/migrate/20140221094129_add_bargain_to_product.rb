class AddBargainToProduct < ActiveRecord::Migration
  def change
    add_column :products, :bargain, :boolean
  end
end
