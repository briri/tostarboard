# frozen_string_literal: true

# A single result for a race event
class RaceResult < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :vessel
  belongs_to :race #, class_name: :Race, foreign_key: 'event_id'

  validates :vessel, presence: true
  validates :race, presence: true
  validates :start_on, presence: true
  validates :end_on, presence: true

  validates_with StartOnValidator
end