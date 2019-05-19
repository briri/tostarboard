# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Race, type: :model do
  context 'inheritence' do
    it { expect(described_class).to be < Event }
  end

  context 'associations' do
    it { is_expected.to have_many(:race_results) }
  end
end
