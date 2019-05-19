# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rating, type: :model do
  before(:each) do
    @rating = create(:rating)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:boat_type) }
    it { is_expected.to validate_numericality_of(:rating) }
    it { is_expected.to validate_numericality_of(:sail_plan_i) }
    it { is_expected.to validate_numericality_of(:sail_plan_j) }
    it { is_expected.to validate_numericality_of(:sail_plan_p) }
    it { is_expected.to validate_numericality_of(:sail_plan_e) }
    it { is_expected.to validate_numericality_of(:sail_plan_py) }
    it { is_expected.to validate_numericality_of(:sail_plan_ey) }
    it { is_expected.to validate_numericality_of(:displacement) }
    it { is_expected.to validate_numericality_of(:length_water_line) }
    it { is_expected.to validate_numericality_of(:draft) }

    it 'should validate that boat_type is unique' do
      subject.boat_type = Faker::Lorem.unique.word
      is_expected.to validate_uniqueness_of(:boat_type)
        .case_insensitive
        .with_message('has already been taken')
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:vessels) }
  end
end
