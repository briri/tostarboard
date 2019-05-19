# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Series, type: :model do
  before(:each) do
    @series = create(:series_with_events, club: create(:yacht_club))
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:club) }
    it { is_expected.to validate_presence_of(:registration_start) }
    it { is_expected.to validate_presence_of(:registration_end) }
    it { is_expected.to validate_numericality_of(:max_registrations) }

    it 'should validate that name is unique' do
      subject.name = Faker::Movies::HitchhikersGuideToTheGalaxy.unique.planet
      is_expected.to validate_uniqueness_of(:name)
        .case_insensitive
        .with_message('has already been taken')
    end

    it 'should validate that registration_start must be in the future' do
      @series.registration_start = Time.now - 2.days
      expect(@series.validate).to eql(false)
      expect(@series.errors[:registration_start].first).to eql('cannot start in the past')
    end

    it 'should validate that registration_start must be before registration_end' do
      @series.registration_start = Time.now + 3.days
      @series.registration_end = Time.now + 1.days
      expect(@series.validate).to eql(false)
      expect(@series.errors[:registration_start].first).to eql('cannot start before it ends')
    end

    it 'should validate that registration_end must be before start_on' do
      @series.registration_end = Time.now + 3.days
      @series.events.order(start_on: :asc).update_all(start_on: Time.now + 1.days)
      expect(@series.validate).to eql(false)
      expect(@series.errors[:registration_end].first).to eql('must end before the event begins')
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:club) }
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_many(:registrations) }
  end

  context 'instance methods' do
    it 'should validate that start_on returns the start_on of the first event' do
      first_event = @series.events.order(start_on: :asc).first
      expect(@series.start_on).to eql(first_event.start_on)
    end

    it 'should validate that end_on returns the end_on of the last event' do
      last_event = @series.events.order(end_on: :desc).first
      expect(@series.end_on).to eql(last_event.end_on)
    end
  end
end
