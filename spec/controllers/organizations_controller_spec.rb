require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'POST create' do
    it 'redirects to new_users_url if organization can be create' do
      post :create, organization: { name: 'Garota Safada' }

      organization = Organization.last
      expect(session['devise.organization_id']).to eq organization.id
      expect(response).to redirect_to(new_users_url)
    end

    it 'renders new if organization cannot be created' do
      post :create, organization: { name: '' }

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET show' do
    context 'not logged in' do
      it 'redirects to login url if user is not logged in' do
        get :show, organization_id: 1

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'logged in' do
      login_user

      it 'renders 404 if organization does not exist' do
        expect {
          get :show, organization_id: 1
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'renders 404 if organization is not the same of the current user' do
        owner = User.create!(name: 'Foo', email: 'foo@bar.com', password: '12345678')
        organization = Organization.create!(name: 'Garota Safada', owner: owner)

        expect {
          get :show, organization_id: organization.id
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'renders show page if user has access to the organization' do
        organization = Organization.create!(name: 'Garota Safada')
        @user.update(organization: organization)

        get :show, organization_id: organization.id

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end
    end
  end
end
