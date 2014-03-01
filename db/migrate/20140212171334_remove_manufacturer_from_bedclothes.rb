class RemoveManufacturerFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :manufacturer, :string
  end
end
