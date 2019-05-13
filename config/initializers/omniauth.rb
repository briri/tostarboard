# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           scope: 'email',
           display: 'popup'

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           scope: 'userinfo.email',
           prompt: 'select_account',
           image_aspect_ratio: 'square',
           image_size: 50
end
