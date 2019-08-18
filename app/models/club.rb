# frozen_string_literal: true

# Represents an entity that organizes events
class Club < ApplicationRecord
	# Associations
  belongs_to :region
  has_many   :admins, class_name: 'User', foreign_key: 'id'
  has_many   :events, dependent: :destroy
  has_many   :series, dependent: :destroy

  # Validations
  validates  :club_type, presence: true
  validates  :name, presence: true, uniqueness: { case_sensitive: false }

  enum club_type: %i[yacht_club sailing_association]

  # JSON for API
  def to_json(options = {})
    payload = JSON.parse(super(only: %i[id club_type name description]))
    payload[:region] = JSON.parse(region.to_json)
    payload[:events] = events.map { |e| JSON.parse(e.to_hateoas) }
    payload[:series] = series.map { |e| JSON.parse(e.to_hateoas) }
    payload[:links] = to_hateoas if id.present?
    payload.to_json
  end
end
