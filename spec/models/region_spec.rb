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

  context '#to_json' do
    before(:each) do
      @prnt, @chld = create(:region), create(:region)
      @region.parent = @prnt unless @region.parent.present?
      @region.sub_regions << @chld unless @region.sub_regions.any?
      @region.save
      @json = @region.reload.to_json
    end

    it 'returns the attributes we expect' do
      expect(@json['name']).to eql(@region.name)
      expect(@json['description']).to eql(@region.description)
    end

    it 'returns the parent' do
      expect(@json['parent']).to eql(JSON.parse(@region.parent.to_hateoas('child_of')))
    end

    it 'returns the sub_regions' do
      expected = JSON.parse(@chld.to_hateoas('parent_to'))
      expect(@json['sub_regions'].first).to eql(expected)
    end
  end
end
