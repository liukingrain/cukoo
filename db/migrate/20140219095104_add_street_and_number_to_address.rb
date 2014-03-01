class AddStreetAndNumberToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :street_and_number, :string
  end
end
