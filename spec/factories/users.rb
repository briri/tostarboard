# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name    { Faker::Name.unique.first_name }
    last_name     { Faker::Name.unique.last_name }
    email         { Faker::Internet.unique.safe_email }
    password      { 'password' }
    accept_terms  { true }

    roles         { [] }
    registrations { [] }
  end

  factory :user_with_vessel, parent: :user do
    vessel { create(:vessel) }
  end
end
