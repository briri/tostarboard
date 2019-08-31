# frozen_string_literal: true

# Represents an entity that organizes events
class Club < ApplicationRecord
	# Associations
  belongs_to :region
  has_many   :admins, class_name: 'User', foreign_key: 'id'
  has_many   :events, dependent: :destroy
  has_many   :series, dependent: :destroy

  # Validations
  validates  :category, presence: true
  validates  :name, presence: true, uniqueness: { case_sensitive: false }

  enum category: %i[yacht_club sailing_association]

  # JSON for API
  def to_json(options = {})
    payload = super(%i[category name description url contact_email])
    payload['region'] = JSON.parse(region.to_hateoas('part_of'))
    payload['events'] = events.map { |e| JSON.parse(e.to_hateoas('sponsor_of')) }
    payload['series'] = series.map { |e| JSON.parse(e.to_hateoas('sponsor_of')) }
    payload
  end
end
