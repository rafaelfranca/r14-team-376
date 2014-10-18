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

  describe 'POST create' do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it 'redirects to new organization path if organization_id is not set' do
      post :create, user: { name: 'Wesley Safadao', email: 'wesleysafadao@garotasafada.com', password: '12345678', password_confirmation: '12345678' }

      expect(response).to redirect_to(new_organizations_url)
    end

    it 'redirects to root_url if user can be create' do
      organization = Organization.create!(name: 'Garota Safada')
      session['devise.organization_id'] = organization.id

      post :create, user: { name: 'Wesley Safadao', email: 'wesleysafadao@garotasafada.com', password: '12345678', password_confirmation: '12345678' }

      expect(session['devise.organization_id']).to be_nil
      expect(response).to redirect_to(root_url)

      user = User.last
      expect(user.organization).to eq organization
      expect(organization.reload.owner).to eq user
    end

    it 'renders new if user cannot be created' do
      organization = Organization.create!(name: 'Garota Safada')
      session['devise.organization_id'] = organization.id

      post :create, user: { name: 'Wesley Safadao', email: 'wesleysafadao@garotasafada.com', password: '12345678', password_confirmation: '12345679' }

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end
end

