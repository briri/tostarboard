class AddRegistrationToSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :series, :registration_start, :datetime, index: true
    add_column :series, :registration_end, :datetime, index: true
    add_column :series, :max_registrations, :integer
  end
end
