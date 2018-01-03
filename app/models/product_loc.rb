class ProductLoc < ApplicationRecord
  validates :product_id, uniqueness: { scope: :location_id }

  belongs_to :product
  belongs_to :location
end
