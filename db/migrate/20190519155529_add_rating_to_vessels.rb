class AddRatingToVessels < ActiveRecord::Migration[5.2]
  def change
  	add_reference :vessels, :rating
  end
end
