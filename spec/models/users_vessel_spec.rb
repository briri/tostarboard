# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersVessel, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:vessel) }
    it { is_expected.to validate_presence_of(:role) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:vessel) }
  end
end
