# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Region, type: :model do
  before(:each) do
    @region = create(:region)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it 'should validate that name is unique' do
      subject.name = 'Nowhere'
      is_expected.to validate_uniqueness_of(:name)
        .case_insensitive
        .with_message('has already been taken')
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:parent) }
    it { is_expected.to have_many(:sub_regions) }
  end
end
