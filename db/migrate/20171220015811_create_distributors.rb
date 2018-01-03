class CreateDistributors < ActiveRecord::Migration[5.1]
  def change
    create_table :distributors do |t|
      t.string :name, null: false
      t.string :website
      t.string :address
      t.string :email
      t.string :phone
    end

    add_index :distributors, :name, unique: true
  end
end
