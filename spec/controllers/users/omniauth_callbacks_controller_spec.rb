require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe 'POST github' do
    before do
      OmniAuth.config.add_mock(:github, { uid: '12345', info: { email: 'wesleysafadao@garotasafada.com' } })
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    end

    it 'redirects to new organization path if organization_id is not set' do
      post :github

      expect(response).to redirect_to(new_organizations_url)
    end

    it 'redirects to root_url if user can be create' do
      organization = Organization.create!(name: 'Garota Safada')
      session['devise.organization_id'] = organization.id

      post :github

      expect(response).to redirect_to(root_url)
      expect(session['devise.organization_id']).to be_nil
    end

    it 'sets the organization owner if it is a new organization' do
      organization = Organization.create!(name: 'Garota Safada')
      session['devise.organization_id'] = organization.id

      post :github

      expect(response).to redirect_to(root_url)

      user = User.last
      expect(user.organization).to eq organization
      expect(organization.reload.owner).to eq user
    end

    it 'does not set the organization owner if it is not a new organization' do
      owner = User.create!(name: 'Foo', email: 'foo@bar.com', password: '12345678')
      organization = Organization.create!(name: 'Garota Safada', owner: owner)
      session['devise.organization_id'] = organization.id

      post :github

      expect(response).to redirect_to(root_url)

      user = User.last
      expect(user.organization).to eq organization
      expect(organization.reload.owner).not_to eq user
    end

    it 'redirects to new_users_url if user cannot be created' do
      organization = Organization.create!(name: 'Garota Safada')
      session['devise.organization_id'] = organization.id
      OmniAuth.config.add_mock(:github, { uid: '12345' })
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]

      post :github

      expect(response).to redirect_to(new_users_url)
      expect(session['devise.github_data']).to eq(request.env['omniauth.auth'])
    end
  end
end
