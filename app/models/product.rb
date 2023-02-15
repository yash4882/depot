class Product < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}

  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)\z}i, message: 'must be a URL for GIF, JPG or PNG image.'
}
  # validates :title, :description, :image_url, presence: true 
end
