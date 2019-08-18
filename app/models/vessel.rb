# frozen_string_literal: true

# A sailing vessel
class Vessel < ApplicationRecord
  # Associations
  belongs_to :rating, optional: true
  has_many :race_results
  has_many :users_vessels
  has_many :users, through: :users_vessels

  # Validations
  validates :name, :sail_number, presence: true

  def owners
  	users.joins(:users_vessels).where(users_vessels: { role: 0 })
  end

  def crew
  	users.joins(:users_vessels).where.not(users_vessels: { role: 0 })
  end

  # JSON for API
  def to_json(options = {})
    payload = JSON.parse(super(only: %i[id name make model length beam draft sail_number]))
    payload[:rating] = JSON.parse(rating.to_hateoas('rated_by')) if rating.present?
    payload[:owners] = owners.map { |o| JSON.parse(o.to_hateoas('belongs_to')) }
    payload[:crew] = crew.map { |c| JSON.parse(c.to_hateoas('sailed_by')) }
    payload[:race_results] = race_results.map { |r| JSON.parse(r.to_hateoas('participated_in')) }
    payload[:links] = to_hateoas if id.present?
    payload.to_json
  end
end
