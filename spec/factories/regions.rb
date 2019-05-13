# frozen_string_literal: true

FactoryBot.define do
  factory :region do
    name         { Faker::Nation.unique.capital_city }
    description  { Faker::Lorem.sentence }

    parent       { nil }
  end

  factory :super_region, class: Region do
    name         { Faker::Nation.unique.name }
    description  { Faker::Lorem.sentence }

    factory :super_region_with_subregions, class: Region do
      transient do
        sub_region_count { 2 }
      end

      after(:create) do |super_region, evaluator|
        create_list(:region, evaluator.sub_region_count, sub_regions: [super_region])
      end
    end
  end
end
