class CreateRaceResults < ActiveRecord::Migration[5.2]
  def change
    create_table :race_results do |t|
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true
      t.string :course
      t.datetime :start_on
      t.datetime :end_on
      t.boolean :dns, default: false
      t.boolean :dnf, default: false
      t.boolean :disqualified, default: false
      t.float :penalty
      t.timestamps
    end

    add_foreign_key :race_results, :users
    add_foreign_key :race_results, :events
  end
end
