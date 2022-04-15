class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items,dependent: :destroy
  has_many :addresses
  has_many :orders
  attachment:image
  def active_for_authentication?
    super && (self.is_active == false)
  end
end
