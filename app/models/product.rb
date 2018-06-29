class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :ratings
  has_many :comments
  has_many :type_products, dependent: :destroy
  has_many :product_promotions, dependent: :destroy
  has_many :promotions, through: :product_promotions
  validates :name, :price, :descriptions, presence: true
  accepts_nested_attributes_for :type_products, allow_destroy: true
  scope :new_products, (lambda do
                          where("created_at >= ?",
                            Settings.rules_new_product.days.ago)
                        .order("created_at desc")
                        end)

  scope :search, (lambda do |keyword|
    keyword = keyword.to_s.strip
    unless keyword.blank?
      joins(:category).where "categories.name LIKE ? or products.name LIKE ?
      or price LIKE ? ", "%#{sanitize_sql_like keyword}%",
        "%#{sanitize_sql_like keyword}%", "%#{sanitize_sql_like keyword}%"
    end
  end)

  scope :order_by_time,
    ->{order(:name, :price, :descriptions, created_at: :asc)}

  def new_product?
    created_at >= Settings.rules_new_product.days.ago
  end

  def get_sale_in_day
    promotion = promotions.check_sale.first
    promotion.product_promotions.first.percent if promotion.present?
  end

  def get_price_sale_in_day
    sale = get_sale_in_day
    price * (100 - sale) * 0.01
  end
end
