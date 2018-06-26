class Order < ApplicationRecord
  attr_accessor :order_details_attributes
  belongs_to :user
  has_many :order_details, inverse_of: :order
  has_many :products, through: :order_details
  accepts_nested_attributes_for :order_details

end
