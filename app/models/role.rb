# frozen_string_literal: true

# Determines a user's permissions
class Role < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  enum name: %i[crew skipper club_admin super_admin]
end
