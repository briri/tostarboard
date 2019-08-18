# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vessel, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:sail_number) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:rating) }
    it { is_expected.to have_many(:users_vessels) }
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:race_results) }
  end

  context 'instance methods' do
    describe '#to_json' do
      before(:each) do
        @vessel = create(:vessel)
        @json = JSON.parse(@vessel.to_json)
      end

      it 'returns the fields we expect' do
        expect(@json['id']).to eql(@vessel.id)
        expect(@json['name']).to eql(@vessel.name)
        expect(@json['sail_number']).to eql(@vessel.sail_number)
        expect(@json['make']).to eql(@vessel.make)
        expect(@json['model']).to eql(@vessel.model)
        expect(@json['length']).to eql(@vessel.length)
        expect(@json['beam']).to eql(@vessel.beam)
        expect(@json['draft']).to eql(@vessel.draft)
      end
      it 'returns the associations we expect' do
        create(:users_vessel, vessel: @vessel, user: create(:user), role: 0)
        create(:users_vessel, vessel: @vessel, user: create(:user), role: 1)
        #create(:race_result, vessel: @vessel, race: create(:event))
        @vessel.update(rating: create(:rating))
        @json = JSON.parse(@vessel.reload.to_json)
        expect(@json['rating'].length).to eql(1)
        expect(@json['owners'].length).to eql(1)
        expect(@json['crew'].length).to eql(1)
        #expect(@json['race_results'].length).to eql(1)
      end
    end
  end
end
