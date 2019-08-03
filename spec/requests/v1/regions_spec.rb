# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegionsController, type: :request do

	before(:each) do
		user = create(:user)
		@regions = (0..1).map { create(:region) }
		@valid_keys = [:id, :name, :description, :parent_id, :created_at, :updated_at]
		@headers = { headers: { 'api_token': user.api_token } }
	end

  describe 'GET /regions' do
		before(:each) { get api_v1_regions_path, @headers }
      
  	it "returns http success" do
      expect(@response).to have_http_status(:success)
    end
    it "JSON body response contains expected regions" do
      expect(body_to_json.first.keys).to match_array(@valid_keys)
    end
  end

  describe 'GET /region/:id' do
  	before(:each) { get api_v1_regions_path(@regions.first.id), @headers }

  	context 'known id' do
	  	it "returns http success" do
	      expect(@response).to have_http_status(:success)
	    end
	    it "JSON body response contains expected regions" do
	      expect(body_to_json.first.keys).to match_array(@valid_keys)
	      expect(body_to_json.first['name']).to eql(@regions.first.name)
	    end
	  end

    context 'unknown id' do
    	before(:each) { get api_v1_regions_path(999999), @headers }

	    it 'returns http not found' do
	    	expect(@response).to have_http_status(:not_found)
	    end
	    it "JSON body response contains nothing" do
	      expect(@response.body).to eql(nil)
	    end
	  end

  end

end