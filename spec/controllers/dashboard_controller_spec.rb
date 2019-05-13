# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET show' do
    it 'requires user to be logged in' do
      get :show
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'renders the show template' do
      sign_in create(:user)
      get :show
      expect(response).to render_template('show')
    end
  end
end
