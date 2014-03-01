class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook]
         
         
  has_one :cart, -> { where(locked_at: nil) }
  has_many :orders
  has_many :shipping_addresses
  has_many :billing_addresses
  belongs_to :shipping_address
  belongs_to :billing_address
  
  accepts_nested_attributes_for :shipping_address
  
  
  def shipping_address
    super || build_shipping_address(first_name: first_name, last_name: last_name)
  end
  
  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.skip_confirmation!
    end
  end
  
  
end
