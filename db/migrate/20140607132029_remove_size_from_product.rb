class RemoveSizeFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :size, :string
  end
end
