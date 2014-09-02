class CreateProductVariants < ActiveRecord::Migration
  def change
    create_table :product_variants do |t|
      t.float :price
      t.integer :product_id
      t.string :size

      t.timestamps
    end
  end
end
