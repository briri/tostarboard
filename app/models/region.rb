# frozen_string_literal: true

# A designation to help place clubs and users within a temporal space
class Region < ApplicationRecord
  has_many :sub_regions, class_name: 'Region', foreign_key: 'parent_id'

  belongs_to :parent, class_name: 'Region', optional: true

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_json(options = {})
  	payload = super(%i[name description])
  	payload['parent'] = JSON.parse(parent.to_hateoas('child_of')) if parent.present?
  	payload['sub_regions'] = sub_regions.map { |r| JSON.parse(r.to_hateoas('parent_to')) }
  	payload
  end
end
