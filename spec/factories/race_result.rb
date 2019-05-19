# frozen_string_literal: true

FactoryBot.define do
  factory :race_result do
    vessel
    race
    course        { Faker::Alpha.alpha 1 }
    start_on      { Time.now + 10.minutes }
    end_on        { Time.now + 70.minutes }
    dns           { false }
    dnf           { false }
    disqualified  { false }
    penalty       { 0.0 }

    factory :race_result_with_stubbed_user do
      user { create(:user) }
    end
  end
end
