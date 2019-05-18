class CreateSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :series do |t|
      t.string :name
      t.text :description
      t.text :instructions
      t.float :fee
      t.references :club, index: true
      t.timestamps
    end
  end
end
