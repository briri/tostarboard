# frozen_string_literal: true

# A grouping for events
class Series < ApplicationRecord
  belongs_to :club
  has_many :events, dependent: :destroy
  has_many :registrations, dependent: :destroy

  validates :club, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :registration_start, presence: true
  validates :registration_end, presence: true
  validates :max_registrations, numericality: { only_integer: true }

  validates_with RegistrationDateValidator

  def start_on
    events.order(start_on: :asc).first&.start_on
  end

  def end_on
    events.order(end_on: :desc).first&.end_on
  end
end
