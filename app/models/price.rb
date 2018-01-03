class Price < ApplicationRecord
  validates :price, presence: true
  validates :currency, presence: true, uniqueness: { scope: :price }

  belongs_to :product
  belongs_to :distributor
end
