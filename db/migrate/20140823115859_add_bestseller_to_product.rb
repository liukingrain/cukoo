class AddBestsellerToProduct < ActiveRecord::Migration
  def change
    add_column :products, :bestseller, :boolean
  end
end
