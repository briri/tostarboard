# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    club
    name               { Faker::Lorem.unique.word }
    description        { Faker::Lorem.paragraph }
    instructions       { Faker::Lorem.paragraph }
    start_on           { Time.now + 30.days }
    end_on             { Time.now + 31.days }
    registration_start { Time.now + 1.days }
    registration_end   { Time.now + 15.days }
    max_registrations  { Faker::Number.number 2 }

    factory :event_with_registrations do
      transient do
        registration_count { 2 }
      end

      after(:create) do |event, evaluator|
        create_list(:registration_with_stubbed_user, evaluator.registration_count, event: event)
      end
    end
  end

  factory :race, parent: :event do
    transient do
      results_count { 2 }
    end

    after(:create) do |event, evaluator|
      #create_list(:race_result, evaluator.results_count, race: event)
    end
  end
end
