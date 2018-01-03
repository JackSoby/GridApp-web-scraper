class DistributorLoc < ApplicationRecord
  validates :distributor_id, uniqueness: { scope: :location_id }
  
  belongs_to :distributor
  belongs_to :location
end
