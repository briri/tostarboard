# frozen_string_literal: true

module Api::V1
  class ApiController < ApplicationController
    
    respond_to :json

    before_action :authenticate_user_from_token!, :parse_request

    private
       
    def authenticate_user_from_token!
      if @json.nil? || !@json.has_key?('api_token')
        render json: empty_response, status: :unauthorized
      end

      @user = nil
      User.find_each do |user|
        @user = user if Devise.secure_compare(user.api_token, @json['api_token'])
      end
    end

    def parse_request
      @json = JSON.parse(@request.body.read)
    end

    def empty_response
      [{}].to_json
    end

  end
end
