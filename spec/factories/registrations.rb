# frozen_string_literal: true

FactoryBot.define do
  factory :registration do
    user
    series
    event
    paid         { true }
    paid_on      { Faker::Time.backward(2, :evening) }
    invoice_id   { Faker::Lorem.word }
    notes        { Faker::Lorem.paragraph }

    factory :registration_with_stubbed_user do
      user       { create(:user) }
    end
  end
end
