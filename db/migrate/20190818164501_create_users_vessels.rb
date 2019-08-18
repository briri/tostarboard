class CreateUsersVessels < ActiveRecord::Migration[5.2]
  def change
    create_table :users_vessels do |t|
    	t.references :user,  null: false, index: true
    	t.references :vessel,  null: false, index: true
    	t.string :role, null: false, default: 1
    end
  end
end
