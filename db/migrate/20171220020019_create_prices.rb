class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.float :price, null: false
      t.string :currency, null: false
      t.float :price_usd
      t.belongs_to :product
      t.belongs_to :distributor
    end

    add_index :prices, [:product_id, :distributor_id], unique: true
  end
end
