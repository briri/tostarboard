# frozen_string_literal: true

# frozen_dtring_literal: true

# A sailing vessel
class Vessel < ApplicationRecord
  belongs_to :owner, class_name: :User, foreign_key: 'owner_id'
  belongs_to :rating, optional: true
  has_many :users
  has_many :race_results

  validates :owner, presence: true
end
