class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :type_product
  validates :quantity, numericality: {greater_than: 0}

  scope :find_type_product, ->(type_product){where(type_product_id: type_product)}
end
