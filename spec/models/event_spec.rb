# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do
    #@club = build(:club_with_events)
    @event = build(:event)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_on) }
    it { is_expected.to validate_presence_of(:end_on) }
    it { is_expected.to validate_presence_of(:club) }
    it { is_expected.to validate_presence_of(:series) }

    it 'should validate that name is unique' do
      subject.name = Faker::Movies::HitchhikersGuideToTheGalaxy.unique.planet
      is_expected.to validate_uniqueness_of(:name)
        .case_insensitive
        .with_message('has already been taken')
    end

    it 'should validate that start_on must be in the future' do
      @event.start_on = Faker::Time.forward(-2, :morning)
      expect(@event.validate).to eql(false)
      expect(@event.errors[:start].first).to eql('cannot start in the past')
    end

    it 'should validate that start_on must be before end_on' do
      @event.start_on = Faker::Time.forward(5, :morning)
      @event.end_on = Faker::Time.forward(1, :morning)
      expect(@event.validate).to eql(false)
      expect(@event.errors[:start].first).to eql('cannot start before it ends')
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:club) }
    it { is_expected.to belong_to(:series) }
    it { is_expected.to have_many(:registrations) }
  end
end
