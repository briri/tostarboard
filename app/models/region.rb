# frozen_string_literal: true

# A designation to help place clubs and users within a temporal space
class Region < ApplicationRecord
  has_many :sub_regions, class_name: 'Region', foreign_key: 'parent_id'

  belongs_to :parent, class_name: 'Region', optional: true

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
