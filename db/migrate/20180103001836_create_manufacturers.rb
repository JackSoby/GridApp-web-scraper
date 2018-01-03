class CreateManufacturers < ActiveRecord::Migration[5.1]
  def change
    create_table :manufacturers do |t|
      t.string :name, null: false
      t.string :website
      t.string :address
      t.string :email
      t.string :phone
    end

    add_index :manufacturers, :name, unique: true
  end
end
