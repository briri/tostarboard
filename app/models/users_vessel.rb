# frozen_string_literal: true

# Relationship between a person and a vessel
class UsersVessel < ApplicationRecord

  # Associations
  belongs_to :user
  belongs_to :vessel
  
  # Validations
  validates :user, :vessel, :role, presence: true

  enum role: %i[owner sailor]
end
