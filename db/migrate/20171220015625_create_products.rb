class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.string :model_num_m # S20
      t.integer :panel_size_m # 0.4
      t.integer :batt_size_ah_m # 0.4
      t.integer :batt_size_v_m # 3.2 -- PDF: Battery nominal voltage
      t.string :batt_type_m # lithium iron phosphate X
      t.integer :lumens_m # 29
      t.boolean :mobile_charge_lg # false
      t.integer :num_lights_lg # 1
      t.string :solar_lg #inbuilt
      t.string :batt_type_lg #lithium iron phosphate X
      t.string :warranty #24 months
      t.date :expiration_lg # june 30, 2018
      t.string :lamp_type # LED
      t.float :batt_time # (lumen-hours/solar-day) 130 -- total_light_service
      t.string :light_distribution # wide

      t.boolean :port_5v
      t.boolean :port_12v
      t.boolean :pay_go
      t.boolean :batt_replacable # false

      t.string :manufacturer # d.light design
      t.string :manufacturer_site # www.dlight.com
      t.string :panel_type # monocrystalline silicon
    end
  end
end
