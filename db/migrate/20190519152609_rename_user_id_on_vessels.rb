class RenameUserIdOnVessels < ActiveRecord::Migration[5.2]
  def change
  	rename_column :vessels, :user_id, :owner_id
  end
end
