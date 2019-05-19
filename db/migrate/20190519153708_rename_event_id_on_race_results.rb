class RenameEventIdOnRaceResults < ActiveRecord::Migration[5.2]
  def change
  	rename_column :race_results, :event_id, :race_id
  end
end
