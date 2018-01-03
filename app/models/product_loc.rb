class ProductLoc < ApplicationRecord
  valudates :product_id, uniqueness: { scope: :location_id }
  
  belongs_to :product
  belongs_to :location
end
