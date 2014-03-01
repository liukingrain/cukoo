class AddColourToBedclothes < ActiveRecord::Migration
  def change
    add_column :bedclothes, :colour, :string
  end
end
