require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#first_or_create_from_github' do
    it 'creates a new user with the GitHub information if it does not exist' do
      info = double('info', name: 'Wesley Safadao', email: 'wesleysafadao@garotasafada.com', image: 'image.png')
      auth = double('auth', provider: 'GitHub', uid: '1', info: info)

      expect {
        User.first_or_create_from_github(auth)
      }.to change { User.count }.by(1)

      user = User.last

      expect(user.provider).to eq('GitHub')
      expect(user.uid).to eq('1')
      expect(user.name).to eq('Wesley Safadao')
      expect(user.email).to eq('wesleysafadao@garotasafada.com')
      expect(user.image).to eq('image.png')
    end
  end
end
