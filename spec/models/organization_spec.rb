require 'rails_helper'

RSpec.describe Organization, type: :model do
  it 'requires the name' do
    expect(Organization.new(name: nil)).not_to be_valid
  end

  describe '#set_owner!' do
    it 'sets the owner to the user if owner is not set' do
      organization = Organization.create!(name: 'Garota Safada')
      user = User.create!(name: 'Wesley Safadao', email: 'wesleysafadao@garotasafada.com', password: '12345678')

      expect {
        organization.set_owner!(user)
      }.to change { organization.reload.owner_id }.from(nil).to(user.id)

      expect(user.reload.organization_id).to eq organization.id
    end

    it 'raises an exception when organization already has a owner' do
      owner = User.create!(name: 'Foo', email: 'foo@bar.com', password: '12345678')
      organization = Organization.create!(name: 'Garota Safada', owner: owner)
      user = User.create!(name: 'Wesley Safadao', email: 'wesleysafadao@garotasafada.com', password: '12345678')

      expect {
        organization.set_owner!(user)
      }.to raise_error(Organization::AlreadyHasOwnerError, 'Organization already has an owner')
    end
  end
end
