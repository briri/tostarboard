class CreateVessels < ActiveRecord::Migration[5.2]
  def change
    create_table :vessels do |t|
      t.string :name
      t.string :make
      t.string :model
      t.float :length
      t.float :beam
      t.float :draft
      t.string :sail_number
      t.timestamps
    end
  end

  add_reference :users, :vessel
  add_reference :race_results, :vessel
end
