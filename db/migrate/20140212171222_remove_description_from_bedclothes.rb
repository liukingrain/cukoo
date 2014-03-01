class RemoveDescriptionFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :description, :text
  end
end
