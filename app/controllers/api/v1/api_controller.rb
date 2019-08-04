# frozen_string_literal: true

module Api::V1
  class ApiController < ApplicationController
    
    respond_to :json

    before_action :parse_request
    before_action :authenticate_user_from_token!, except: %[create]

    # User authentication route
    # POST /api/v1/auth
    def create
      if @json.nil? || !@json.has_key?('client_token') || !@json.has_key?('client_secret')
        render json: empty_response, status: :bad_request
      end

      user = User.find_by(client_token: @json['client_token'])
      if user.present? && Devise.secure_compare(user.client_secret, @json['client_secret'])
        render ApiTokenService.encode(payload: user), status: :ok
      else
        render empty_response, status: :unauthorized
      end
    end

    private
       
    def authenticate_user_from_token!
      if @json.nil? || !@json.has_key?('access_token')
        render json: empty_response, status: :unauthorized
      end

      user = ApiAccess.find_by(access_token: @json['access_token'])
      return true if user.present? && TokenService.decode(token: @json['access_token'])
      false
    end

    def parse_request
      @json = JSON.parse(@request.body.read)
    end

    def empty_response
      [{}].to_json
    end

  end
end
