# frozen_string_literal: true

def stub_api_token
	{ 'api_token': Faker::Crypto.sha256 }
end

# Parse response body as json
def body_to_json
  json = JSON.parse(@response.body)
end