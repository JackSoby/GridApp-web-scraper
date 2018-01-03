# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180103001836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "distributor_locs", force: :cascade do |t|
    t.bigint "distributor_id"
    t.bigint "location_id"
    t.index ["distributor_id", "location_id"], name: "index_distributor_locs_on_distributor_id_and_location_id", unique: true
    t.index ["distributor_id"], name: "index_distributor_locs_on_distributor_id"
    t.index ["location_id"], name: "index_distributor_locs_on_location_id"
  end

  create_table "distributors", force: :cascade do |t|
    t.string "name", null: false
    t.string "website"
    t.string "address"
    t.string "email"
    t.string "phone"
    t.index ["name"], name: "index_distributors_on_name", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "continent"
    t.string "state"
    t.string "country", null: false
    t.string "city"
    t.index ["continent", "country", "city"], name: "index_locations_on_continent_and_country_and_city", unique: true
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name", null: false
    t.string "website"
    t.string "address"
    t.string "email"
    t.string "phone"
    t.index ["name"], name: "index_manufacturers_on_name", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.float "price", null: false
    t.string "currency", null: false
    t.float "price_usd"
    t.bigint "product_id"
    t.bigint "distributor_id"
    t.index ["distributor_id"], name: "index_prices_on_distributor_id"
    t.index ["product_id", "distributor_id"], name: "index_prices_on_product_id_and_distributor_id", unique: true
    t.index ["product_id"], name: "index_prices_on_product_id"
  end

  create_table "product_locs", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "location_id"
    t.index ["location_id"], name: "index_product_locs_on_location_id"
    t.index ["product_id", "location_id"], name: "index_product_locs_on_product_id_and_location_id", unique: true
    t.index ["product_id"], name: "index_product_locs_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "model_num_m"
    t.string "product_id", null: false
    t.text "description"
    t.string "image"
    t.float "batt_size_ah_m"
    t.float "batt_size_v_m"
    t.float "batt_size_wh"
    t.string "batt_capacity"
    t.string "batt_type"
    t.boolean "batt_replacable"
    t.boolean "port_5v"
    t.boolean "port_12v"
    t.string "solar"
    t.string "panel_type"
    t.float "panel_size_m"
    t.integer "lumens_m"
    t.integer "num_lights"
    t.string "lamp_type"
    t.float "total_light_service"
    t.float "illumination_area"
    t.string "light_distribution"
    t.boolean "mobile_charge"
    t.string "warranty"
    t.date "expiration"
    t.boolean "pay_go"
    t.bigint "manufacturer_id"
    t.index ["manufacturer_id"], name: "index_products_on_manufacturer_id"
  end

end
