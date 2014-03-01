class AddPictureToBedclothes < ActiveRecord::Migration
  def change
    add_column :bedclothes, :picture, :string
  end
end
