# frozen_string_literal: true

module Api::V1
  class VesselsController < ApiController

    before_filter :validate_request, only: [:show, :update, :create]
    before_filter :validate_payload, only: [:update, :create]
    before_filter :find_region, only: [:show, :update]

    # GET /api/v1/regions
    def index
      Region.all.map { |region| region.to_json }
    end

    # GET /api/v1/region/:id
    def show
      @region.to_json
    end

    # POST /api/v1/regions
    def create
      render nothing: true, status: :conflict if already_exists?
    
      if region.create(@json['region'])
        render json: region.to_json, status: :ok
      else
        render nothing: true, status: :bad_request
      end
    end

    # PUT /api/v1/region/:id
    def update
      if @region.update(@json['region'])
        render json: region.to_json, status: :ok
      else
        render nothing: true, status: :bad_request
      end
    end

    private

    def validate_request
      render nothing: true, status: :bad_request unless @json.has_key?('region')
    end

    def validate_payload
      render nothing: true, status: :bad_request unless @json['region'].responds_to?(:[])
      render nothing: true, status: :bad_request unless @json['region'].has_key?('name')
    end

    def find_region
      @region = Region.where(id: params[:id]).first
      render nothing: true, status: :not_found unless @region.present?
    end

    def already_exists?
      # If an `id` was passed in or we already have a region with that name
      Region.where(name: @json['region']['name']).any? || @json['region'].has_key?('id')
    end

  end
end
