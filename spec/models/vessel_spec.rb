# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vessel, type: :model do
  before(:each) do
    @vessel = create(:vessel, owner: create(:user))
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:owner) }
  end

  context 'associations' do
  	it { is_expected.to belong_to(:owner) }
  	it { is_expected.to belong_to(:rating) }
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:race_results) }
  end
end
