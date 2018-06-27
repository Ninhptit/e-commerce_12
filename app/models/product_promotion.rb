class ProductPromotion < ApplicationRecord
  belongs_to :product
  belongs_to :promotion
  validates_uniqueness_of :product_id, :promotion_id
end
