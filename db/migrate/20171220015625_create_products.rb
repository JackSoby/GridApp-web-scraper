class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :model_num_m # S20
      t.string :product_id, null: false # product id from lighting global url
      t.text :description
      t.string :image

      t.float :batt_size_ah_m # 0.4
      t.float :batt_size_v_m # 3.2 -- PDF: Battery nominal voltage
      t.float :batt_size_wh # batt_size_v_m * batt_size_ah_m
      t.string :batt_capacity # reference battery capacity in pdf for later use
      t.string :batt_type #lithium iron phosphate
      t.boolean :batt_replacable # false
      t.boolean :port_5v # allow null
      t.boolean :port_12v # allow null

      t.string :solar #inbuilt
      t.string :panel_type # monocrystalline silicon
      t.float :panel_size_m # 0.4

      t.integer :lumens_m # 29
      t.integer :num_lights # 1
      t.string :lamp_type # LED
      t.float :total_light_service # (lumen-hours/solar-day) 130 -- total_light_service
      t.float :illumination_area # total area of illumination m^2
      t.string :light_distribution # wide

      t.boolean :mobile_charge # false
      t.string :warranty # 24 months
      t.date :expiration # june 30, 2018
      t.boolean :pay_go # may or may not be available on the page
      t.belongs_to :manufacturer
    end
  end
end
