class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :type_products, through: :order_details

  accepts_nested_attributes_for :order_details, allow_destroy: true

  scope :unpaid, ->{where(status: false)}
  scope :paid, ->{where(status: true)}

  def get_quantity_product_in_cart
    sum_quantity = 0
    self.order_details.each do |order_detail|
      sum_quantity += order_detail.quantity
    end
    sum_quantity
  end
end
