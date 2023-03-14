class Product < ApplicationRecord
  has_many :comments

  validates :commenter, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  
  # paginates_per 1
  has_many :line_items
  # before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}

  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)\z}i, message: 'must be a URL for GIF, JPG or PNG image.'
}
  # validates :title, :description, :image_url, presence: true 

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
