class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :type_products, through: :order_details

  accepts_nested_attributes_for :order_details, allow_destroy: true

  scope :unpaid, ->{where(status: false)}
  scope :paid, ->{where(status: true)}
end
