class AddAcceptTermsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accept_terms, :boolean
  end
end
