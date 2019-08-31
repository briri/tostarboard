# frozen_string_literal: true

module Api::V1
  class RegionsController < ApiController

    before_action :find_region, only: [:show]

    # GET /api/v1/regions
    def index
      render json: { 'regions': Region.all.map { |region| region.to_json } }
    end

    # GET /api/v1/regions/:id
    def show
      @region.to_json
    end

    private

    def find_region
      @region = Region.where(id: params[:id]).first
      render nothing: true, status: :not_found unless @region.present?
    end

  end
end
