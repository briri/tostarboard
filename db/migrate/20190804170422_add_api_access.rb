class AddApiAccess < ActiveRecord::Migration[5.2]
  def change
  	create_table :api_access do |t|
      t.references :user, index: true
      t.string :access_token, index: true
      t.datetime :expiry_date, index: true
      t.timestamps
    end
  end
end
