# frozen_string_literal: true

FactoryBot.define do
  factory :api_access do
    user
    access_token  { SecureRandom.uuid }
    expiry_date   { Date.new(Date.today + 1.days) }
  end
end
