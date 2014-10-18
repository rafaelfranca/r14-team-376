require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe 'GET new' do
    it 'redirects to new organization path if organization_id is not set' do
      get :new

      expect(response).to redirect_to(new_organizations_url)
    end

    it 'renders new if organization_id is set' do
      organization = Organization.create!(name: 'Garota Safada')
      session['devise.organization_id'] = organization.id

      get :new

      expect(response).to render_template(:new)
    end
  end
end

