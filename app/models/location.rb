class Location < ApplicationRecord
  validates :country, presence: true, uniqueness: { scope: [:continent, :city] }


  has_many :distributor_locs
  has_many :distributors, through: :distributor_locs
  has_many :product_locs
  has_many :products, through: :product_locs
end
