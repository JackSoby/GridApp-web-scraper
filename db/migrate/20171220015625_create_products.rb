class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :product_id, null: false # product id from lighting global url
      t.text :description
      t.string :model_num_m # S20
      t.float :panel_size_m # 0.4
      t.float :batt_size_ah_m # 0.4
      t.float :batt_size_v_m # 3.2 -- PDF: Battery nominal voltage
      t.float :batt_size_wh # batt_size_v_m * batt_size_ah_m
      t.string :batt_capacity # reference battery capacity in pdf for later use
      t.integer :lumens_m # 29
      t.boolean :mobile_charge # false
      t.integer :num_lights # 1
      t.string :solar #inbuilt
      t.string :batt_type #lithium iron phosphate
      t.string :warranty #24 months
      t.date :expiration # june 30, 2018
      t.string :lamp_type # LED
      t.float :total_light_service # (lumen-hours/solar-day) 130 -- total_light_service
      t.string :light_distribution # wide

      t.boolean :port_5v # allow null
      t.boolean :port_12v # allow null
      t.boolean :pay_go # look for pay as go in page
      t.boolean :batt_replacable # false

      t.string :manufacturer # d.light design
      t.string :manufacturer_site # www.dlight.com
      t.string :panel_type # monocrystalline silicon

      t.string :image

      # total area of illumination

      # grab a picture from the lighting global website. try to house those photos in our own database.

      # GET RID OF ALL THE LG
      # m - mangoo
      # man - manual
    end
  end
end
