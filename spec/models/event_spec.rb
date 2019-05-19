# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do
    @event = create(:event_with_registrations, club: create(:yacht_club))
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_on) }
    it { is_expected.to validate_presence_of(:end_on) }
    it { is_expected.to validate_presence_of(:club) }
    it { is_expected.to validate_presence_of(:series) }
    it { is_expected.to validate_presence_of(:registration_start) }
    it { is_expected.to validate_presence_of(:registration_end) }
    it { is_expected.to validate_numericality_of(:max_registrations) }

    it 'should validate that name is unique' do
      subject.name = Faker::Movies::HitchhikersGuideToTheGalaxy.unique.planet
      is_expected.to validate_uniqueness_of(:name)
        .case_insensitive
        .with_message('has already been taken')
    end

    it 'should validate that start_on must be in the future' do
      @event.start_on = Time.now - 2.days
      expect(@event.validate).to eql(false)
      expect(@event.errors[:start].first).to eql('cannot start in the past')
    end

    it 'should validate that start_on must be before end_on' do
      @event.start_on = Time.now + 3.days
      @event.end_on = Time.now + 1.days
      expect(@event.validate).to eql(false)
      expect(@event.errors[:start].first).to eql('cannot start before it ends')
    end

    it 'should validate that registration_start must be in the future' do
      @event.registration_start = Time.now - 2.days
      expect(@event.validate).to eql(false)
      expect(@event.errors[:registration_start].first).to eql('cannot start in the past')
    end

    it 'should validate that registration_start must be before registration_end' do
      @event.registration_start = Time.now + 3.days
      @event.registration_end = Time.now + 1.days
      expect(@event.validate).to eql(false)
      expect(@event.errors[:registration_start].first).to eql('cannot start before it ends')
    end

    it 'should validate that registration_end must be before start_on' do
      @event.registration_end = Time.now + 3.days
      @event.start_on = Time.now + 1.days
      expect(@event.validate).to eql(false)
      expect(@event.errors[:registration_end].first).to eql('must end before the event begins')
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:club) }
    it { is_expected.to belong_to(:series) }
    it { is_expected.to have_many(:registrations) }
  end
end
