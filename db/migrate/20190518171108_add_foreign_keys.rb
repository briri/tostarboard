class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
  	add_foreign_key :registrations, :users

  	add_foreign_key :events, :clubs
  	add_foreign_key :events, :series

  	add_foreign_key :series, :clubs

  	add_foreign_key :clubs, :regions
  end
end
