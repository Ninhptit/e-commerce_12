class Promotion < ApplicationRecord
  has_many :product_promotions
  has_many :products, through: :product_promotions
  validates :start_date, :end_date, :descriptions, presence: true
  
  scope :check_sale, ->{where("start_date <= ? and end_date >= ?", DateTime.now, DateTime.now)}
end
