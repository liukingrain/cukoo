class CreateProductSizes < ActiveRecord::Migration
  def change
    create_table :product_sizes do |t|
      t.string :kind
      t.integer :product_id

      t.timestamps
    end
  end
end
