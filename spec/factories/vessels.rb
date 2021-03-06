# frozen_string_literal: true

FactoryBot.define do
  factory :vessel do
    rating       {}
    name         { Faker::Lorem.word }
    sail_number  { Faker::Alphanumeric.alphanumeric 4 }
    make         { Faker::Lorem.word }
    model        { Faker::Lorem.word }
    length       { Faker::Number.decimal 1 }
    beam         { Faker::Number.decimal 1 }
    draft        { Faker::Number.decimal 1 }

    factory :vessel_with_owner do
      after(:create) do |vessel, evaluator|
        create_list(:crew, evaluator.crew_count, vessel: vessel, user: create(:user), role: :owner)
      end
    end

    factory :vessel_with_crew do
      transient do
        crew_count { 2 }
      end

      after(:create) do |vessel, evaluator|
        create_list(:crew, evaluator.crew_count, vessel: vessel, user: create(:user), role: :crew)
      end
    end
  end
end
