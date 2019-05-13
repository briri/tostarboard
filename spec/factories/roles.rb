# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name         { 'racer' }
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
    trait :racer do
      name  { 'racer' }
    end
  end
end
