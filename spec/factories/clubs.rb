# frozen_string_literal: true

FactoryBot.define do
  factory :club do
    name         { Faker::Movies::HitchhikersGuideToTheGalaxy.unique.planet }
    description  { Faker::Lorem.paragraph }
    type         { 'yacht_club' }
    region       { create(:region) }
  end

  factory :yacht_club, parent: :club, class: YachtClub do
    type         { 'yacht_club' }
  end

  factory :sailing_association, parent: :club, class: SailingAssociation do
    type         { 'sailing_association' }
  end
end
