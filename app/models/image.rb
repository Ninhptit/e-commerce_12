class Image < ApplicationRecord
  belongs_to :type_product

  mount_uploader :image_url, ImageUploader
end
