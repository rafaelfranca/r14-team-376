module ControllerMacros
  def login_user
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.create!(name: 'Wesley Safadao', email: 'wesleysafadao@garotasafada.com', password: '12345678', password_confirmation: '12345678')
      sign_in @user
    end
  end
end
