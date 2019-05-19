# frozen_string_literal: true

# A type of event
class Rating < ApplicationRecord
  has_many :vessels

  validates :boat_type, presence: true, uniqueness: { case_sensitive: false }
  validates :rating, numericality: true
  
  # See the following for an explanation of sail plan measurements: 
  #    http://secondwindsails.com/measurement.php
  validates :sail_plan_i, numericality: true 	# Height of Foresail Triangle
  validates :sail_plan_j, numericality: true 	# Length of Foresail Triangle
  validates :sail_plan_p, numericality: true 	# Height of Mainsail 
  validates :sail_plan_e, numericality: true 	# Length of Mainsail Foot
  validates :sail_plan_py, numericality: true 	# Height of Mizzen
  validates :sail_plan_ey, numericality: true	# Length of Mizzen Foot

  validates :displacement, numericality: true, allow_nil: true
  validates :length_water_line, numericality: true, allow_nil: true
  validates :draft, numericality: true, allow_nil: true
end
