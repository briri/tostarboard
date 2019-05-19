# frozen_string_literal: true

# Represents an entity that organizes events
class Club < ApplicationRecord
  belongs_to :region
  has_many   :admins, class_name: 'User', foreign_key: 'id'
  has_many   :events, dependent: :destroy
  has_many   :series, dependent: :destroy

  validates  :club_type, presence: true
  validates  :name, presence: true, uniqueness: { case_sensitive: false }

  enum club_type: %i[yacht_club sailing_association]
end
