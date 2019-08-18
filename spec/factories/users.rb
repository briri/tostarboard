# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name    { Faker::Name.unique.first_name }
    last_name     { Faker::Name.unique.last_name }
    email         { Faker::Internet.unique.safe_email }
    password      { 'password' }
    accept_terms  { true }

    oauth_applications { [] }
    access_grants { [] }
    access_tokens { [] }

    roles         { [] }
    registrations { [] }
  end

  factory :user_who_owns_vessel, parent: :user do
    crew   { create(:crew, user: self, vessel: create(:vessel), role: :owner) }
  end
end
