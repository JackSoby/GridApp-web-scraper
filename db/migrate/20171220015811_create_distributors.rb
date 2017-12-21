class CreateDistributors < ActiveRecord::Migration[5.1]
  def change
    create_table :distributors do |t|
      t.string :name, null: false
      # add contact information allow null for all and below
      # phone 1, 2, 3
      # address
      # distributor
    end

    add_index :distributors, :name, unique: true
  end
end
