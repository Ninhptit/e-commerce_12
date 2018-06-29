class Promotion < ApplicationRecord
  has_many :product_promotions, dependent: :destroy
  has_many :products, through: :product_promotions

  validates :name, :description, :start_date, :end_date, presence: true
  accepts_nested_attributes_for :product_promotions, allow_destroy: true

  scope :check_sale, ->{where("start_date <= ? and end_date >= ?", Time.now, Time.now)}

  scope :search, (lambda do |keyword|
    keyword = keyword.to_s.strip
    where "name LIKE ?", "%#{sanitize_sql_like keyword}%" unless keyword.blank?
  end)
end
