class CreateDistributors < ActiveRecord::Migration[5.1]
  def change
    create_table :distributors do |t|
      t.string :name, null: false
    end

    add_index :distributors, :name, unique: true
  end
end
