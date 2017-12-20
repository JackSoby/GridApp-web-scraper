class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.string :model_num_m
      t.integer :panel_size_m
      t.integer :batt_size_ah_m
      t.integer :batt_size_v_m
      t.string :batt_type_m
      t.integer :lumens_m
      t.boolean :mobile_charge_lg
      t.integer :lights_lg
      t.string :solar_lg
      t.string :batt_type_lg
      t.string :warranty
      t.date :expiration_lg
      t.string :type
      t.float :batt_time
      t.string :light_distribution
    end
  end
end
