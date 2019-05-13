class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.text :description
      t.references :region, index: true
      t.timestamps
    end
  end
end
