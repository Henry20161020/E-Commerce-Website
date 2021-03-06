class Product < ApplicationRecord
  has_many :orders
  has_many :comments
  validates :name, presence: true
  validates :price, numericality: { only_decimal: true }

  def self.search(search_term)
    if ENV['RAILS_ENV']=="production"
      Product.where("name ilike ?", "%#{search_term}%")
    else
      Product.where("name LIKE ?", "%#{search_term}%")
    end
  end

  def highest_rating_comment
    comments.rating_desc.first
  end

  def lowest_rating_comment
    comments.rating_asc.first
  end

  def average_rating
    comments.average(:rating).to_f
  end
end
