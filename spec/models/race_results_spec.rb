# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RaceResult, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:start_on) }
    it { is_expected.to validate_presence_of(:end_on) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:vessel) }
    it { is_expected.to belong_to(:race) }
  end
end
