# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Club, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:category) }

    it 'should validate that name is unique' do
      subject.name = Faker::Movies::HitchhikersGuideToTheGalaxy.unique.planet
      is_expected.to validate_uniqueness_of(:name)
        .case_insensitive
        .with_message('has already been taken')
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:admins) }
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_many(:series) }
    it { is_expected.to belong_to(:region) }
  end

  context 'instance methods' do
    before(:each) do
      @club = build(:club)
    end

    describe '#to_json' do
      before(:each) do
        @event = build(:event)
        @series = build(:series)
        @club.events << @event unless @club.events.any?
        @club.series << @series unless @club.series.any?
        @club.save
        @json = @club.reload.to_json
      end

      it 'returns the fields we expect' do

p #@club.categories.keys
p @club.inspect
p @json

        expect(@json['name']).to eql(@club.name)
        expect(@json['category']).to eql(@club.category)
        expect(@json['description']).to eql(@club.description)
        expect(@json['url']).to eql(@club.url)
        expect(@json['contact_email']).to eql(@club.contact_email)
      end

      it 'returns the region' do
        expect(@json['region']).to eql(JSON.parse(@club.region.to_hateoas('part_of')))
      end

      it 'returns the events' do
        expected = JSON.parse(@event.to_hateoas('sponsor_of'))
        expect(@json['events'].first).to eql(expected)
      end

      it 'returns the series' do
        expected = JSON.parse(@series.to_hateoas('sponsor_of'))
        expect(@json['series'].first).to eql(expected)
      end
    end
  end
end
