class RemoveResultsFromUser < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :race_results, :user
  end
end
