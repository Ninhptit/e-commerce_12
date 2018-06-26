class TypeProduct < ApplicationRecord
  belongs_to :product
  has_many :images
  has_many :order_details
  has_many :orders, through: :order_details 

  scope :search, (lambda do |keyword|
    sql_statement = "products.name LIKE ? 
      or type_products.size LIKE ? 
      or type_products.color LIKE ? 
      or type_products.quantity LIKE ? 
      or products.id LIKE ? "
    keyword = keyword.to_s.strip
    unless keyword.blank?
      joins(:product).where sql_statement, 
        "%#{sanitize_sql_like keyword}%", 
        "%#{sanitize_sql_like keyword}%", "%#{sanitize_sql_like keyword}%", 
        "%#{sanitize_sql_like keyword}%", "%#{sanitize_sql_like keyword}%" 
    end
  end)

  def show_img
    path = ActionController::Base.helpers.image_path(Settings.picture.default)
    images.first.image_url || path
  end

  def show_all_img
    images.to_a.map(&:image_url)
  end

  def check_quantity number
    quantity >= number
  end
end
