# frozen_string_literal: true

FactoryBot.define do
  factory :club do
    name           { Faker::Movies::HitchhikersGuideToTheGalaxy.unique.planet }
    description    { Faker::Lorem.paragraph }
    type           { 'yacht_club' }
    region         { create(:region) }

    factory :club_with_events do
      transient do
        events_count { 2 }
      end

      after(:create) do |club, evaluator|
        create_list(:event, evaluator.events_count, club: club)
      end
    end

    factory :club_with_series do
      transient do
        series_count { 2 }
      end

      after(:create) do |club, evaluator|
        create_list(:series_with_events, evaluator.series_count, club: club)
      end
    end

    factory :club_with_series_and_events do
      club_with_series
      club_with_events
    end
  end

  factory :yacht_club, parent: :club, class: YachtClub do
    type         { 'yacht_club' }
  end

  factory :sailing_association, parent: :club, class: SailingAssociation do
    type         { 'sailing_association' }
  end
end
