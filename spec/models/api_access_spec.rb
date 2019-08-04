# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiAccess, type: :model do
  before(:each) do
    user = create(:user)
    user.api_credentials!

    @api_access = create(:api_access, user: user)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:access_token) }
    it { is_expected.to validate_uniqueness_of(:access_token) }
    it { is_expected.to validate_presence_of(:expiry_date) }
    
    it 'should validate that expiry_date must be in the future' do
      @api_access.expiry_date = Time.now - 2.days
      expect(@api_access.validate).to eql(false)
      expect(@api_access.errors[:expiry_date].first).to eql('can\'t be in the past')
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
