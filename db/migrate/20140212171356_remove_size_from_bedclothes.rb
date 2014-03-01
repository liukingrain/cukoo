class RemoveSizeFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :size, :string
  end
end
