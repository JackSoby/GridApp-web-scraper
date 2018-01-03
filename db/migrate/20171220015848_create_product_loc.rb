class CreateProductLoc < ActiveRecord::Migration[5.1]
  def change
    create_table :product_locs do |t|
      t.belongs_to :product
      t.belongs_to :location
    end

    add_index :product_locs, [:product_id, :location_id], unique: true
  end
end
