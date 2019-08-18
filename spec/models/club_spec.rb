# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Club, type: :model do
  before(:each) do
    @club = build(:club)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:club_type) }

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
    describe '#to_json' do
      before(:each) do
        @json = JSON.parse(@club.to_json)
      end

      it 'returns the fields we expect' do
        expect(@json['id']).to eql(@club.id)
        expect(@json['name']).to eql(@club.name)
        expect(@json['club_type']).to eql(@club.club_type)
        expect(@json['description']).to eql(@club.description)
        expect(@json['url']).to eql(@club.url)
        expect(@json['contact_email']).to eql(@club.contact_email)
      end
      it 'returns the associations we expect' do
        expect(@json['region'].respond_to?(:[])).to eql(true)
        expect(@json['region']['id']).to eql(@club.region.id)
      end
    end
  end
end
