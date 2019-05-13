# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Club, type: :model do
  before(:each) do
    @club = build(:club)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:type) }

    it 'should validate that name is unique' do
      subject.name = Faker::Movies::HitchhikersGuideToTheGalaxy.unique.planet
      is_expected.to validate_uniqueness_of(:name)
        .case_insensitive
        .with_message('has already been taken')
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:admins) }
    it { is_expected.to belong_to(:region) }
  end
end
