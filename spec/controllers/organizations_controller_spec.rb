require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'POST create' do
    it 'redirects to root_url if organization can be create' do
      post :create, organization: { name: 'Garota Safada' }

      expect(response).to redirect_to(root_url)
    end

    it 'renders new if organization cannot be created' do
      post :create, organization: { name: '' }

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end
end
