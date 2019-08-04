# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TokenService, type: :model do
  
	before(:each) do
		@user = create(:user)
		@user.api_credentials!
	end

  describe :encode do

  	it 'returns a token' do
  		expect(TokenService.encode(@user.to_json).is_a?(String)).to eql(true)
  	end

  	it 'returns nil if the payload is empty' do
  		expect(TokenService.encode(nil)).to eql(nil)
  	end

  	it 'has a default expiry date' do
  		token = TokenService.encode(@user.to_json)
  		payload = TokenService.decode(token)
  		expect(payload[:exp].is_a?(Time)).to eql(true)
  	end

  	it 'accepts an expiry date' do
  		date = Date.new(Date.today + 2.hours)
  		token = TokenService.encode(@user.to_json, date)
  		payload = TokenService.decode(token)
  		expect(payload[:exp]).to eql(date)
  	end
  end

  describe :decode do
  	it 'decodes the token' do

  	end

  	it 'returns nil if there is an error' do

  	end
  end

  describe :generate_digest do
  	it 'generates a unique digest for the same user' do
  		a = TokenService.generate_digest(@user.to_json)
  		expect(TokenService.generate_digest(@user.to_json)).not_to eql(a)
  	end

  	it 'generates a unique digest for different users' do
  		user_b = create(:user)
  		user_b.api_credentials!
  		expect(TokenService.generate_digest(@user.to_json))
  			.not_to eql(TokenService.generate_digest(user_b.to_json))
  	end

  	it 'returns nil if the user has no email' do
  		@user.email = nil
  		expect(TokenService.generate_digest(@user.to_json)).to eql(nil)
  	end
  end

  describe :generate_secret do
  	it 'returns unique secrets' do
  		a = TokenService.generate_secret
  		expect(TokenService.generate_secret).not_to eql(a)
  	end
  end
end
