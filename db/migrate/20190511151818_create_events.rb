class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :instructions
      t.float :fee
      t.datetime :start_on, index: true
      t.datetime :end_on, index: true
      t.references :club, index: true
      t.timestamps
    end
  end
end
