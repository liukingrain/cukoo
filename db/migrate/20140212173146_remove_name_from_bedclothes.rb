class RemoveNameFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :name, :string
  end
end
