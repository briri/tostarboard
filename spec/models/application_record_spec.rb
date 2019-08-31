# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do

  before(:each) do
    @model = create(:region)
  end

  describe '#to_hateoas' do
    before(:each) do
      @hateoas = JSON.parse(@model.to_hateoas)
    end

    it 'returns the default relationship' do
      expect(@hateoas['rel']).to eql('self')
    end

    it 'returns the correct relationship' do
      hateoas = JSON.parse(@model.to_hateoas('tested_by'))
      expect(hateoas['rel']).to eql('tested_by')
    end

    it 'returns the correct href' do
      expect(@hateoas['href']).to eql("http://localhost:3000/api/v1/regions/#{@model.id}")
    end
  end

  describe '#to_json' do
    before(:each) do
      @json = @model.to_json
    end

    it 'returns the default attributes' do
      expect(@json['id']).to eql(@model.id)
      expect(@json['created_at']).to eql(@model.created_at.strftime("%FT%T.%3NZ"))
    end

    it 'returns a links section with the hateoas' do
      expect(@json['links'].first).to eql(JSON.parse(@model.to_hateoas))
    end

    it 'does not return attributes we do not specify' do
      expect(@json['updated_at'].present?).to eql(false)
    end

    it 'returns attributes we specify' do
      # We're using Region here for testing so see its definition for the attributes
      expect(@json['name']).to eql(@model.name)
      expect(@json['description']).to eql(@model.description)
    end
  end
end
