class AddUserToVessels < ActiveRecord::Migration[5.2]
  def change
  	add_reference :vessels, :user
  end
end
