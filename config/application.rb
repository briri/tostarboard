# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tostarboard
  # The application base class
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 5.2
    config.load_defaults "6.0"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # enforce HTTPS connections throughout your application.
    config.force_ssl
    # If you need to exempt certain endpoints from redirection, you can use 
    # config.ssl_options to configure that behavior.
    # config.ssl_options = []

    # Load all services
    config.eager_load_paths << "app/services"

    # Load application YAML config
    config.x.branding = config_for(:branding)

    config.to_prepare do
      # Only Applications list
      Doorkeeper::ApplicationsController.layout 'application'

      # Only Authorization endpoint
      # Doorkeeper::AuthorizationsController.layout 'application'

      # Only Authorized Applications
      # Doorkeeper::AuthorizedApplicationsController.layout 'application'
    end
  end
end
