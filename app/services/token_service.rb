require 'digest'
require 'securerandom'

class TokenService

  # Generate SHA256 hash
  def self.generate_digest(val)
		Digest::SHA256.hexdigest(val)
	end

	# Generate UUID
	def self.generate_uuid
		SecureRandom.uuid.split('-').join
	end

end
