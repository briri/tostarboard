# frozen_string_literal: true

def stub_api_tokens(user:)
	return {} unless user.present?
	user.api_credentials!
end

# Parse response body as json
def body_to_json
  json = JSON.parse(@response.body)
end