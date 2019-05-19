# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name         { 'crew' }
    description  { Faker::Lorem.sentence }

    trait :super_admin do
      name  { 'super_admin' }
    end
    trait :club_admin do
      name  { 'club_admin' }
    end
    trait :skipper do
      name  { 'skipper' }
    end
    trait :crew do
      name  { 'crew' }
    end
  end
end
