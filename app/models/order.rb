class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: {not_payment: 0, payment_confirmation: 1, under_construction:2, ready_to_ship:3, shipped:4}
end
