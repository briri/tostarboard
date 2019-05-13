# frozen_string_literal: true

# Base controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # When we are in production reroute Record Not Found errors to the 404 page
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found if Rails.env.production?

  private

  def user_not_authorized
    if user_signed_in?
      redirect_to dashboard_path, alert: 'You are not authorized to perform this action.'
    else
      redirect_to root_url, alert: 'You need to sign in or sign up before continuing.'
    end
  end

  # rubocop:disable Metrics/AbcSize
  def after_sign_in_path_for(_resource)
    referer_path = URI(request.referer).path unless request.referer.nil?
    return dashboard_path if from_external_domain? || referer_path.eql?(new_user_session_path) ||
                             referer_path.eql?(new_user_registration_path) || referer_path.nil?

    request.referer
  end
  # rubocop:enable Metrics/AbcSize

  def after_sign_up_path_for(_resource)
    referer_path = URI(request.referer).path unless request.referer.nil?
    return dashboard_path if from_external_domain? || referer_path.eql?(new_user_session_path) ||
                             referer_path.nil?

    request.referer
  end

  def after_sign_in_error_path_for(_resource)
    (from_external_domain? ? root_path : request.referer || root_path)
  end

  def after_sign_up_error_path_for(_resource)
    (from_external_domain? ? root_path : request.referer || root_path)
  end

  def authenticate_super_admin!
    # currently if admin has any super-admin task, they can view the super-admin
    redirect_to dashboard_path unless user_signed_in? &&
                                      user.roles.includes?(Role.find_by(name: 'super_admin'))
  end

  def authenticate_club_admin!
    # currently if admin has any super-admin task, they can view the super-admin
    redirect_to dashboard_path unless user_signed_in? &&
                                      user.roles.includes?(Role.find_by(name: 'club_admin'))
  end

  def from_external_domain?
    if request.referer.present?
      referer = URI.parse(request.referer)
      home = URI.parse(root_url)
      referer.host != home.host
    else
      false
    end
  end
end
