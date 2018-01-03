class Product < ApplicationRecord
  validates :name, presence: true
  validates :product_id, presence: true, uniqueness: { scope: :name }

  has_many :prices
  has_many :distributors, through: :prices
  has_many :product_locs
  has_many :locations, through: :product_locs
  belongs_to :manufacturer
end
