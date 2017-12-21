class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :continent
      t.string :state
      t.string :country, null: false
      t.string :city
    end

    add_index :locations, [:continent, :country, :city], unique: true
  end
end
