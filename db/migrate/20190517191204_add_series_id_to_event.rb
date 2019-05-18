class AddSeriesIdToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :series, index: true
  end
end
