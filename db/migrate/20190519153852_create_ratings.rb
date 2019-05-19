class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.string :boat_type
      t.integer :rating
      t.float :sail_plan_i
      t.float :sail_plan_j
      t.float :sail_plan_p
      t.float :sail_plan_e
      t.float :sail_plan_py
      t.float :sail_plan_ey
      t.float :displacement
      t.float :length_water_line
      t.float :draft
    end
  end
end
