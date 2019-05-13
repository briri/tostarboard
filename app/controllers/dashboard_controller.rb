# frozen_string_literal: true

# User dashboard controller
class DashboardController < ApplicationController
  before_action :authenticate_user!

  # GET /dashboard
  def show; end
end
