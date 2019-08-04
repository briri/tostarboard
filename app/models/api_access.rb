# frozen_string_literal: true

# Represents a user's api access tokens
class ApiAccess < ApplicationRecord
	self.table_name = 'api_access'
	
  belongs_to :user
  
  validates  :user, presence: true
  validates  :access_token, presence: true, uniqueness: true
  validates  :expiry_date, not_in_past: true
end
