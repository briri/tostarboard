class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :type, index: true
      t.string :name, index: true
      t.text :description
      t.string :url
      t.string :contact_email
      t.references :region, index: true
      t.timestamps
    end
  end
end
