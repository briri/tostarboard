class AddRegistrationToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :registration_start, :datetime, index: true
    add_column :events, :registration_end, :datetime, index: true
    add_column :events, :max_registrations, :integer
  end
end
