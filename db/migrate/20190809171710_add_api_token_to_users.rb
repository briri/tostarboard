class AddApiTokenToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :secret, :string

  	add_index :users, [:id, :secret]
  end
end
