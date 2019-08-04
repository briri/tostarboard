class AddClientTokenClientSecretToUsers < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :api_token

  	add_column :users, :client_token, :string, index: true
  	add_column :users, :client_secret, :string
  end
end
