class AddSeriesIdToClub < ActiveRecord::Migration[5.2]
  def change
    add_reference :clubs, :series, index: true
  end
end
