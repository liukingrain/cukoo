class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :postal_code
      t.string :first_name
      t.string :last_name
      t.string :type
      t.string :company_name
      t.string :company_nip
      t.string :phone_number

      t.timestamps
    end
  end
end
