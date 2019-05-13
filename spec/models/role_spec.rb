# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  before(:each) do
    @role = build(:role)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it 'should validate that name is unique' do
      subject.name = 'Club Admin'
      is_expected.to validate_uniqueness_of(:name)
        .case_insensitive
        .with_message('has already been taken')
    end
  end

  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:users) }
  end
end
