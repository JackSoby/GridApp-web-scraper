class Distributor < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :website, allow_nil: true
  validates :address, allow_nil: true
  validates :email, allow_nil: true
  validates :phone, allow_nil: true


  has_many :distributor_locs
  has_many :locations, through: :distributor_locs
  has_many :prices
  has_many :products, through: :prices
end
