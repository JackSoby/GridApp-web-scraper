class Distributor < ApplicationRecord


  has_many :distributor_locs
  has_many :locations, through: :distributor_locs
  has_many :prices
  has_many :products, through: :prices
end
