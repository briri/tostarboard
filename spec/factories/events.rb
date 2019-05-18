# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    club
    name         { Faker::Lorem.unique.word }
    description  { Faker::Lorem.paragraph }
    instructions { Faker::Lorem.paragraph }
    start_on     { Faker::Time.forward(10, :morning) }
    end_on       { Faker::Time.forward(10, :evening) }

    factory :events_with_registrations do
      transient do
        registration_count { 2 }
      end

      after(:create) do |event, evaluator|
        create_list(:registration_with_stubbed_user, evaluator.registration_count, event: event)
      end
    end
  end
end
