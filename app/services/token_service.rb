require 'digest'
require 'jwt'
require 'securerandom'

class TokenService

	class << self

	  # Encode a JSON Web Token
		def encode(payload, exp = 24.hours.from_now)
      return nil unless payload.present? && payload.respond_to?(:[])
     	payload[:exp] = exp.to_i
    	JWT.encode(payload, Rails.application.secrets.secret_key_base)
  	end

  	# Decode the JSON Web Token
   	def decode(token)
    	body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
     	HashWithIndifferentAccess.new body
   	rescue
     	nil
   	end

   	# Used to create a unique client_secret
    def generate_digest(payload)
    	return nil unless payload.respond_to?(:[]) && payload.has_key?(:email)
    	Digest::SHA256.digest(payload.merge({ secret: generate_secret }).to_s)
    end

    def generate_secret
    	SecureRandom.uuid
    end

  end

end
