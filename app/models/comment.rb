class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :description, presence: true,
    length: {minimum: Settings.comment.description.minimum,
             maximum: Settings.comment.description.maximum}

  include ActionView::Helpers::DateHelper
  def show_time_create
    time_ago_in_words(created_at) unless created_at.blank?
  end
end
