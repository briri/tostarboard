class AddClubToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :club, index: true, null: true
  end
end
