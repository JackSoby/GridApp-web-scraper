class CreateDistributorLocs < ActiveRecord::Migration[5.1]
  def change
    create_table :distributor_locs do |t|
      t.belongs_to :distributor
      t.belongs_to :location
    end

    add_index :distributor_locs, [:distributor_id, :location_id], unique: true
  end
end
