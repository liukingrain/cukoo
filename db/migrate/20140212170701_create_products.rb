class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :size
      t.integer :amount
      t.string :fabric
      t.string :manufacturer
      t.string :color
      t.string :picture

      t.timestamps
    end
  end
end
