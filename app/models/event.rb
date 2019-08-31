# frozen_string_literal: true

# A single event
class Event < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :club, optional: true
  belongs_to :series, optional: true
  has_many :registrations, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :start_on, presence: true
  validates :end_on, presence: true
  validates :registration_start, presence: true
  validates :registration_end, presence: true
  validates :max_registrations, numericality: { only_integer: true }

  # Enforce that the model belongs to a Club OR a Series
  validates :club, presence: true, unless: :series
  validates :series, presence: true, unless: :club

  validates_with StartOnValidator
  validates_with RegistrationDateValidator

  # JSON for API
  def to_json(options = {})
    payload = super(%i[club_type name description url contact_email])
    payload['region'] = JSON.parse(region.to_hateoas('part_of'))
    payload['events'] = events.map { |e| JSON.parse(e.to_hateoas('sponsor_of')) }
    payload['series'] = series.map { |e| JSON.parse(e.to_hateoas('sponsor_of')) }
    payload
  end
end
