class ShippingAddress < Address
  validates :city, :postal_code, :first_name, :last_name,
            :street_and_number, presence: true

end