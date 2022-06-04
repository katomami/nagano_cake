class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre
  attachment :image
  def with_tax_price
    (price*1.1).floor
  end
end
