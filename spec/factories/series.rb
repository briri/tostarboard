# frozen_string_literal: true

FactoryBot.define do
  factory :series do
    club
    name               { Faker::Lorem.unique.word }
    description        { Faker::Lorem.paragraph }
    instructions       { Faker::Lorem.paragraph }
    fee                { Faker::Number.decimal(2) }
    registration_start { Time.now + 1.days }
    registration_end   { Time.now + 15.days }
    max_registrations  { Faker::Number.number 2 }

    factory :series_with_events do
      transient do
        events_count { 2 }
      end

      after(:create) do |series, evaluator|
        create_list(:event, evaluator.events_count, series: series)
      end
    end

    factory :series_with_registrations do
      transient do
        registration_count { 2 }
      end

      after(:create) do |series, evaluator|
        create_list(:registration_with_stubbed_user, evaluator.registration_count, series: series)
      end
    end
  end
end
