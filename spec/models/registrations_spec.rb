# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Registration, type: :model do
  before(:each) do
    @registration = build(:registration)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:series) }
    it { is_expected.to validate_presence_of(:event) }
    it { is_expected.to validate_presence_of(:paid) }

    it 'should validate that invoice_id is unique' do
      subject.invoice_id = Faker::Alphanumeric.unique.alphanumeric 10
      is_expected.to validate_uniqueness_of(:invoice_id).with_message('has already been taken')
    end

    # rubocop:disable Style/Semicolon
    context 'paid' do
      it { subject.paid = true; is_expected.to validate_presence_of(:invoice_id) }
      it { subject.paid = true; is_expected.to validate_presence_of(:paid_on) }
    end
    # rubocop:enable Style/Semicolon
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:series) }
    it { is_expected.to belong_to(:event) }
  end
end
