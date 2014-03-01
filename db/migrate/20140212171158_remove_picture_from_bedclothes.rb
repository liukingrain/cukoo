class RemovePictureFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :picture, :string
  end
end
