class TypeProduct < ApplicationRecord
  belongs_to :product
  has_many :images

  has_many :order_details
  has_many :orders, through: :order_details

  def show_img
    path = ActionController::Base.helpers.image_path(Settings.picture.default)
    images.first.image_url || path
  end

  def show_all_img
    images.to_a.map(&:image_url)
  end
end
